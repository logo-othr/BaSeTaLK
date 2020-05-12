import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:basetalk/persistance/dto/topic_dto.dart';
import 'package:basetalk/persistance/helper/sftp_helper.dart';
import 'package:basetalk/persistance/repositorys/datasource/interfaces/i_topic_dto_repository.dart';
import 'package:basetalk/persistance/topic_path_provider.dart';
import 'package:ssh/ssh.dart';

class TopicDTORemoteSFTPRepository implements ITopicDTORepository {
  final SSHClient _sshClient;
  final String _remotePath;
  final TopicPathProvider _topicPathProvider;

  TopicDTORemoteSFTPRepository(
      this._sshClient, this._remotePath, this._topicPathProvider);

  @override
  Future<List<TopicDTO>> getAllTopicDTOs({requestRefresh = false}) async {
    try {
      await downloadFromSFTP(_sshClient, ["topics.json"], _remotePath,
          _topicPathProvider.appCacheRootPath,
          callback: null);
    } on Exception catch (e) {
      print("SFTP ERROR: " + e.toString());
    }

    File file = File(_topicPathProvider.appCacheRootPath + "topics.json");

    if (!await file.exists()) return null;
    String jsonString = await file.readAsString();

    List<TopicDTO> topicDtos = (jsonDecode(jsonString) as List)
        .map((i) => TopicDTO.fromJson(i))
        .toList();
    return topicDtos;
  }

  @override
  Future<TopicDTO> getTopicDTOById(int topicId) async {
    TopicDTO result;
    List<TopicDTO> topics = await getAllTopicDTOs();
    for (TopicDTO topicDTO in topics) {
      if (topicDTO.id == topicId) result = topicDTO;
    }
    return result;
  }

  @override
  Future<List<TopicDTO>> getTopicDTOByIds(List<int> topicIds) {
    // TODO: implement getTopicDTOByIds
    throw UnimplementedError();
  }
}

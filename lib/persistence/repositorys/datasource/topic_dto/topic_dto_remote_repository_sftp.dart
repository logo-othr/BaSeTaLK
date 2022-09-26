import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:basetalk/domain/exceptions/topic_parse_exception.dart';
import 'package:basetalk/persistence/dto/topic_dto.dart';
import 'package:basetalk/persistence/helper/sftp_helper.dart';
import 'package:basetalk/persistence/repositorys/datasource/interfaces/i_topic_dto_repository.dart';
import 'package:basetalk/persistence/topic_path_provider.dart';
import 'package:ssh/ssh.dart';

class TopicDTORemoteSFTPRepository implements ITopicDTORepository {
  final SSHClient _sshClient;
  final String _remotePath = "share/";
  final TopicPathProvider _topicPathProvider;

  TopicDTORemoteSFTPRepository(this._sshClient, this._topicPathProvider);

  @override
  Future<List<TopicDTO>> getAllTopicDTOs({requestRefresh = false}) async {
    try {
      await downloadFromSFTP(
          ["topics.json"], _remotePath, _topicPathProvider.appCacheRootPath,
          callback: null);
    } on Exception catch (e) {
      print("SFTP ERROR: " + e.toString());
    }

    File file = File(_topicPathProvider.appCacheRootPath + "topics.json");

    if (!await file.exists()) return null;
    String jsonString = await file.readAsString();

    List<TopicDTO> topicDtos = (jsonDecode(jsonString) as List).map((i) {
      try {
        return TopicDTO.fromJson(i);
      } on TypeError catch (e) {
        throw TopicParseException(e.toString(), i.toString());
      }
    }).toList();
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

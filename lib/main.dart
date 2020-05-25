import 'dart:async' show Future;
import 'dart:convert';

import 'package:basetalk/domain/usecases/download_topic_data_usecase.dart';
import 'package:basetalk/domain/usecases/getListOfAllTopics.dart';
import 'package:basetalk/domain/usecases/get_topic_thumbnails_usecase.dart';
import 'package:basetalk/domain/usecases/sort_topic_list_to_fav_first.dart';
import 'package:basetalk/domain/usecases/toggle_topic_favorite_usecase.dart';
import 'package:basetalk/domain/usecases/toggle_topic_visited_usecase.dart';
import 'package:basetalk/domain/usecases/topics_to_viewmodels.dart';
import 'package:basetalk/persistance/mapper/TopicMapper.dart';
import 'package:basetalk/persistance/repositorys/datasource/media/media_local_repository_file.dart';
import 'package:basetalk/persistance/repositorys/datasource/media/media_remote_repository_sftp.dart';
import 'package:basetalk/persistance/repositorys/datasource/topic_dto/cached_topic_dto_repository.dart';
import 'package:basetalk/persistance/repositorys/datasource/topic_dto/topic_dto_local_repository_file.dart';
import 'package:basetalk/persistance/repositorys/datasource/topic_dto/topic_dto_remote_repository_sftp.dart';
import 'package:basetalk/persistance/repositorys/datasource/topic_userinformation/topic_user_information_dto_repository.dart';
import 'package:basetalk/persistance/repositorys/media_repository.dart';
import 'package:basetalk/persistance/repositorys/topic_repository.dart';
import 'package:basetalk/persistance/sftp_auth.dart';
import 'package:basetalk/persistance/topic_path_provider.dart';
import 'package:basetalk/presentation/viewmodel/topic_list_view_model.dart';
import 'package:basetalk/route_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:ssh/ssh.dart';

import 'presentation/view/colors.dart';

const String _AppName = 'Appname';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) async {
    var sshClient = await setUpSFTP();
    String remotePath = "ftp/files/";
    var topicPathProvider = new TopicPathProvider();
    await topicPathProvider.init();

    var remoteTopicRepository = new TopicDTORemoteSFTPRepository(
        sshClient, remotePath, topicPathProvider);
    var localTopicRepository =
        new TopicDTOLocalFileRepository(topicPathProvider);
    var cachedTopicRepository = new CachedTopicDTORepository(
        remoteTopicRepository, localTopicRepository);

    var localTopicUserInformationRepository =
        new TopicUserInformationDTORepository();

    var topicMapper = new TopicMapper();
    var topicRepository = new TopicRepository(
        topicDTORepository: cachedTopicRepository,
        topicUserInformationDTORepository: localTopicUserInformationRepository,
        topicMapper: topicMapper);
    var getAllTopics = new GetListOfAllTopicsUseCase(topicRepository);
    var sortTopicListToFavFirst = new SortTopicListToFavFirstUseCase();
    var mediaRemoteRepository = new MediaRemoteSFTPRepository(
        sshClient, remotePath, topicPathProvider.topicMediaRootPath);
    var mediaCacheRepository = new MediaLocalFileRepository();
    var mediaRepository =
        new MediaRepository(mediaRemoteRepository, mediaCacheRepository);
    var getTopicThumbnails = new GetTopicThumbnailsUseCase(mediaRepository);
    var toggleTopicVisited = new ToggleTopicVisitedUseCase(topicRepository);
    var toggleTopicFavorite = new ToggleTopicFavoriteUsecase(topicRepository);
    var topicsToViewModels = new TopicsToViewModelsUseCase();
    var downloadTopicData =
        new DownloadTopicDataUseCase(mediaRepository, topicRepository);
    var topicListViewModel = new TopicListViewModel(
        getAllTopics,
        sortTopicListToFavFirst,
        getTopicThumbnails,
        toggleTopicVisited,
        toggleTopicFavorite,
        topicsToViewModels,
        downloadTopicData);
    await topicListViewModel.init();
    runApp(new MyApp(topicListViewModel, topicPathProvider));
  });
}

Future<SSHClient> setUpSFTP() async {
  String jsonString = await loadSFTPAuth();
  var map = jsonDecode(jsonString);
  SFTPAuth sftpAuth = SFTPAuth.fromJson(map);
  var sshClient = new SSHClient(
    host: sftpAuth.host,
    port: int.parse(sftpAuth.port),
    username: sftpAuth.username,
    passwordOrKey: sftpAuth.passwordOrKey,
  );
  return sshClient;
}

Future<String> loadSFTPAuth() async {
  return await rootBundle.loadString('assets/sftp_auth.json');
}



class MyApp extends StatelessWidget {
  final TopicListViewModel topicListViewModel;
  final TopicPathProvider topicPathProvider;

  MyApp(this.topicListViewModel, this.topicPathProvider);

  @override
  Widget build(BuildContext context) {
    RouteService routeService = RouteService(topicListViewModel);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TopicListViewModel>.value(
            value: topicListViewModel),
        Provider<TopicPathProvider>.value(value: topicPathProvider)
      ],
      child: MaterialApp(
        title: _AppName,
        onGenerateRoute: routeService.generateRoute,
        theme: new ThemeData(
          primarySwatch: primary_green, // You
        ),
      ),
    );
  }
}

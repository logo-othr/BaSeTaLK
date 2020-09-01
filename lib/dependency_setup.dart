import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:basetalk/domain/repositorys/i_media_repository.dart';
import 'package:basetalk/domain/repositorys/i_topic_repository.dart';
import 'package:basetalk/domain/usecases/download_topic_data_usecase.dart';
import 'package:basetalk/domain/usecases/get_list_of_all_topics_usecase.dart';
import 'package:basetalk/domain/usecases/get_topic_thumbnails_usecase.dart';
import 'package:basetalk/domain/usecases/sort_topic_list_to_fav_first.dart';
import 'package:basetalk/domain/usecases/toggle_topic_favorite_usecase.dart';
import 'package:basetalk/domain/usecases/toggle_topic_visited_usecase.dart';
import 'package:basetalk/domain/usecases/topics_to_viewmodels_usecase.dart';
import 'package:basetalk/persistence/mapper/TopicMapper.dart';
import 'package:basetalk/persistence/repositorys/datasource/interfaces/i_topic_dto_cache_repository.dart';
import 'package:basetalk/persistence/repositorys/datasource/interfaces/i_topic_dto_repository.dart';
import 'package:basetalk/persistence/repositorys/datasource/interfaces/i_topic_user_information_dto_repository.dart';
import 'package:basetalk/persistence/repositorys/datasource/media/media_local_repository_file.dart';
import 'package:basetalk/persistence/repositorys/datasource/media/media_remote_repository_sftp.dart';
import 'package:basetalk/persistence/repositorys/datasource/topic_dto/cached_topic_dto_repository.dart';
import 'package:basetalk/persistence/repositorys/datasource/topic_dto/topic_dto_local_repository_file.dart';
import 'package:basetalk/persistence/repositorys/datasource/topic_dto/topic_dto_remote_repository_sftp.dart';
import 'package:basetalk/persistence/repositorys/datasource/topic_userinformation/topic_user_information_dto_repository.dart';
import 'package:basetalk/persistence/repositorys/media_repository.dart';
import 'package:basetalk/persistence/repositorys/topic_repository.dart';
import 'package:basetalk/persistence/sftp_auth.dart';
import 'package:basetalk/persistence/topic_path_provider.dart';
import 'package:basetalk/presentation/home_page/viewmodel/topic_list_view_model.dart';
import 'package:basetalk/presentation/navigation_service.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get_it/get_it.dart';
import 'package:ssh/ssh.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // ToDo: Cleanup
  var sshClient = await setUpSFTP();
  var topicPathProvider = new TopicPathProvider();

  // ToDo: provide path but check path existence later  or move in async singleton
  await topicPathProvider.init();

  serviceLocator.registerLazySingleton<SSHClient>(() => sshClient);
  serviceLocator
      .registerLazySingleton<TopicPathProvider>(() => topicPathProvider);
  serviceLocator.registerLazySingleton<TopicMapper>(() => TopicMapper());

  serviceLocator.registerLazySingleton<ITopicDTOCacheRepository>(
    () => TopicDTOLocalFileRepository(serviceLocator()),
  );

  ITopicDTORepository topicDTORemoteSFTPRepository =
      TopicDTORemoteSFTPRepository(serviceLocator(), serviceLocator());

  serviceLocator.registerLazySingleton<ITopicDTORepository>(
    () => CachedTopicDTORepository(
        topicDTORemoteSFTPRepository, serviceLocator()),
  );

  serviceLocator.registerLazySingleton<ITopicRepository>(
    () => TopicRepository(
      topicDTORepository: serviceLocator.get<ITopicDTORepository>(),
      topicUserInformationDTORepository:
      serviceLocator.get<ITopicUserInformationDTORepository>(),
      topicMapper: serviceLocator.get<TopicMapper>(),
    ),
  );

  serviceLocator.registerLazySingleton<ITopicUserInformationDTORepository>(
        () => TopicUserInformationDTORepository(),
  );

  IMediaRepository mediaRemoteRepository = MediaRemoteSFTPRepository(
      topicPathProvider.topicMediaRootPath);
  IMediaRepository mediaLocalRepository = MediaLocalFileRepository();

  serviceLocator.registerLazySingleton<IMediaRepository>(
        () => MediaRepository(mediaRemoteRepository, mediaLocalRepository),
  );

  serviceLocator.registerLazySingleton<AudioPlayer>(() => AudioPlayer());

  serviceLocator.registerLazySingleton<TopicListViewModel>(
        () =>
        TopicListViewModel(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator()),
  );

  serviceLocator
      .registerLazySingleton(() => GetTopicThumbnailsUseCase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => ToggleTopicVisitedUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => ToggleTopicFavoriteUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => TopicsToViewModelsUseCase());
  serviceLocator.registerLazySingleton(
      () => DownloadTopicDataUseCase(serviceLocator(), serviceLocator()));

  serviceLocator
      .registerLazySingleton(() => GetListOfAllTopicsUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SortTopicListToFavFirstUseCase());

  serviceLocator.registerLazySingleton(() => NavigationService());
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

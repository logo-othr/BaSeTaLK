import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:basetalk/app_logger.dart';
import 'package:basetalk/domain/repositories/i_media_repository.dart';
import 'package:basetalk/domain/repositories/i_quiz_repository.dart';
import 'package:basetalk/domain/repositories/i_topic_repository.dart';
import 'package:basetalk/domain/usecases/download_topic_data_usecase.dart';
import 'package:basetalk/domain/usecases/get_list_of_all_topics_usecase.dart';
import 'package:basetalk/domain/usecases/get_quiz_data_usecase.dart';
import 'package:basetalk/domain/usecases/get_topic_thumbnails_usecase.dart';
import 'package:basetalk/domain/usecases/sort_topic_list_to_fav_first.dart';
import 'package:basetalk/domain/usecases/toggle_topic_favorite_usecase.dart';
import 'package:basetalk/domain/usecases/toggle_topic_visited_usecase.dart';
import 'package:basetalk/domain/usecases/topics_to_viewmodels_usecase.dart';
import 'package:basetalk/persistence/mapper/TopicMapper.dart';
import 'package:basetalk/persistence/mapper/quiz_mapper.dart';
import 'package:basetalk/persistence/repositories/datasource/interfaces/i_quiz_dto_repository.dart';
import 'package:basetalk/persistence/repositories/datasource/interfaces/i_topic_dto_cache_repository.dart';
import 'package:basetalk/persistence/repositories/datasource/interfaces/i_topic_dto_repository.dart';
import 'package:basetalk/persistence/repositories/datasource/interfaces/i_topic_user_information_dto_repository.dart';
import 'package:basetalk/persistence/repositories/datasource/media/media_local_repository_file.dart';
import 'package:basetalk/persistence/repositories/datasource/media/media_remote_repository_sftp.dart';
import 'package:basetalk/persistence/repositories/datasource/quiz_dto/quiz_dto_repository.dart';
import 'package:basetalk/persistence/repositories/datasource/topic_dto/cached_topic_dto_repository.dart';
import 'package:basetalk/persistence/repositories/datasource/topic_dto/topic_dto_local_repository_file.dart';
import 'package:basetalk/persistence/repositories/datasource/topic_dto/topic_dto_remote_repository_sftp.dart';
import 'package:basetalk/persistence/repositories/datasource/topic_userinformation/topic_user_information_dto_repository.dart';
import 'package:basetalk/persistence/repositories/media_repository.dart';
import 'package:basetalk/persistence/repositories/quiz_repository.dart';
import 'package:basetalk/persistence/repositories/topic_repository.dart';
import 'package:basetalk/persistence/sftp_auth.dart';
import 'package:basetalk/persistence/topic_path_provider.dart';
import 'package:basetalk/presentation/home_page/viewmodel/topic_list_view_model.dart';
import 'package:basetalk/presentation/navigation_service.dart';
import 'package:basetalk/statistic_logger.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get_it/get_it.dart';
import 'package:ssh2/ssh2.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  var sshClient = await _setUpSFTP();

  var topicPathProvider = new TopicPathProvider();
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

  IMediaRepository mediaRemoteRepository =
      MediaRemoteSFTPRepository(topicPathProvider.topicMediaRootPath);
  IMediaRepository mediaLocalRepository = MediaLocalFileRepository();

  serviceLocator.registerLazySingleton<IMediaRepository>(
    () => MediaRepository(mediaRemoteRepository, mediaLocalRepository),
  );

  serviceLocator.registerLazySingleton<AudioPlayer>(() => AudioPlayer());

  serviceLocator.registerLazySingleton<TopicListViewModel>(
    () => TopicListViewModel(
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

  serviceLocator.registerLazySingleton<IQuizRepository>(
    () => QuizRepository(),
  );
  serviceLocator.registerLazySingleton<IQuizDTORepository>(
    () => QuizDTORepository(),
  );
  serviceLocator
      .registerLazySingleton<GetQuizDataUsecase>(() => GetQuizDataUsecase());
  serviceLocator.registerLazySingleton<QuizMapper>(() => QuizMapper());

  serviceLocator
      .registerLazySingleton<StatisticLogger>(() => StatisticLogger());
}

Future<SSHClient> _setUpSFTP() async {
  try {
    String jsonString = await _loadSFTPAuth();
    var map = jsonDecode(jsonString);
    SFTPAuth sftpAuth = SFTPAuth.fromJson(map);
    var sshClient = new SSHClient(
      host: sftpAuth.host,
      port: int.parse(sftpAuth.port),
      username: sftpAuth.username,
      passwordOrKey: sftpAuth.passwordOrKey,
    );
    return sshClient;
  } catch (e) {
    logger.e('Error setting up SFTP-Client: $e');
    return null;
  }
}

Future<String> _loadSFTPAuth() async {
  return await rootBundle.loadString('assets/sftp_auth.json');
}

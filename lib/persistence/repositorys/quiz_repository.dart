import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/entities/quiz_data.dart';
import 'package:basetalk/domain/repositorys/i_media_repository.dart';
import 'package:basetalk/domain/repositorys/i_quiz_repository.dart';
import 'package:basetalk/persistence/dto/quiz_data_dto.dart';
import 'package:basetalk/persistence/mapper/quiz_mapper.dart';
import 'package:basetalk/persistence/repositorys/datasource/interfaces/i_quiz_dto_repository.dart';

class QuizRepository implements IQuizRepository {
  Future<QuizData> getQuizDataByFilename(String filename) async {
    Media quizFileMedia =
        await serviceLocator.get<IMediaRepository>().getMediaFile(filename);
    QuizDataDTO quizDataDTO = await serviceLocator
        .get<IQuizDTORepository>()
        .getQuizDataDTO(quizFileMedia);
    QuizMapper quizMapper = serviceLocator.get<QuizMapper>();
    QuizData quizData = quizMapper.map(quizDataDTO);
    return quizData;
  }
}

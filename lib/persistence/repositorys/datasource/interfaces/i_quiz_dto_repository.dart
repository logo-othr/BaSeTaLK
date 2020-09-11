import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/persistence/dto/quiz_data_dto.dart';

abstract class IQuizDTORepository {
  Future<QuizDataDTO> getQuizDataDTO(Media quizFileMedia);
}

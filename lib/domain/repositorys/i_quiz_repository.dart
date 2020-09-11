import 'package:basetalk/domain/entities/quiz_data.dart';

abstract class IQuizRepository {
  Future<QuizData> getQuizDataByFilename(String filename);
}

import 'package:basetalk/dependency_setup.dart';
import 'package:basetalk/domain/entities/quiz_data.dart';
import 'package:basetalk/domain/repositorys/i_quiz_repository.dart';
import 'package:basetalk/domain/usecases/base_usecase.dart';

class GetQuizDataUsecase implements BaseUseCase<QuizData, String> {
  final IQuizRepository _quizRepository;

  GetQuizDataUsecase()
      : this._quizRepository = serviceLocator.get<IQuizRepository>();

  @override
  Future<QuizData> call(String filename) async {
    QuizData quizData = await _quizRepository.getQuizDataByFilename(filename);
    return quizData;
  }
}

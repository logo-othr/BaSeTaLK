import 'package:basetalk/domain/entities/media.dart';
import 'package:basetalk/domain/entities/quiz_data.dart';
import 'package:basetalk/domain/repositorys/i_media_repository.dart';
import 'package:basetalk/domain/usecases/base_usecase.dart';

class GetQuizDataUsecase implements BaseUseCase<QuizData, String> {
  final IMediaRepository _mediaRepository;

  GetQuizDataUsecase(this._mediaRepository);

  @override
  Future<QuizData> call(String filename) async {
    Media quizFile = await _mediaRepository.getMediaFile(filename);
  }
}

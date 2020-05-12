import 'dart:async';

abstract class BaseUseCase<Type, Params> {
  FutureOr<Type> call(Params params);
}

import 'package:dartz/dartz.dart';

import '../../error/failure.dart';

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

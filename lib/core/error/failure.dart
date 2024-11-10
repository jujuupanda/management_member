import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure(this.message);
}

class InputFailure extends Failure {}

class CacheFailure extends Failure {
  final String message;

  CacheFailure(this.message);
}

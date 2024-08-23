import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}


final class ServerFailure extends Failure {}

final class CacheFailure extends Failure {}

import 'package:books_app/core/error/failures.dart';
import 'package:books_app/core/network/network_info.dart';
import 'package:dartz/dartz.dart';

final class DataWrappers<T> {
  Future<Either<Failure, T>> tryCatchWrapper(
    NetworkInfo network,
    Future<T> Function() remoteFunction, {
    Future<T> Function()? cacheFunction,
  }) async {
    if (await network.isConnected) {
      try {
        final remote = await remoteFunction();
        return Right(remote);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      if (cacheFunction != null) {
        try {
          final cache = await cacheFunction();
          return Right(cache);
        } catch (e) {
          return Left(CacheFailure());
        }
      } else {
        return Left(ServerFailure());
      }
    }
  }

  Future<Either<Failure, T>> localFirstTryCatchWrapper(
    NetworkInfo network,
    Future<T> Function() remoteFunction,
    Future<T> Function() cacheFunction,
  ) async {
    try {
      final cache = await cacheFunction();
      return Right(cache);
    } catch (e) {
      if (await network.isConnected) {
        try {
          final remote = await remoteFunction();
          return Right(remote);
        } catch (e) {
          return Left(ServerFailure());
        }
      } else {
        return Left(CacheFailure());
      }
    }
  }

  Future<Either<Failure, T>> localOnlyTryCatchWrapper(
    Future<T> Function() cacheFunction,
  ) async {
    try {
      final cache = await cacheFunction();
      return Right(cache);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

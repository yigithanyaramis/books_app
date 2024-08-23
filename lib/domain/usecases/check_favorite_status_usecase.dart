import 'package:books_app/core/error/failures.dart';
import 'package:books_app/core/usecases/usecase.dart';
import 'package:books_app/domain/entities/check_favorite_status_params.dart';
import 'package:books_app/domain/repositories/book_repository.dart';
import 'package:dartz/dartz.dart';

class CheckFavoriteStatusUseCase
    extends UseCase<bool, CheckFavoriteStatusParams> {
  CheckFavoriteStatusUseCase({required BookRepository repository})
      : _repository = repository;

  final BookRepository _repository;

  @override
  Future<Either<Failure, bool>> call(CheckFavoriteStatusParams params) {
    return _repository.checkFavoriteStatus(params.id);
  }
}

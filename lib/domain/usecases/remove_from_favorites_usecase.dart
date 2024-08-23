import 'package:books_app/core/error/failures.dart';
import 'package:books_app/core/usecases/usecase.dart';
import 'package:books_app/domain/entities/remove_from_favorites_params.dart';
import 'package:books_app/domain/repositories/book_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveFromFavoritesUseCase
    extends UseCase<void, RemoveFromFavoritesParams> {
  RemoveFromFavoritesUseCase({required BookRepository repository})
      : _repository = repository;

  final BookRepository _repository;

  @override
  Future<Either<Failure, void>> call(RemoveFromFavoritesParams params) {
    return _repository.removeFromFavorites(params.book);
  }
}

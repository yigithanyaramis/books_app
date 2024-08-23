import 'package:books_app/core/error/failures.dart';
import 'package:books_app/core/usecases/usecase.dart';
import 'package:books_app/domain/entities/add_to_favorites_params.dart';
import 'package:books_app/domain/repositories/book_repository.dart';
import 'package:dartz/dartz.dart';

class AddToFavoritesUseCase extends UseCase<void, AddToFavoritesParams> {
  AddToFavoritesUseCase({required BookRepository repository})
      : _repository = repository;

  final BookRepository _repository;

  @override
  Future<Either<Failure, void>> call(AddToFavoritesParams params) {
    return _repository.addToFavorites(params.book);
  }
}

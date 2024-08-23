import 'package:books_app/core/error/failures.dart';
import 'package:books_app/core/usecases/usecase.dart';
import 'package:books_app/domain/entities/book.dart';
import 'package:books_app/domain/entities/no_params.dart';
import 'package:books_app/domain/repositories/book_repository.dart';
import 'package:dartz/dartz.dart';

class GetFavoriteBooksUseCase extends UseCase<List<Book>, NoParams> {
  GetFavoriteBooksUseCase({required BookRepository repository})
      : _repository = repository;

  final BookRepository _repository;

  @override
  Future<Either<Failure, List<Book>>> call(NoParams params) {
    return _repository.getFavoriteBooks();
  }
}

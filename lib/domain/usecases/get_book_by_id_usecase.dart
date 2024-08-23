import 'package:books_app/core/error/failures.dart';
import 'package:books_app/core/usecases/usecase.dart';
import 'package:books_app/domain/entities/book.dart';
import 'package:books_app/domain/entities/get_book_by_id_params.dart';
import 'package:books_app/domain/repositories/book_repository.dart';
import 'package:dartz/dartz.dart';

class GetBookByIdUseCase extends UseCase<Book, GetBookByIdParams> {
  GetBookByIdUseCase({required BookRepository repository})
      : _repository = repository;

  final BookRepository _repository;

  @override
  Future<Either<Failure, Book>> call(GetBookByIdParams params) {
    return _repository.getBookById(params.id);
  }
}

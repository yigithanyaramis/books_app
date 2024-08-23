import 'package:books_app/core/error/failures.dart';
import 'package:books_app/domain/entities/book.dart';
import 'package:dartz/dartz.dart';

abstract class BookRepository {
  Future<Either<Failure, List<Book>>> getBooks();
  Future<Either<Failure, Book>> getBookById(String bookId);
  Future<Either<Failure, List<Book>>> getFavoriteBooks();
  Future<Either<Failure, void>> addToFavorites(Book book);
  Future<Either<Failure, void>> removeFromFavorites(Book book);
  Future<Either<Failure, bool>> checkFavoriteStatus(String bookId);
}

import 'dart:async';

import 'package:books_app/core/error/failures.dart';
import 'package:books_app/core/network/network_info.dart';
import 'package:books_app/core/utils/data_wrappers.dart';
import 'package:books_app/data/datasources/local/book_local_data_source.dart';
import 'package:books_app/data/datasources/remote/book_remote_data_source.dart';
import 'package:books_app/data/models/book_model.dart';
import 'package:books_app/domain/entities/book.dart';
import 'package:books_app/domain/repositories/book_repository.dart';
import 'package:dartz/dartz.dart';

final class BookRepositoryImpl implements BookRepository {
  BookRepositoryImpl({
    required BookRemoteDataSource remoteDataSource,
    required BookLocalDataSource localDataSource,
    required this.networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final BookRemoteDataSource _remoteDataSource;
  final BookLocalDataSource _localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<Book>>> getBooks() {
    return DataWrappers<List<Book>>().localFirstTryCatchWrapper(
      networkInfo,
      () async {
        final books = await _remoteDataSource.getBooks();
        unawaited(_localDataSource.cacheBooks(books));
        return books.map((e) => e.toEntity()).toList();
      },
      () {
        return _localDataSource
            .getBooks()
            .then((value) => value.map((e) => e.toEntity()).toList());
      },
    );
  }

  @override
  Future<Either<Failure, Book>> getBookById(String bookId) {
    return DataWrappers<Book>().localFirstTryCatchWrapper(
      networkInfo,
      () async {
        final book = await _remoteDataSource.getBookById(bookId);
        unawaited(_localDataSource.cacheSingleBook(book));
        return book.toEntity();
      },
      () {
        return _localDataSource
            .getBookById(bookId)
            .then((value) => value.toEntity());
      },
    );
  }

  @override
  Future<Either<Failure, void>> addToFavorites(Book book) {
    return DataWrappers<void>().localOnlyTryCatchWrapper(
      () {
        return _localDataSource.addToFavorites(BookModel.fromEntity(book));
      },
    );
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(Book book) {
    return DataWrappers<void>().localOnlyTryCatchWrapper(
      () {
        return _localDataSource.removeFromFavorites(BookModel.fromEntity(book));
      },
    );
  }

  @override
  Future<Either<Failure, bool>> checkFavoriteStatus(String bookId) {
    return DataWrappers<bool>().localOnlyTryCatchWrapper(
      () {
        return _localDataSource.checkFavoriteStatus(bookId);
      },
    );
  }

  @override
  Future<Either<Failure, List<Book>>> getFavoriteBooks() {
    return DataWrappers<List<Book>>().localOnlyTryCatchWrapper(
      () async {
        final books = await _localDataSource.getFavoriteBooks();
        return books.map((e) => e.toEntity()).toList();
      },
    );
  }
}

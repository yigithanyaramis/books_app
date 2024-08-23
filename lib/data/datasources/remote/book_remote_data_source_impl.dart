import 'dart:io';

import 'package:books_app/core/error/exceptions.dart';
import 'package:books_app/data/core/api_constants.dart';
import 'package:books_app/data/datasources/remote/book_remote_data_source.dart';
import 'package:books_app/data/models/book_model.dart';
import 'package:dio/dio.dart';

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  BookRemoteDataSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<List<BookModel>> getBooks() async {
    final response = await dio.get<Map<String, dynamic>>(ApiConstants.books);
    if (response.statusCode != HttpStatus.ok) throw ServerException();

    final books = response.data?['data'] as List<dynamic>;
    return books
        .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<BookModel> getBookById(String bookId) async {
    final response =
        await dio.get<Map<String, dynamic>>(ApiConstants.bookById(bookId));
    if (response.statusCode != HttpStatus.ok) throw ServerException();

    final book = response.data?['data'] as Map<String, dynamic>;
    return BookModel.fromJson(book);
  }
}

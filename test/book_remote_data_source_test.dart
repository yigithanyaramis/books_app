import 'dart:io';

import 'package:books_app/core/error/exceptions.dart';
import 'package:books_app/data/core/api_constants.dart';
import 'package:books_app/data/datasources/remote/book_remote_data_source_impl.dart';
import 'package:books_app/data/models/book_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'book_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late BookRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = BookRemoteDataSourceImpl(mockDio);
  });

  group('getBooks', () {
    final tBookList = [
      BookModel(id: 1, title: 'Test Book 1'),
      BookModel(id: 2, title: 'Test Book 2'),
    ];

    test('should perform a GET request on a URL with books being the endpoint',
        () async {
      when(mockDio.get<Map<String, dynamic>>(any)).thenAnswer(
        (_) async => Response(
          data: {
            'data': [
              {'id': 1, 'title': 'Test Book 1'},
              {'id': 2, 'title': 'Test Book 2'},
            ],
          },
          statusCode: HttpStatus.ok,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await dataSource.getBooks();

      verify(mockDio.get<Map<String, dynamic>>(ApiConstants.books));
      expect(result, equals(tBookList));
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      // arrange
      when(mockDio.get<Map<String, dynamic>>(any)).thenAnswer(
        (_) async => Response(
          statusCode: HttpStatus.notFound,
          requestOptions: RequestOptions(),
        ),
      );

      // act
      final call = dataSource.getBooks;

      // assert
      expect(call, throwsA(isA<ServerException>()));
    });
  });

  group('getBookById', () {
    const tBookId = 1;
    final tBook = BookModel(id: tBookId, title: 'Test Book 1');

    test(
        // ignore: lines_longer_than_80_chars
        'should perform a GET request on a URL with the bookId being the endpoint',
        () async {
      // arrange
      when(mockDio.get<Map<String, dynamic>>(any)).thenAnswer(
        (_) async => Response(
          data: {
            'data': {'id': tBookId, 'title': 'Test Book 1'},
          },
          statusCode: HttpStatus.ok,
          requestOptions: RequestOptions(),
        ),
      );

      final result = await dataSource.getBookById(tBookId.toString());

      // assert
      verify(
        mockDio.get<Map<String, dynamic>>(
          ApiConstants.bookById(tBookId.toString()),
        ),
      );
      expect(result, equals(tBook));
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      // arrange
      when(mockDio.get<Map<String, dynamic>>(any)).thenAnswer(
        (_) async => Response(
          statusCode: HttpStatus.notFound,
          requestOptions: RequestOptions(),
        ),
      );

      // act
      final call = dataSource.getBookById;

      // assert
      expect(() => call(tBookId.toString()), throwsA(isA<ServerException>()));
    });
  });
}

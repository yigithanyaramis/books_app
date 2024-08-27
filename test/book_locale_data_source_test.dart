import 'package:books_app/core/error/exceptions.dart';
import 'package:books_app/data/core/app_hive.dart';
import 'package:books_app/data/core/hive_constants.dart';
import 'package:books_app/data/datasources/local/book_local_data_source_impl.dart';
import 'package:books_app/data/models/book_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'book_locale_data_source_test.mocks.dart';

@GenerateMocks([AppHive])
void main() {
  late BookLocalDataSourceImpl mockBookLocalDataSourceImpl;
  late AppHive<List<dynamic>> mockBooksHive;
  late AppHive<dynamic> mockSingleBookHive;
  late AppHive<List<dynamic>> mockFavoriteBooksHive;

  setUp(() {
    mockBooksHive = MockAppHive();
    mockSingleBookHive = MockAppHive();
    mockFavoriteBooksHive = MockAppHive();
    mockBookLocalDataSourceImpl = BookLocalDataSourceImpl(
      mockBooksHive,
      mockSingleBookHive,
      mockFavoriteBooksHive,
    );
  });

  group('cacheBooks', () {
    final tBooks = [
      BookModel(id: 1, title: 'Test Book 1'),
      BookModel(id: 2, title: 'Test Book 2'),
    ];
    final tBook = BookModel(id: 3, title: 'Test Book 3');

    test('mockBooksHive should call cacheData with the correct key and value',
        () async {
      await mockBookLocalDataSourceImpl.cacheBooks(tBooks);
      verify(mockBooksHive.cacheData(key: HiveConstants.books, value: tBooks));
    });

    test(
        'mockSingleBookHive should call cacheData with the correct key and value',
        () async {
      await mockBookLocalDataSourceImpl.cacheSingleBook(tBook);
      verify(
        mockSingleBookHive.cacheData(
          key: HiveConstants.book(tBook.id.toString()),
          value: tBook,
        ),
      );
    });

    test(
        // ignore: lines_longer_than_80_chars
        'mockFavoriteBooksHive should call cacheData with the correct key and value',
        () async {
      await mockBookLocalDataSourceImpl.cacheFavoriteBooks(tBooks);
      verify(
        mockFavoriteBooksHive.cacheData(
          key: HiveConstants.favoriteBooks,
          value: tBooks,
        ),
      );
    });
  });

  group('getBooks', () {
    final tBooks = [
      BookModel(id: 1, title: 'Test Book 1'),
      BookModel(id: 2, title: 'Test Book 2'),
    ];

    test('should return a list of BookModel when there is data', () async {
      when(mockBooksHive.getData(key: HiveConstants.books)).thenReturn(
        tBooks,
      );
      final result = await mockBookLocalDataSourceImpl.getBooks();
      expect(result, equals(tBooks));
    });

    test('should throw a Failure when there is no data', () {
      when(mockBooksHive.getData(key: HiveConstants.books)).thenReturn(null);
      expect(
        () => mockBookLocalDataSourceImpl.getBooks(),
        throwsA(isA<CacheException>()),
      );
    });

    test('should return a list of BookModel when there is data', () async {
      when(mockBooksHive.getData(key: HiveConstants.books)).thenReturn(
        tBooks,
      );
      final result = await mockBookLocalDataSourceImpl.getBooks();
      expect(result, equals(tBooks));
    });
  });

  group('getBookById', () {
    final tBook = BookModel(id: 1, title: 'Test Book 1');

    test('should return a BookModel when there is data', () async {
      when(
        mockSingleBookHive.getData(
          key: HiveConstants.book(tBook.id.toString()),
        ),
      ).thenReturn(tBook);
      final result =
          await mockBookLocalDataSourceImpl.getBookById(tBook.id.toString());
      expect(result, equals(tBook));
    });

    test('should throw a Failure when there is no data', () {
      when(
        mockSingleBookHive.getData(
          key: HiveConstants.book(tBook.id.toString()),
        ),
      ).thenReturn(null);
      expect(
        () => mockBookLocalDataSourceImpl.getBookById(tBook.id.toString()),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('getFavoriteBooks', () {
    final tBooks = [
      BookModel(id: 1, title: 'Test Book 1'),
      BookModel(id: 2, title: 'Test Book 2'),
    ];

    test('should return a list of BookModel when there is data', () async {
      when(mockFavoriteBooksHive.getData(key: HiveConstants.favoriteBooks))
          .thenReturn(tBooks);
      final result = await mockBookLocalDataSourceImpl.getFavoriteBooks();
      expect(result, equals(tBooks));
    });

    test('should throw a Failure when there is no data', () {
      when(mockFavoriteBooksHive.getData(key: HiveConstants.favoriteBooks))
          .thenReturn(null);
      expect(
        () => mockBookLocalDataSourceImpl.getFavoriteBooks(),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('addToFavorites', () {
    final tBooks = [
      BookModel(id: 1, title: 'Test Book 1'),
      BookModel(id: 2, title: 'Test Book 2'),
    ];
    final tBook = BookModel(id: 3, title: 'Test Book 3');

    test('should return void when the operation is successful', () async {
      when(mockFavoriteBooksHive.getData(key: HiveConstants.favoriteBooks))
          .thenReturn(tBooks);

      await mockBookLocalDataSourceImpl.addToFavorites(tBook);

      verify(
        mockFavoriteBooksHive.cacheData(
          key: HiveConstants.favoriteBooks,
          value: tBooks,
        ),
      );

      final result =
          mockFavoriteBooksHive.getData(key: HiveConstants.favoriteBooks);
      expect(result, equals(tBooks));
    });

    test('should throw a Failure when the operation is unsuccessful', () {
      when(mockFavoriteBooksHive.getData(key: HiveConstants.favoriteBooks))
          .thenReturn(null);

      expect(
        () => mockBookLocalDataSourceImpl.addToFavorites(tBook),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('removeFromFavorites', () {
    final tBooks = [
      BookModel(id: 1, title: 'Test Book 1'),
      BookModel(id: 2, title: 'Test Book 2'),
    ];
    final tBook = BookModel(id: 1, title: 'Test Book 1');

    test('should return void when the operation is successful', () async {
      when(mockFavoriteBooksHive.getData(key: HiveConstants.favoriteBooks))
          .thenReturn(tBooks);

      await mockBookLocalDataSourceImpl.removeFromFavorites(tBook);

      verify(
        mockFavoriteBooksHive.cacheData(
          key: HiveConstants.favoriteBooks,
          value: tBooks,
        ),
      );

      final result =
          mockFavoriteBooksHive.getData(key: HiveConstants.favoriteBooks);
      expect(result, equals(tBooks));
    });

    test('should throw a Failure when the operation is unsuccessful', () {
      when(mockFavoriteBooksHive.getData(key: HiveConstants.favoriteBooks))
          .thenReturn(null);

      expect(
        () => mockBookLocalDataSourceImpl.removeFromFavorites(tBook),
        throwsA(isA<CacheException>()),
      );
    });
  });

  group('checkFavoriteStatus', () {
    final tBooks = [
      BookModel(id: 1, title: 'Test Book 1'),
      BookModel(id: 2, title: 'Test Book 2'),
    ];
    final tBook = BookModel(id: 1, title: 'Test Book 1');
    final tBook2 = BookModel(id: 3, title: 'Test Book 3');

    test('should return true when the book is in favorites', () async {
      when(mockFavoriteBooksHive.getData(key: HiveConstants.favoriteBooks))
          .thenReturn(tBooks);

      final result = await mockBookLocalDataSourceImpl.checkFavoriteStatus(
        tBook.id.toString(),
      );

      expect(result, equals(true));
    });

    test('should return false when the book is not in favorites', () async {
      when(mockFavoriteBooksHive.getData(key: HiveConstants.favoriteBooks))
          .thenReturn(tBooks);

      final result = await mockBookLocalDataSourceImpl.checkFavoriteStatus(
        tBook2.id.toString(),
      );

      expect(result, equals(false));
    });

    test('should throw a Failure when the operation is unsuccessful', () {
      when(mockFavoriteBooksHive.getData(key: HiveConstants.favoriteBooks))
          .thenReturn(null);

      expect(
        () => mockBookLocalDataSourceImpl
            .checkFavoriteStatus(tBook.id.toString()),
        throwsA(isA<CacheException>()),
      );
    });
  });
}

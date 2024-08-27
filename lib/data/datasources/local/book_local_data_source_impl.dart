import 'package:books_app/core/error/exceptions.dart';
import 'package:books_app/data/core/app_hive.dart';
import 'package:books_app/data/core/hive_constants.dart';
import 'package:books_app/data/datasources/local/book_local_data_source.dart';
import 'package:books_app/data/models/book_model.dart';
import 'package:books_app/foundation/extensions/string_extension.dart';
import 'package:books_app/foundation/generated/locale_keys.g.dart';

final class BookLocalDataSourceImpl implements BookLocalDataSource {
  BookLocalDataSourceImpl(
    this.booksHive,
    this.singleBookHive,
    this.favoriteBooksHive,
  );

  final AppHive<List<dynamic>> booksHive;
  final AppHive<dynamic> singleBookHive;
  final AppHive<List<dynamic>> favoriteBooksHive;

  @override
  Future<void> cacheBooks(List<BookModel> books) {
    return booksHive.cacheData(
      key: HiveConstants.books,
      value: books,
    );
  }

  @override
  Future<void> cacheSingleBook(BookModel book) {
    return singleBookHive.cacheData(
      key: HiveConstants.book(book.id.toString()),
      value: book,
    );
  }

  @override
  Future<void> cacheFavoriteBooks(List<BookModel> books) {
    return favoriteBooksHive.cacheData(
      key: HiveConstants.favoriteBooks,
      value: books,
    );
  }

  @override
  Future<List<BookModel>> getBooks() async {
    final books = booksHive.getData(key: HiveConstants.books);

    if (books != null) {
      return books.cast<BookModel>();
    } else {
      return Future.error(
        CacheException(LocaleKeys.saved_book_not_found.translate),
      );
    }
  }

  @override
  Future<BookModel> getBookById(String bookId) async {
    final book = singleBookHive.getData(key: HiveConstants.book(bookId));
    if (book != null) {
      return book as BookModel;
    } else {
      return Future.error(
        CacheException(LocaleKeys.saved_book_not_found.translate),
      );
    }
  }

  @override
  Future<List<BookModel>> getFavoriteBooks() async {
    final books = favoriteBooksHive.getData(key: HiveConstants.favoriteBooks);

    if (books != null) {
      return books.cast<BookModel>();
    } else {
      return [];
    }
  }

  @override
  Future<void> addToFavorites(BookModel book) async {
    final books = await getFavoriteBooks();
    if (books.any((element) => element.id == book.id)) {
      return Future.error(
        CacheException(LocaleKeys.already_added_to_favorites.translate),
      );
    }
    books.add(book);
    return cacheFavoriteBooks(books);
  }

  @override
  Future<void> removeFromFavorites(BookModel book) async {
    final books = await getFavoriteBooks();
    books.removeWhere((element) => element.id == book.id);
    return cacheFavoriteBooks(books);
  }

  @override
  Future<bool> checkFavoriteStatus(String bookId) async {
    final books = await getFavoriteBooks();
    return books.any((element) => element.id == int.tryParse(bookId));
  }
}

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
  Future<List<BookModel>> getBooks() async {
    final books = booksHive.getData(key: HiveConstants.books);

    if (books != null) {
      return books.map((item) => item as BookModel).toList();
    } else {
      return Future.error(LocaleKeys.saved_book_not_found.translate);
    }
  }

  @override
  Future<void> cacheSingleBook(BookModel book) {
    return singleBookHive.cacheData(
      key: HiveConstants.book(book.id.toString()),
      value: book,
    );
  }

  @override
  Future<BookModel> getBookById(String bookId) async {
    final book = singleBookHive.getData(key: HiveConstants.book(bookId));
    if (book != null) {
      return book as BookModel;
    } else {
      return Future.error(LocaleKeys.saved_book_not_found.translate);
    }
  }

  @override
  Future<List<BookModel>?> getFavoriteBooks() async {
    final books = favoriteBooksHive.getData(key: HiveConstants.favoriteBooks);

    if (books != null) {
      return books.map((item) => item as BookModel).toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> addToFavorites(BookModel book) {
    final books = favoriteBooksHive.getData(key: HiveConstants.favoriteBooks);
    if (books != null) {
      final bookList = books.map((item) => item as BookModel).toList();
      if (bookList.any((element) => element.id == book.id)) {
        return Future.error(LocaleKeys.already_added_to_favorites.translate);
      }
      books.add(book);
      return favoriteBooksHive.cacheData(
        key: HiveConstants.favoriteBooks,
        value: books,
      );
    } else {
      return favoriteBooksHive.cacheData(
        key: HiveConstants.favoriteBooks,
        value: [book],
      );
    }
  }

  @override
  Future<void> removeFromFavorites(BookModel book) {
    final books = favoriteBooksHive.getData(key: HiveConstants.favoriteBooks);
    if (books != null) {
      final bookList = books.map((item) => item as BookModel).toList()
        ..removeWhere((element) => element.id == book.id);

      return favoriteBooksHive.cacheData(
        key: HiveConstants.favoriteBooks,
        value: bookList,
      );
    } else {
      return Future.error(LocaleKeys.saved_book_not_found.translate);
    }
  }

  @override
  Future<bool> checkFavoriteStatus(String bookId) async {
    final books = favoriteBooksHive.getData(key: HiveConstants.favoriteBooks);
    if (books != null) {
      final bookList = books.map((item) => item as BookModel).toList();
      return bookList.any((element) => element.id == int.parse(bookId));
    } else {
      return false;
    }
  }
}

import 'package:books_app/data/models/book_model.dart';

abstract class BookLocalDataSource {
  Future<List<BookModel>> getBooks();
  Future<void> cacheBooks(List<BookModel> books);
  Future<void> cacheFavoriteBooks(List<BookModel> books);

  Future<BookModel> getBookById(String bookId);
  Future<void> cacheSingleBook(BookModel book);

  Future<List<BookModel>> getFavoriteBooks();
  Future<void> addToFavorites(BookModel book);
  Future<void> removeFromFavorites(BookModel book);
  Future<bool> checkFavoriteStatus(String bookId);
}

import 'package:books_app/data/models/book_model.dart';

abstract class BookRemoteDataSource {
  Future<List<BookModel>> getBooks();

  Future<BookModel> getBookById(String bookId);
}

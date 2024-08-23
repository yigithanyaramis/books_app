final class ApiConstants {
  const ApiConstants._();

  static const baseUrl = 'https://stephen-king-api.onrender.com/api';

  static const books = '/books';
  static String bookById(String id) => '/book/$id';
}

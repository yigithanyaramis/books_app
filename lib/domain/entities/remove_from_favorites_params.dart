import 'package:books_app/domain/entities/book.dart';
import 'package:equatable/equatable.dart';

final class RemoveFromFavoritesParams extends Equatable {
  const RemoveFromFavoritesParams({required this.book});
  final Book book;

  @override
  List<Object?> get props => [book];
}

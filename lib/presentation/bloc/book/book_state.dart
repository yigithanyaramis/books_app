part of 'book_bloc.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object?> get props => [];
}

final class BookInitial extends BookState {}

final class BookLoading extends BookState {}

final class BookLoaded extends BookState {
  const BookLoaded({required this.books, required this.filteredBooks});
  final List<Book> books;
  final List<Book> filteredBooks;

  @override
  List<Object?> get props => [books, filteredBooks];
}

final class BookError extends BookState {
  const BookError({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}

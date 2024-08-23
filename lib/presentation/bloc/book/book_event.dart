part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object?> get props => [];
}

final class GetBooksEvent extends BookEvent {}

final class SearchBooksEvent extends BookEvent {
  const SearchBooksEvent({required this.query});
  final String query;

  @override
  List<Object?> get props => [query];
}

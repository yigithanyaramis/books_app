part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object?> get props => [];
}

final class GetBookByIdEvent extends DetailEvent {
  const GetBookByIdEvent({required this.id});
  final String id;

  @override
  List<Object?> get props => [id];
}

final class AddToFavoritesEvent extends DetailEvent {
  const AddToFavoritesEvent({required this.book});
  final Book book;

  @override
  List<Object?> get props => [book];
}

final class RemoveFromFavoritesEvent extends DetailEvent {
  const RemoveFromFavoritesEvent({required this.book});
  final Book book;

  @override
  List<Object?> get props => [book];
}

final class CheckFavoriteStatusEvent extends DetailEvent {
  const CheckFavoriteStatusEvent({required this.bookId});
  final String bookId;

  @override
  List<Object?> get props => [bookId];
}

final class RemoveReminderEvent extends DetailEvent {
  const RemoveReminderEvent({required this.bookId});
  final String bookId;

  @override
  List<Object> get props => [bookId];
}

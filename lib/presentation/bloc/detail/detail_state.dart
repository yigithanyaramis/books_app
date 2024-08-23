part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object?> get props => [];
}

final class DetailInitial extends DetailState {}

final class DetailLoading extends DetailState {}

final class DetailLoaded extends DetailState {
  const DetailLoaded({
    required this.book,
    this.isFavorite = false,
    this.hasReminder = false,
  });

  final Book book;
  final bool isFavorite;
  final bool hasReminder;

  DetailLoaded copyWith({bool? hasReminder}) {
    return DetailLoaded(
      book: book,
      hasReminder: hasReminder ?? this.hasReminder,
    );
  }

  @override
  List<Object> get props => [book, isFavorite, hasReminder];
}

final class DetailError extends DetailState {
  const DetailError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

final class FavoritesUpdating extends DetailState {}

final class FavoritesUpdated extends DetailState {
  const FavoritesUpdated({required this.book});
  final Book book;

  @override
  List<Object?> get props => [book];
}

class SetReminderEvent extends DetailEvent {
  const SetReminderEvent({required this.bookId, required this.time});
  final String bookId;
  final DateTime time;

  @override
  List<Object> get props => [bookId, time];
}

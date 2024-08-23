part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteLoaded extends FavoriteState {
  const FavoriteLoaded({required this.favorites});
  final List<Book> favorites;

  @override
  List<Object?> get props => [favorites];
}


final class FavoriteError extends FavoriteState {
  const FavoriteError({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}

import 'package:bloc/bloc.dart';
import 'package:books_app/domain/entities/book.dart';
import 'package:books_app/domain/entities/no_params.dart';
import 'package:books_app/domain/usecases/get_favorite_books_usecase.dart';
import 'package:books_app/foundation/extensions/failure_extension.dart';
import 'package:equatable/equatable.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

final class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc({
    required this.getFavoriteBooksUseCase,
  }) : super(FavoriteInitial()) {
    on<GetFavoriteBooksEvent>(_onGetBooksEvent);
  }

  final GetFavoriteBooksUseCase getFavoriteBooksUseCase;

  Future<void> _onGetBooksEvent(
    GetFavoriteBooksEvent event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());

    final favoritesOrFailure = await getFavoriteBooksUseCase(NoParams());
    favoritesOrFailure.fold(
      (failure) {
        emit(FavoriteError(message: failure.mapToMessage()));
      },
      (favorites) {
        emit(FavoriteLoaded(favorites: favorites));
      },
    );
  }
}

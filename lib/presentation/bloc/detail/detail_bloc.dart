import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:books_app/core/services/notification_service/notification_service.dart';
import 'package:books_app/domain/entities/add_to_favorites_params.dart';
import 'package:books_app/domain/entities/book.dart';
import 'package:books_app/domain/entities/check_favorite_status_params.dart';
import 'package:books_app/domain/entities/get_book_by_id_params.dart';
import 'package:books_app/domain/entities/remove_from_favorites_params.dart';
import 'package:books_app/domain/usecases/add_to_favorites_usecase.dart';
import 'package:books_app/domain/usecases/check_favorite_status_usecase.dart';
import 'package:books_app/domain/usecases/get_book_by_id_usecase.dart';
import 'package:books_app/domain/usecases/remove_from_favorites_usecase.dart';
import 'package:books_app/foundation/extensions/failure_extension.dart';
import 'package:books_app/foundation/extensions/string_extension.dart';
import 'package:books_app/foundation/generated/locale_keys.g.dart';
import 'package:equatable/equatable.dart';

part 'detail_event.dart';
part 'detail_state.dart';

final class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc({
    required this.getBookByIdUseCase,
    required this.addToFavoritesUseCase,
    required this.removeFromFavoritesUseCase,
    required this.checkFavoriteStatusUseCase,
    required this.notificationService,
  }) : super(DetailInitial()) {
    on<GetBookByIdEvent>(_onGetBookByIdEvent);
    on<CheckFavoriteStatusEvent>(_onCheckFavoriteStatusEvent);
    on<AddToFavoritesEvent>(_onAddToFavoritesEvent);
    on<RemoveFromFavoritesEvent>(_onRemoveFromFavoritesEvent);
    on<SetReminderEvent>(_onSetReminder);
    on<RemoveReminderEvent>(_onRemoveReminder);
  }

  final GetBookByIdUseCase getBookByIdUseCase;
  final AddToFavoritesUseCase addToFavoritesUseCase;
  final RemoveFromFavoritesUseCase removeFromFavoritesUseCase;
  final CheckFavoriteStatusUseCase checkFavoriteStatusUseCase;
  final NotificationService notificationService;

  Future<void> _onGetBookByIdEvent(
    GetBookByIdEvent event,
    Emitter<DetailState> emit,
  ) async {
    emit(DetailLoading());

    final bookOrFailure =
        await getBookByIdUseCase(GetBookByIdParams(id: event.id));
    await bookOrFailure.fold(
      (failure) async {
        emit(DetailError(message: failure.mapToMessage()));
      },
      (book) async {
        final isFavoriteOrFailure = await checkFavoriteStatusUseCase(
          CheckFavoriteStatusParams(id: event.id),
        );
        await isFavoriteOrFailure.fold(
          (failure) async {
            emit(DetailError(message: failure.mapToMessage()));
          },
          (isFavorite) async {
            final updatedBook = book.copyWith(isFavorite: isFavorite);
            final hasNotification =
                await notificationService.hasNotification(updatedBook.id);
            emit(
              DetailLoaded(
                book: updatedBook,
                hasReminder: hasNotification,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onCheckFavoriteStatusEvent(
    CheckFavoriteStatusEvent event,
    Emitter<DetailState> emit,
  ) async {
    final isFavoriteOrFailure = await checkFavoriteStatusUseCase(
      CheckFavoriteStatusParams(id: event.bookId),
    );
    isFavoriteOrFailure.fold(
      (failure) => emit(DetailError(message: failure.mapToMessage())),
      (isFavorite) {
        if (state is FavoritesUpdated) {
          final book =
              (state as FavoritesUpdated).book.copyWith(isFavorite: isFavorite);
          emit(DetailLoaded(book: book));
        }
      },
    );
  }

  Future<void> _onAddToFavoritesEvent(
    AddToFavoritesEvent event,
    Emitter<DetailState> emit,
  ) async {
    if (state is DetailLoaded) {
      emit(FavoritesUpdating());

      final result =
          await addToFavoritesUseCase(AddToFavoritesParams(book: event.book));
      await result.fold(
        (failure) async {
          emit(DetailError(message: failure.mapToMessage()));
        },
        (_) async {
          final scheduleTime = DateTime.now().add(const Duration(seconds: 5));
          unawaited(
            notificationService.scheduleNotification(
              event.book.id,
              LocaleKeys.noti_title.translate,
              '${event.book.title} ${LocaleKeys.noti_message.translate}',
              scheduleTime,
            ),
          );
          emit(FavoritesUpdated(book: event.book));
        },
      );
    }
  }

  Future<void> _onRemoveFromFavoritesEvent(
    RemoveFromFavoritesEvent event,
    Emitter<DetailState> emit,
  ) async {
    if (state is DetailLoaded) {
      emit(FavoritesUpdating());

      final result = await removeFromFavoritesUseCase(
        RemoveFromFavoritesParams(book: event.book),
      );
      await result.fold(
        (failure) async {
          emit(DetailError(message: failure.mapToMessage()));
        },
        (_) async {
          unawaited(notificationService.cancelNotification(event.book.id));
          emit(FavoritesUpdated(book: event.book));
        },
      );
    }
  }

  Future<void> _onSetReminder(
    SetReminderEvent event,
    Emitter<DetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is DetailLoaded) {
      await notificationService.scheduleNotification(
        int.parse(event.bookId),
        LocaleKeys.noti_title.translate,
        '${currentState.book.title} ${LocaleKeys.noti_message.translate}',
        event.time,
      );
      emit(currentState.copyWith(hasReminder: true));
    }
  }

  Future<void> _onRemoveReminder(
    RemoveReminderEvent event,
    Emitter<DetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is DetailLoaded) {
      await notificationService.cancelNotification(int.parse(event.bookId));
      emit(currentState.copyWith(hasReminder: false));
    }
  }
}

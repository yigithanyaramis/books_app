import 'package:bloc/bloc.dart';
import 'package:books_app/domain/entities/book.dart';
import 'package:books_app/domain/entities/no_params.dart';
import 'package:books_app/domain/usecases/get_books_usecase.dart';
import 'package:books_app/foundation/extensions/failure_extension.dart';
import 'package:equatable/equatable.dart';

part 'book_event.dart';
part 'book_state.dart';

final class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc({
    required this.getBooksUseCase,
  }) : super(BookInitial()) {
    on<GetBooksEvent>(_onGetBooksEvent);
    on<SearchBooksEvent>(_onSearchBooksEvent);
  }
  final GetBooksUseCase getBooksUseCase;

  Future<void> _onGetBooksEvent(
    GetBooksEvent event,
    Emitter<BookState> emit,
  ) async {
    emit(BookLoading());

    final booksOrFailure = await getBooksUseCase(NoParams());
    booksOrFailure.fold(
      (failure) => emit(BookError(message: failure.mapToMessage())),
      (books) => emit(BookLoaded(books: books, filteredBooks: books)),
    );
  }

  Future<void> _onSearchBooksEvent(
    SearchBooksEvent event,
    Emitter<BookState> emit,
  ) async {
    if (state is BookLoaded) {
      final books = (state as BookLoaded).books;

      final filteredBooks = books.where((book) {
        final query = event.query.toLowerCase();
        final title = book.title?.toLowerCase();
        return title?.contains(query) ?? false;
      }).toList();

      emit(BookLoaded(books: books, filteredBooks: filteredBooks));
    }
  }
}

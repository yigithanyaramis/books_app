import 'package:bloc_test/bloc_test.dart';
import 'package:books_app/core/error/failures.dart';
import 'package:books_app/domain/entities/book.dart';
import 'package:books_app/domain/entities/no_params.dart';
import 'package:books_app/domain/usecases/get_books_usecase.dart';
import 'package:books_app/presentation/bloc/book/book_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'book_bloc_test.mocks.dart';

@GenerateMocks([GetBooksUseCase])
void main() {
  late MockGetBooksUseCase mockGetBooksUseCase;
  late BookBloc bookBloc;

  setUp(() {
    mockGetBooksUseCase = MockGetBooksUseCase();
    bookBloc = BookBloc(getBooksUseCase: mockGetBooksUseCase);
  });

  tearDown(() {
    bookBloc.close();
  });

  group('BookBloc', () {
    test('initial state should be BookInitial', () {
      expect(bookBloc.state, equals(BookInitial()));
    });

    blocTest<BookBloc, BookState>(
      // ignore: lines_longer_than_80_chars
      'emits [BookLoading, BookLoaded] with filtered books when SearchBooksEvent is added after GetBooksEvent',
      build: () {
        final books = [
          const Book(id: 1, title: 'Flutter'),
          const Book(id: 2, title: 'Dart'),
        ];
        when(mockGetBooksUseCase(any)).thenAnswer((_) async => Right(books));

        return bookBloc;
      },
      act: (bloc) async {
        bloc
          ..add(GetBooksEvent())
          ..add(const SearchBooksEvent(query: 'flutter'));
      },
      expect: () {
        final books = [
          const Book(id: 1, title: 'Flutter'),
          const Book(id: 2, title: 'Dart'),
        ];
        final filteredBooks = [
          const Book(id: 1, title: 'Flutter'),
        ];
        return [
          BookLoading(),
          BookLoaded(books: books, filteredBooks: books),
          BookLoaded(books: books, filteredBooks: filteredBooks),
        ];
      },
      verify: (bloc) {
        verify(mockGetBooksUseCase(NoParams())).called(1);
      },
    );

    blocTest<BookBloc, BookState>(
      'emits [BookLoading, BookError] with message when GetBooksEvent fails',
      build: () {
        when(mockGetBooksUseCase(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        return bookBloc;
      },
      act: (bloc) => bloc.add(GetBooksEvent()),
      expect: () => [
        BookLoading(),
        const BookError(message: 'Server'),
      ],
      verify: (bloc) {
        verify(mockGetBooksUseCase(NoParams())).called(1);
      },
    );
  });
}

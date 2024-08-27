import 'package:bloc_test/bloc_test.dart';
import 'package:books_app/core/error/failures.dart';
import 'package:books_app/domain/entities/book.dart';
import 'package:books_app/domain/entities/no_params.dart';
import 'package:books_app/domain/usecases/get_favorite_books_usecase.dart';
import 'package:books_app/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'favorite_bloc_test.mocks.dart';

@GenerateMocks([GetFavoriteBooksUseCase])
void main() {
  late MockGetFavoriteBooksUseCase mockGetFavoriteBooksUseCase;
  late FavoriteBloc favoriteBloc;

  setUp(() {
    mockGetFavoriteBooksUseCase = MockGetFavoriteBooksUseCase();
    favoriteBloc =
        FavoriteBloc(getFavoriteBooksUseCase: mockGetFavoriteBooksUseCase);
  });

  tearDown(() {
    favoriteBloc.close();
  });

  group('FavoriteBloc', () {
    test('initial state should be FavoriteInitial', () {
      expect(favoriteBloc.state, equals(FavoriteInitial()));
    });

    blocTest<FavoriteBloc, FavoriteState>(
      // ignore: lines_longer_than_80_chars
      'emits [FavoriteLoading, FavoriteLoaded] when GetFavoriteBooksEvent is added and getFavoriteBooksUseCase succeeds',
      build: () {
        final favoriteBooks = [
          const Book(id: 1, title: 'Flutter'),
          const Book(id: 2, title: 'Dart'),
        ];
        when(mockGetFavoriteBooksUseCase(any))
            // ignore: inference_failure_on_instance_creation
            .thenAnswer((_) async => Right(favoriteBooks));

        return favoriteBloc;
      },
      act: (bloc) => bloc.add(GetFavoriteBooksEvent()),
      expect: () => [
        FavoriteLoading(),
        const FavoriteLoaded(
          favorites: [
            Book(id: 1, title: 'Flutter'),
            Book(id: 2, title: 'Dart'),
          ],
        ),
      ],
      verify: (bloc) {
        verify(mockGetFavoriteBooksUseCase(NoParams())).called(1);
      },
    );

    blocTest<FavoriteBloc, FavoriteState>(
      // ignore: lines_longer_than_80_chars
      'emits [FavoriteLoading, FavoriteError] when GetFavoriteBooksEvent is added and getFavoriteBooksUseCase fails',
      build: () {
        when(mockGetFavoriteBooksUseCase(any))
            // ignore: inference_failure_on_instance_creation
            .thenAnswer((_) async => Left(ServerFailure()));

        return favoriteBloc;
      },
      act: (bloc) => bloc.add(GetFavoriteBooksEvent()),
      expect: () => [
        FavoriteLoading(),
        const FavoriteError(message: 'server_error'),
      ],
      verify: (bloc) {
        verify(mockGetFavoriteBooksUseCase(NoParams())).called(1);
      },
    );
  });
}

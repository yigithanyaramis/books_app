import 'package:books_app/core/network/network_info.dart';
import 'package:books_app/core/network/network_info_impl.dart';
import 'package:books_app/core/services/notification_service/notification_service.dart';
import 'package:books_app/core/services/notification_service/notification_service_impl.dart';
import 'package:books_app/data/core/app_dio.dart';
import 'package:books_app/data/core/app_hive.dart';
import 'package:books_app/data/datasources/local/book_local_data_source.dart';
import 'package:books_app/data/datasources/local/book_local_data_source_impl.dart';
import 'package:books_app/data/datasources/remote/book_remote_data_source.dart';
import 'package:books_app/data/datasources/remote/book_remote_data_source_impl.dart';
import 'package:books_app/data/repositories/book_repository_impl.dart';
import 'package:books_app/domain/repositories/book_repository.dart';
import 'package:books_app/domain/usecases/add_to_favorites_usecase.dart';
import 'package:books_app/domain/usecases/check_favorite_status_usecase.dart';
import 'package:books_app/domain/usecases/get_book_by_id_usecase.dart';
import 'package:books_app/domain/usecases/get_books_usecase.dart';
import 'package:books_app/domain/usecases/get_favorite_books_usecase.dart';
import 'package:books_app/domain/usecases/remove_from_favorites_usecase.dart';
import 'package:books_app/presentation/bloc/book/book_bloc.dart';
import 'package:books_app/presentation/bloc/detail/detail_bloc.dart';
import 'package:books_app/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:books_app/presentation/bloc/theme/theme_bloc.dart';
import 'package:books_app/presentation/route/app_router.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  final bookHive = AppHive<dynamic>();
  await bookHive.init('bookBox');

  final bookListHive = AppHive<List<dynamic>>();
  await bookListHive.init('booksBox');

  final favoriteBooksListHive = AppHive<List<dynamic>>();
  await favoriteBooksListHive.init('favoriteBooksBox');

  getIt
    ..registerSingleton(AppRouter())
    ..registerSingleton<NetworkInfo>(NetworkInfoImpl())
    ..registerSingleton<NotificationService>(NotificationServiceImpl())
    ..registerSingleton<Dio>(AppDio())
    ..registerSingleton<AppHive<dynamic>>(bookHive)
    ..registerSingleton<AppHive<List<dynamic>>>(bookListHive)
    ..registerSingleton<BookRemoteDataSource>(
      BookRemoteDataSourceImpl(getIt()),
    )
    ..registerSingleton<BookLocalDataSource>(
      BookLocalDataSourceImpl(getIt(), getIt(), getIt()),
    )
    ..registerSingleton<BookRepository>(
      BookRepositoryImpl(
        remoteDataSource: getIt(),
        localDataSource: getIt(),
        networkInfo: getIt(),
      ),
    )
    ..registerSingleton<GetBooksUseCase>(
      GetBooksUseCase(repository: getIt()),
    )
    ..registerSingleton<GetBookByIdUseCase>(
      GetBookByIdUseCase(repository: getIt()),
    )
    ..registerSingleton<AddToFavoritesUseCase>(
      AddToFavoritesUseCase(repository: getIt()),
    )
    ..registerSingleton<RemoveFromFavoritesUseCase>(
      RemoveFromFavoritesUseCase(repository: getIt()),
    )
    ..registerSingleton<CheckFavoriteStatusUseCase>(
      CheckFavoriteStatusUseCase(repository: getIt()),
    )
    ..registerSingleton<GetFavoriteBooksUseCase>(
      GetFavoriteBooksUseCase(repository: getIt()),
    )
    ..registerFactory<ThemeBloc>(
      ThemeBloc.new,
    )
    ..registerFactory<BookBloc>(
      () => BookBloc(
        getBooksUseCase: getIt(),
      ),
    )
    ..registerSingleton<FavoriteBloc>(
      FavoriteBloc(
        getFavoriteBooksUseCase: getIt(),
      ),
    )
    ..registerFactory<DetailBloc>(
      () => DetailBloc(
        notificationService: getIt(),
        getBookByIdUseCase: getIt(),
        addToFavoritesUseCase: getIt(),
        removeFromFavoritesUseCase: getIt(),
        checkFavoriteStatusUseCase: getIt(),
      ),
    );
}

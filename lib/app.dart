import 'package:auto_route/auto_route.dart';
import 'package:books_app/di/di.dart';
import 'package:books_app/foundation/extensions/string_extension.dart';
import 'package:books_app/foundation/generated/locale_keys.g.dart';
import 'package:books_app/presentation/bloc/book/book_bloc.dart';
import 'package:books_app/presentation/bloc/detail/detail_bloc.dart';
import 'package:books_app/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:books_app/presentation/bloc/theme/theme_bloc.dart';
import 'package:books_app/presentation/route/app_router.dart';
import 'package:books_app/presentation/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ThemeBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<BookBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<FavoriteBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<DetailBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          var themeMode = ThemeMode.system;
          if (state is ThemeUpdated) {
            themeMode = state.themeMode;
          }
          return MaterialApp.router(
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (context) => LocaleKeys.app_name.translate,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            routerConfig: getIt<AppRouter>().config(
              deepLinkTransformer: DeepLink.prefixStripper('detail'),
            ),
            theme: AppTheme.light().data,
            darkTheme: AppTheme.dark().data,
            themeMode: themeMode,
          );
        },
      ),
    );
  }
}

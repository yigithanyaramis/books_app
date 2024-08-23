import 'package:auto_route/auto_route.dart';
import 'package:books_app/presentation/pages/dashboard_screen.dart';
import 'package:books_app/presentation/pages/detail_screen.dart';
import 'package:books_app/presentation/pages/favorites_screen.dart';
import 'package:books_app/presentation/pages/home_screen.dart';
import 'package:books_app/presentation/pages/settings_screen.dart';
import 'package:books_app/presentation/pages/splash_screen.dart';
import 'package:books_app/presentation/route/route_paths.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
final class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
          path: RoutePaths.splash,
        ),
        AutoRoute(
          page: DashboardRoute.page,
          path: RoutePaths.dashboard,
          children: [
            AutoRoute(
              page: HomeRoute.page,
              path: RoutePaths.home,
            ),
            AutoRoute(
              page: FavoritesRoute.page,
              path: RoutePaths.favorites,
            ),
            AutoRoute(
              page: SettingsRoute.page,
              path: RoutePaths.settings,
            ),
          ],
        ),
        AutoRoute(
          page: DetailRoute.page,
          path: RoutePaths.detail,
        ),
      ];
}

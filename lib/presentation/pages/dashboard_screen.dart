import 'package:auto_route/auto_route.dart';
import 'package:books_app/presentation/route/app_router.dart';
import 'package:books_app/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
final class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        FavoritesRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (context, router) {
        return CustomBottomNavigationBar(
          router: router,
        );
      },
    );
  }
}

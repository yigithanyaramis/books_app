// ignore_for_file: deprecated_member_use
import 'package:books_app/foundation/constants/size_constants.dart';
import 'package:books_app/presentation/theme/app_colors_dark.dart';
import 'package:books_app/presentation/theme/app_colors_light.dart';
import 'package:books_app/presentation/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

final class AppTheme {
  factory AppTheme.light() {
    final theme = ThemeData.light();
    final textTheme = AppTextTheme(AppColorsLight.primary).textTheme;
    return AppTheme._(
      mode: ThemeMode.light,
      data: theme.copyWith(
        primaryColor: AppColorsLight.primary,
        textTheme: textTheme,
        scaffoldBackgroundColor: AppColorsLight.background,
        splashColor: Colors.transparent,
        canvasColor: AppColorsLight.surface,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColorsLight.primary,
          background: AppColorsLight.background,
          surface: AppColorsLight.surface,
          primary: AppColorsLight.primary,
          secondary: AppColorsLight.secondary,
          error: AppColorsLight.error,
          onPrimary: AppColorsLight.onPrimary,
          onSecondary: AppColorsLight.onSecondary,
          onSurface: AppColorsLight.onSurface,
          onError: AppColorsLight.onError,
          onBackground: AppColorsLight.onBackground,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColorsLight.background,
          selectedItemColor: AppColorsLight.primary,
          unselectedItemColor: AppColorsLight.secondary,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColorsLight.background,
          surfaceTintColor: AppColorsLight.background,
          centerTitle: true,
          titleTextStyle: textTheme.titleSmall,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.all(AppColorsLight.primary),
          trackColor: WidgetStateProperty.all(AppColorsLight.surface),
        ),
        cardTheme: const CardTheme(
          color: AppColorsLight.surface,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColorsLight.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.k8),
            ),
            textStyle: textTheme.displayMedium?.copyWith(),
            foregroundColor: AppColorsLight.onPrimary,
            minimumSize: const Size(double.infinity, Sizes.k56),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColorsLight.surface,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizes.k8),
            borderSide: const BorderSide(
              color: AppColorsLight.primary,
            ),
          ),
          hintStyle: textTheme.bodyLarge?.copyWith(
            color: AppColorsLight.onSurface.withOpacity(0.6),
          ),
          labelStyle: textTheme.bodyLarge?.copyWith(
            color: AppColorsLight.onSurface,
          ),
          prefixIconColor: AppColorsLight.onSurface.withOpacity(0.6),
        ),
      ),
    );
  }

  factory AppTheme.dark() {
    final theme = ThemeData.dark();
    final textTheme = AppTextTheme(AppColorsDark.primary).textTheme;
    return AppTheme._(
      mode: ThemeMode.dark,
      data: theme.copyWith(
        primaryColor: AppColorsDark.primary,
        textTheme: textTheme,
        scaffoldBackgroundColor: AppColorsDark.background,
        splashColor: Colors.transparent,
        canvasColor: AppColorsDark.surface,
        highlightColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColorsDark.primary,
          background: AppColorsDark.background,
          surface: AppColorsDark.surface,
          primary: AppColorsDark.primary,
          secondary: AppColorsDark.secondary,
          error: AppColorsDark.error,
          onPrimary: AppColorsDark.onPrimary,
          onSecondary: AppColorsDark.onSecondary,
          onSurface: AppColorsDark.onSurface,
          onError: AppColorsDark.onError,
          onBackground: AppColorsDark.onBackground,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColorsDark.background,
          selectedItemColor: AppColorsDark.primary,
          unselectedItemColor: AppColorsDark.secondary,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColorsDark.background,
          surfaceTintColor: AppColorsDark.background,
          centerTitle: true,
          titleTextStyle: textTheme.titleSmall,
        ),
        cardTheme: const CardTheme(
          color: AppColorsDark.surface,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.all(AppColorsDark.primary),
          trackColor: WidgetStateProperty.all(AppColorsDark.surface),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColorsDark.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.k8),
            ),
            textStyle: textTheme.displayMedium?.copyWith(),
            foregroundColor: AppColorsDark.onPrimary,
            minimumSize: const Size(double.infinity, Sizes.k56),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColorsDark.surface,
          focusColor: AppColorsDark.surface,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizes.k8),
            borderSide: const BorderSide(
              color: AppColorsDark.primary,
            ),
          ),
          hintStyle: textTheme.bodyLarge?.copyWith(
            color: AppColorsDark.onSurface.withOpacity(0.6),
          ),
          labelStyle: textTheme.bodyLarge?.copyWith(
            color: AppColorsDark.onSurface,
          ),
          prefixIconColor: AppColorsDark.onSurface.withOpacity(0.6),
        ),
      ),
    );
  }

  const AppTheme._({
    required this.mode,
    required this.data,
  });

  final ThemeMode mode;
  final ThemeData data;
}

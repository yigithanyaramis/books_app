import 'package:books_app/foundation/constants/size_constants.dart';
import 'package:flutter/material.dart';

final class AppTextTheme {
  factory AppTextTheme(Color color) {
    return AppTextTheme._(
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: Sizes.k48,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        headlineMedium: TextStyle(
          fontSize: Sizes.k32,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        headlineSmall: TextStyle(
          fontSize: Sizes.k28,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        titleLarge: TextStyle(
          fontSize: Sizes.k24,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        titleMedium: TextStyle(
          fontSize: Sizes.k22,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        titleSmall: TextStyle(
          fontSize: Sizes.k20,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        displayLarge: TextStyle(
          fontSize: Sizes.k18,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        displayMedium: TextStyle(
          fontSize: Sizes.k16,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        displaySmall: TextStyle(
          fontSize: Sizes.k13,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        bodyLarge: TextStyle(
          fontSize: Sizes.k18,
          fontWeight: FontWeight.w500,
          color: color,
        ),
        bodyMedium: TextStyle(
          fontSize: Sizes.k16,
          fontWeight: FontWeight.w500,
          color: color,
        ),
        bodySmall: TextStyle(
          fontSize: Sizes.k13,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  const AppTextTheme._({
    required this.textTheme,
  });
  final TextTheme textTheme;
}

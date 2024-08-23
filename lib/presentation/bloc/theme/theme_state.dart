part of 'theme_bloc.dart';

abstract class ThemeState {}

final class ThemeInitial extends ThemeState {}

final class ThemeUpdated extends ThemeState {
  ThemeUpdated(this.themeMode);
  final ThemeMode themeMode;
}

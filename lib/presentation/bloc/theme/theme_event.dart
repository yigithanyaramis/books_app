part of 'theme_bloc.dart';

abstract class ThemeEvent {}

final class ThemeChanged extends ThemeEvent {
  ThemeChanged(this.themeMode);
  final ThemeMode themeMode;
}

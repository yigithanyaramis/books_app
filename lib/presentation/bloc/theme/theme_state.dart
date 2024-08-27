part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState {}

final class ThemeUpdated extends ThemeState {
  const ThemeUpdated(this.themeMode);
  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}

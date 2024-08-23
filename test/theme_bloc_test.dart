import 'package:bloc_test/bloc_test.dart';
import 'package:books_app/presentation/bloc/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThemeBloc', () {
    late ThemeBloc themeBloc;

    setUp(() {
      themeBloc = ThemeBloc();
    });

    tearDown(() {
      themeBloc.close();
    });

    test('initial state should be ThemeInitial', () {
      expect(themeBloc.state, equals(ThemeInitial()));
    });

    blocTest<ThemeBloc, ThemeState>(
      'emits [ThemeUpdated] when ThemeChanged is added with ThemeMode.light',
      build: () => themeBloc,
      act: (bloc) => bloc.add(ThemeChanged(ThemeMode.light)),
      expect: () => [ThemeUpdated(ThemeMode.light)],
    );

    blocTest<ThemeBloc, ThemeState>(
      'emits [ThemeUpdated] when ThemeChanged is added with ThemeMode.dark',
      build: () => themeBloc,
      act: (bloc) => bloc.add(ThemeChanged(ThemeMode.dark)),
      expect: () => [ThemeUpdated(ThemeMode.dark)],
    );

    blocTest<ThemeBloc, ThemeState>(
      'emits [ThemeUpdated] when ThemeChanged is added with ThemeMode.system',
      build: () => themeBloc,
      act: (bloc) => bloc.add(ThemeChanged(ThemeMode.system)),
      expect: () => [ThemeUpdated(ThemeMode.system)],
    );
  });
}

import 'package:auto_route/auto_route.dart';
import 'package:books_app/foundation/extensions/string_extension.dart';
import 'package:books_app/foundation/generated/locale_keys.g.dart';
import 'package:books_app/presentation/bloc/theme/theme_bloc.dart';
import 'package:books_app/presentation/widgets/language_change_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
final class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

final class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settings.translate),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(LocaleKeys.theme.translate),
            trailing: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                var isDarkMode = false;
                if (state is ThemeUpdated) {
                  isDarkMode = state.themeMode == ThemeMode.dark;
                }
                return Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    final newThemeMode =
                        value ? ThemeMode.dark : ThemeMode.light;
                    context.read<ThemeBloc>().add(ThemeChanged(newThemeMode));
                  },
                );
              },
            ),
          ),
          const LanguageChangeDropdown(),
        ],
      ),
    );
  }
}

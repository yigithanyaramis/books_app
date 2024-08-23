import 'package:auto_route/auto_route.dart';
import 'package:books_app/foundation/constants/localization_constants.dart';
import 'package:books_app/foundation/extensions/string_extension.dart';
import 'package:books_app/foundation/extensions/theme_extension.dart';
import 'package:books_app/foundation/generated/locale_keys.g.dart';
import 'package:books_app/presentation/route/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

final class LanguageChangeDropdown extends StatelessWidget {
  const LanguageChangeDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(LocaleKeys.language.translate),
      trailing: DropdownButton<Locale>(
        style: context.textTheme.bodyMedium,
        value: context.locale,
        items: [
          DropdownMenuItem(
            value: LocalizationConstants.en,
            child: Text(LocaleKeys.en.translate),
          ),
          DropdownMenuItem(
            value: LocalizationConstants.tr,
            child: Text(LocaleKeys.tr.translate),
          ),
        ],
        onChanged: (Locale? locale) {
          if (locale != null) {
            context.setLocale(locale);
            context.router.pushAndPopUntil(
              const SettingsRoute(),
              predicate: (route) => false,
            );
          }
        },
      ),
    );
  }
}

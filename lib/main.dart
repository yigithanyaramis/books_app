import 'dart:async';

import 'package:books_app/app.dart';
import 'package:books_app/data/models/book_model.dart';
import 'package:books_app/data/models/villain_model.dart';
import 'package:books_app/di/di.dart' as di;
import 'package:books_app/foundation/constants/localization_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();

      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive
        ..init(appDocumentDir.path)
        ..registerAdapter(BookModelAdapter())
        ..registerAdapter(VillainModelAdapter());

      await di.setup();
      EasyLocalization.logger.enableBuildModes = [];

      runApp(
        EasyLocalization(
          supportedLocales: LocalizationConstants.supportedLocales,
          path: LocalizationConstants.path,
          fallbackLocale: LocalizationConstants.fallbackLocale,
          useOnlyLangCode: true,
          child: const App(),
        ),
      );
    },
    (error, stack) {
      debugPrint('Error: $error');
      debugPrint('Stack: $stack');
    },
  );
}

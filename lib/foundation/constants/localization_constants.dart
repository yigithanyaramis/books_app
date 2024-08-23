import 'package:flutter/material.dart';

class LocalizationConstants {
  LocalizationConstants._();
  static const Locale tr = Locale('tr');
  static const Locale en = Locale('en');

  static const List<Locale> supportedLocales = [tr, en];

  static const fallbackLocale = en;

  static const String path = 'assets/translations';
}

import 'package:easy_localization/easy_localization.dart';

extension StringExtension on String? {
  static const _notFound = '404';

  String get translate => this?.tr() ?? _notFound;

  String? capitalizeFirstLetter() {
    if (this == null) return null;
    if (this!.isEmpty) return this;
    return this![0].toUpperCase() + this!.substring(1);
  }
}

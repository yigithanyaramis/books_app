import 'package:books_app/core/error/failures.dart';
import 'package:books_app/foundation/extensions/string_extension.dart';
import 'package:books_app/foundation/generated/locale_keys.g.dart';

extension FailureMessageExtension on Failure {
  String mapToMessage() {
    switch (runtimeType) {
      case ServerFailure:
        return LocaleKeys.server_error.translate;
      case CacheFailure:
        return LocaleKeys.cache_error.translate;
      default:
        return LocaleKeys.error.translate;
    }
  }
}

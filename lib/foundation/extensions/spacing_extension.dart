import 'package:books_app/foundation/extensions/media_query_extension.dart';
import 'package:flutter/widgets.dart';

extension SpacingExtension on BuildContext {
  SizedBox get spacingLowHeight => SizedBox(height: lowHeight);
  SizedBox get spacingNormalHeight => SizedBox(height: normalHeight);
  SizedBox get spacingMediumHeight => SizedBox(height: mediumHeight);
  SizedBox get spacingHighHeight => SizedBox(height: highHeight);

  SizedBox get spacingLowWidth => SizedBox(width: lowWidth);
  SizedBox get spacingNormalWidth => SizedBox(width: normalWidth);
  SizedBox get spacingMediumWidth => SizedBox(width: mediumWidth);
  SizedBox get spacingHighWidth => SizedBox(width: highWidth);
}

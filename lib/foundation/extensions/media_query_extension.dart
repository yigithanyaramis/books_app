import 'package:books_app/foundation/constants/padding_constants.dart';
import 'package:flutter/widgets.dart';

extension MediaQueryExtension on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;

  double get lowHeight => screenHeight * PaddingConstants.low;
  double get normalHeight => screenHeight * PaddingConstants.normal;
  double get mediumHeight => screenHeight * PaddingConstants.medium;
  double get highHeight => screenHeight * PaddingConstants.high;

  double get lowWidth => screenWidth * PaddingConstants.low;
  double get normalWidth => screenWidth * PaddingConstants.normal;
  double get mediumWidth => screenWidth * PaddingConstants.medium;
  double get highWidth => screenWidth * PaddingConstants.high;

  double dynamicWidth(double value) => screenWidth * value;
  double dynamicHeight(double value) => screenHeight * value;
}

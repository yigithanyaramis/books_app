import 'package:books_app/foundation/extensions/radius_extension.dart';
import 'package:flutter/widgets.dart';

extension BorderRadiusExtension on BuildContext {
  BorderRadius get borderRadiusLowAll => BorderRadius.all(lowRadius);
  BorderRadius get borderRadiusNormalAll => BorderRadius.all(normalRadius);
  BorderRadius get borderRadiusMediumAll => BorderRadius.all(mediumRadius);
  BorderRadius get borderRadiusHighAll => BorderRadius.all(highRadius);

  BorderRadius get borderRadiusLowTop => BorderRadius.vertical(top: lowRadius);
  BorderRadius get borderRadiusNormalTop =>
      BorderRadius.vertical(top: normalRadius);
  BorderRadius get borderRadiusMediumTop =>
      BorderRadius.vertical(top: mediumRadius);
  BorderRadius get borderRadiusHighTop =>
      BorderRadius.vertical(top: highRadius);

  BorderRadius get borderRadiusLowBottom =>
      BorderRadius.vertical(bottom: lowRadius);
  BorderRadius get borderRadiusNormalBottom =>
      BorderRadius.vertical(bottom: normalRadius);
  BorderRadius get borderRadiusMediumBottom =>
      BorderRadius.vertical(bottom: mediumRadius);
  BorderRadius get borderRadiusHighBottom =>
      BorderRadius.vertical(bottom: highRadius);
}

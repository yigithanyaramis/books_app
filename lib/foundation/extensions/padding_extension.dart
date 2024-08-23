import 'package:books_app/foundation/extensions/media_query_extension.dart';
import 'package:flutter/widgets.dart';

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingLowAll =>
      EdgeInsets.symmetric(vertical: lowHeight, horizontal: lowWidth);
  EdgeInsets get paddingNormalAll =>
      EdgeInsets.symmetric(vertical: normalHeight, horizontal: normalWidth);
  EdgeInsets get paddingMediumAll =>
      EdgeInsets.symmetric(vertical: mediumHeight, horizontal: mediumWidth);
  EdgeInsets get paddingHighAll =>
      EdgeInsets.symmetric(vertical: highHeight, horizontal: highWidth);

  EdgeInsets get paddingLowVertical =>
      EdgeInsets.symmetric(vertical: lowHeight);
  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalHeight);
  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumHeight);
  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: highHeight);

  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: lowWidth);
  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalWidth);
  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumWidth);
  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: highWidth);

  EdgeInsets get paddingLowTop => EdgeInsets.only(top: lowHeight);
  EdgeInsets get paddingNormalTop => EdgeInsets.only(top: normalHeight);
  EdgeInsets get paddingMediumTop => EdgeInsets.only(top: mediumHeight);
  EdgeInsets get paddingHighTop => EdgeInsets.only(top: highHeight);

  EdgeInsets get paddingLowBottom => EdgeInsets.only(bottom: lowHeight);
  EdgeInsets get paddingNormalBottom => EdgeInsets.only(bottom: normalHeight);
  EdgeInsets get paddingMediumBottom => EdgeInsets.only(bottom: mediumHeight);
  EdgeInsets get paddingHighBottom => EdgeInsets.only(bottom: highHeight);

  EdgeInsets get paddingLowLeft => EdgeInsets.only(left: lowWidth);
  EdgeInsets get paddingNormalLeft => EdgeInsets.only(left: normalWidth);
  EdgeInsets get paddingMediumLeft => EdgeInsets.only(left: mediumWidth);
  EdgeInsets get paddingHighLeft => EdgeInsets.only(left: highWidth);

  EdgeInsets get paddingLowRight => EdgeInsets.only(right: lowWidth);
  EdgeInsets get paddingNormalRight => EdgeInsets.only(right: normalWidth);
  EdgeInsets get paddingMediumRight => EdgeInsets.only(right: mediumWidth);
  EdgeInsets get paddingHighRight => EdgeInsets.only(right: highWidth);
}

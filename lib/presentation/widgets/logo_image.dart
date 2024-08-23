import 'package:books_app/foundation/constants/image_asset_constants.dart';
import 'package:books_app/foundation/extensions/border_radius_extension.dart';
import 'package:books_app/foundation/extensions/media_query_extension.dart';
import 'package:flutter/material.dart';

final class LogoImage extends StatelessWidget {
  const LogoImage({
    this.dynamicHeight,
    this.borderRadius,
    super.key,
  });

  final double? dynamicHeight;
  final BorderRadiusGeometry? borderRadius;

  double get _standartDynamicHeight => 0.25;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dynamicHeight ?? context.dynamicHeight(_standartDynamicHeight),
      child: ClipRRect(
        borderRadius: borderRadius ?? context.borderRadiusHighAll,
        child: Image.asset(ImageAssetsConstants.logo),
      ),
    );
  }
}

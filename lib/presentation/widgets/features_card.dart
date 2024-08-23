import 'package:books_app/domain/entities/book.dart';
import 'package:books_app/foundation/constants/image_asset_constants.dart';
import 'package:books_app/foundation/extensions/media_query_extension.dart';
import 'package:books_app/foundation/extensions/padding_extension.dart';
import 'package:books_app/foundation/extensions/spacing_extension.dart';
import 'package:books_app/foundation/extensions/string_extension.dart';
import 'package:books_app/foundation/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

final class FeaturesCard extends StatelessWidget {
  const FeaturesCard({required this.book, super.key});

  final Book book;
  int get _expandedFlex => 2;
  double get _dynamicHeight => .25;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: context.paddingLowAll,
        child: Row(
          children: [
            Image.asset(
              ImageAssetsConstants.book,
              width: context.dynamicWidth(_dynamicHeight),
            ),
            context.spacingMediumWidth,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (book.title != null)
                    _buildRowText(
                      LocaleKeys.title.translate,
                      book.title!,
                    ),
                  if (book.year != null) ...[
                    context.spacingLowHeight,
                    _buildRowText(
                      LocaleKeys.year.translate,
                      book.year.toString(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowText(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            '$title:',
          ),
        ),
        Expanded(
          flex: _expandedFlex,
          child: Text(
            value,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

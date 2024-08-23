import 'package:books_app/domain/entities/book.dart';
import 'package:books_app/foundation/extensions/padding_extension.dart';
import 'package:books_app/foundation/extensions/spacing_extension.dart';
import 'package:books_app/foundation/extensions/string_extension.dart';
import 'package:books_app/foundation/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

final class OtherFeaturesCard extends StatelessWidget {
  const OtherFeaturesCard({required this.book, super.key});

  final Book book;
  int get _expandedFlex => 2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: context.paddingNormalAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (book.pages != null)
                _buildRowText(
                  LocaleKeys.pages.translate,
                  book.pages.toString(),
                ),
              if (book.publisher != null) ...[
                context.spacingLowHeight,
                _buildRowText(
                  LocaleKeys.publisher.translate,
                  book.publisher!,
                ),
              ],
              if (book.isbn != null) ...[
                context.spacingLowHeight,
                _buildRowText(
                  LocaleKeys.isbn.translate,
                  book.isbn.toString(),
                ),
              ],
              if (book.notes?.isNotEmpty ?? false) ...[
                context.spacingLowHeight,
                _buildRowText(
                  LocaleKeys.notes.translate,
                  book.notes!.first,
                ),
              ],
            ],
          ),
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

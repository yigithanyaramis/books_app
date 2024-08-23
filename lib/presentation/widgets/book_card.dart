import 'package:auto_route/auto_route.dart';
import 'package:books_app/domain/entities/book.dart';
import 'package:books_app/foundation/constants/icon_size_constants.dart';
import 'package:books_app/foundation/constants/image_asset_constants.dart';
import 'package:books_app/foundation/extensions/border_radius_extension.dart';
import 'package:books_app/foundation/extensions/spacing_extension.dart';
import 'package:books_app/presentation/route/app_router.dart';
import 'package:flutter/material.dart';

final class BookCard extends StatefulWidget {
  const BookCard({required this.book, super.key});

  final Book book;

  @override
  State<BookCard> createState() => _BookCardState();
}

final class _BookCardState extends State<BookCard> {
  final int _maxLines = 2;
  final double _positioned = 16;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          context.router.push(DetailRoute(id: widget.book.id.toString())),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: context.borderRadiusLowAll,
        ),
        child: Stack(
          children: [
            _buildImage(),
            _buildGradientOverlay(),
            _buildBookInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: context.borderRadiusLowAll,
      child: Image.asset(
        ImageAssetsConstants.book,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: context.borderRadiusLowAll,
        gradient: const LinearGradient(
          colors: [
            Colors.black,
            Colors.transparent,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
    );
  }

  Widget _buildBookInfo() {
    return Positioned(
      bottom: _positioned,
      left: _positioned,
      right: _positioned,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          context.spacingLowHeight,
          _buildYear(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.book.title ?? '',
      maxLines: _maxLines,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          ),
    );
  }

  Widget _buildYear() {
    return Row(
      children: [
        const Icon(
          Icons.calendar_today,
          size: IconSizeConstants.n,
          color: Colors.white,
        ),
        context.spacingLowWidth,
        Text(
          widget.book.year?.toString() ?? '',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ],
    );
  }
}

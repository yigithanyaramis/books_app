import 'package:books_app/domain/entities/book.dart';
import 'package:books_app/presentation/bloc/detail/detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({required this.book, super.key});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: book.isFavorite == false
          ? const Icon(Icons.favorite_border_outlined)
          : const Icon(Icons.favorite),
      onPressed: () {
        context.read<DetailBloc>().add(
              book.isFavorite == false
                  ? AddToFavoritesEvent(book: book)
                  : RemoveFromFavoritesEvent(
                      book: book,
                    ),
            );
      },
    );
  }
}

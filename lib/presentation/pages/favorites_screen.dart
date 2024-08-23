import 'package:auto_route/auto_route.dart';
import 'package:books_app/foundation/extensions/string_extension.dart';
import 'package:books_app/foundation/generated/locale_keys.g.dart';
import 'package:books_app/presentation/bloc/favorite/favorite_bloc.dart';
import 'package:books_app/presentation/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
final class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

final class _FavoritesScreenState extends State<FavoritesScreen> {
  final int _crossAxisCount = 2;
  final double _childAspectRatio = 1.5;

  @override
  void initState() {
    context.read<FavoriteBloc>().add(GetFavoriteBooksEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(LocaleKeys.favorites.translate),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is FavoriteInitial || state is FavoriteLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is FavoriteError) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is FavoriteLoaded) {
                if (state.favorites.isEmpty) {
                  return Center(
                    child: Text(LocaleKeys.no_books.translate),
                  );
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _crossAxisCount,
                    childAspectRatio: _childAspectRatio,
                  ),
                  itemCount: state.favorites.length,
                  itemBuilder: (context, index) {
                    final book = state.favorites[index];
                    return BookCard(book: book);
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}

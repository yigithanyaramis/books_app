import 'package:auto_route/auto_route.dart';
import 'package:books_app/foundation/extensions/padding_extension.dart';
import 'package:books_app/foundation/extensions/string_extension.dart';
import 'package:books_app/foundation/generated/locale_keys.g.dart';
import 'package:books_app/presentation/bloc/book/book_bloc.dart';
import 'package:books_app/presentation/mixins/home_mixin.dart';
import 'package:books_app/presentation/widgets/book_card.dart';
import 'package:books_app/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
final class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final class _HomeScreenState extends State<HomeScreen> with HomeMixin {
  final double _searchTextFieldHeight = 48;
  final int _crossAxisCount = 2;
  final double _childAspectRatio = 1.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(LocaleKeys.books.translate),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(_searchTextFieldHeight),
        child: Padding(
          padding: context.paddingLowAll,
          child: SearchTextField(
            controller: searchController,
            onChanged: searchOnChanged,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<BookBloc, BookState>(
            builder: (context, state) {
              if (state is BookInitial || state is BookLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is BookError) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is BookLoaded) {
                if (state.filteredBooks.isEmpty) {
                  return Center(
                    child: Text(LocaleKeys.no_books.translate),
                  );
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _crossAxisCount,
                    childAspectRatio: _childAspectRatio,
                  ),
                  itemCount: state.filteredBooks.length,
                  itemBuilder: (context, index) {
                    final book = state.filteredBooks[index];
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

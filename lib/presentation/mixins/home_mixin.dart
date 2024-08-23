import 'package:books_app/presentation/bloc/book/book_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin HomeMixin<T extends StatefulWidget> on State<T> {
  final TextEditingController searchController = TextEditingController();

  void searchOnChanged(String query) {
    context.read<BookBloc>().add(SearchBooksEvent(query: query));
  }
}

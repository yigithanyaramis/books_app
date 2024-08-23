import 'package:books_app/foundation/extensions/border_radius_extension.dart';
import 'package:books_app/foundation/extensions/string_extension.dart';
import 'package:books_app/foundation/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

final class SearchTextField extends StatelessWidget {
  const SearchTextField({
    required this.controller,
    required this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: LocaleKeys.search.translate,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: context.borderRadiusLowAll,
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChanged,
    );
  }
}

import 'package:books_app/domain/entities/book.dart';
import 'package:books_app/foundation/extensions/string_extension.dart';
import 'package:books_app/foundation/generated/locale_keys.g.dart';
import 'package:books_app/presentation/bloc/detail/detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin DetailMixin<T extends StatefulWidget> on State<T> {
  final TextEditingController searchController = TextEditingController();

  Future<void> reminderOnPressed({
    required Book book,
    required bool hasReminder,
  }) async {
    {
      if (hasReminder) {
        context
            .read<DetailBloc>()
            .add(RemoveReminderEvent(bookId: book.id.toString()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(LocaleKeys.reminder_deleted.translate)),
        );
      } else {
        final pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (pickedTime != null) {
          final now = DateTime.now();
          final scheduledTime = DateTime(
            now.year,
            now.month,
            now.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          if (mounted) {
            context.read<DetailBloc>().add(
                  SetReminderEvent(
                    bookId: book.id.toString(),
                    time: scheduledTime,
                  ),
                );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  // ignore: lines_longer_than_80_chars
                  '${LocaleKeys.reminder_created.translate}: ${pickedTime.format(context)}',
                ),
              ),
            );
          }
        }
      }
    }
  }
}

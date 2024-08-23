import 'package:auto_route/auto_route.dart';
import 'package:books_app/foundation/extensions/padding_extension.dart';
import 'package:books_app/foundation/extensions/spacing_extension.dart';
import 'package:books_app/foundation/extensions/string_extension.dart';
import 'package:books_app/foundation/generated/locale_keys.g.dart';
import 'package:books_app/presentation/bloc/detail/detail_bloc.dart';
import 'package:books_app/presentation/mixins/detail_mixin.dart';
import 'package:books_app/presentation/widgets/favorite_icon_button.dart';
import 'package:books_app/presentation/widgets/features_card.dart';
import 'package:books_app/presentation/widgets/other_features_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
final class DetailScreen extends StatefulWidget {
  const DetailScreen({
    @PathParam('id') required this.id,
    super.key,
  });
  final String id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

final class _DetailScreenState extends State<DetailScreen> with DetailMixin {
  @override
  void initState() {
    context.read<DetailBloc>().add(GetBookByIdEvent(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: context.paddingLowAll,
        child: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(LocaleKeys.book.translate),
      actions: [
        BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state is DetailLoaded) {
              return FavoriteIconButton(book: state.book);
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return BlocListener<DetailBloc, DetailState>(
      listener: (context, state) {
        if (state is FavoritesUpdated) {
          context
              .read<DetailBloc>()
              .add(CheckFavoriteStatusEvent(bookId: widget.id));
        }
      },
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state is DetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailLoaded) {
            return Column(
              children: [
                // ignore: use_if_null_to_convert_nulls_to_bools
                if (state.book.isFavorite == true) ...[
                  context.spacingLowHeight,
                  ElevatedButton(
                    onPressed: () => reminderOnPressed(
                      book: state.book,
                      hasReminder: state.hasReminder,
                    ),
                    child: Text(
                      state.hasReminder
                          ? LocaleKeys.reminder_delete.translate
                          : LocaleKeys.reminder_create.translate,
                    ),
                  ),
                ],
                FeaturesCard(book: state.book),
                OtherFeaturesCard(book: state.book),
                if (state.book.villains?.isNotEmpty ?? false) ...[
                  context.spacingLowHeight,
                  Text(
                    LocaleKeys.villains.translate,
                  ),
                  Expanded(
                    child: _buildVillainListView(state),
                  ),
                ],
              ],
            );
          } else if (state is DetailError) {
            return Center(
              child: Text(state.message),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildVillainListView(DetailLoaded state) {
    return ListView.builder(
      itemCount: state.book.villains?.length,
      itemBuilder: (context, index) {
        final villain = state.book.villains![index];
        return Card(
          child: Padding(
            padding: context.paddingNormalAll,
            child: Text(villain.name ?? ''),
          ),
        );
      },
    );
  }
}

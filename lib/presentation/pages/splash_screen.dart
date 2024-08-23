import 'package:auto_route/auto_route.dart';
import 'package:books_app/foundation/extensions/spacing_extension.dart';
import 'package:books_app/presentation/bloc/book/book_bloc.dart';
import 'package:books_app/presentation/route/app_router.dart';
import 'package:books_app/presentation/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
final class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookBloc>().add(GetBooksEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookBloc, BookState>(
      listener: (context, state) {
        if (state is BookLoaded) {
          context.router.replace(const HomeRoute());
        } else if (state is BookError) {
          context.router.replace(const HomeRoute());
        }
      },
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: LogoImage(),
        ),
        context.spacingMediumHeight,
        const CircularProgressIndicator(),
      ],
    );
  }
}

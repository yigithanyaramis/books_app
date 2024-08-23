import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

final class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    required this.router,
    super.key,
  });

  final TabsRouter router;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: router.setActiveIndex,
      currentIndex: router.activeIndex,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.book), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final Color backgroundColor;

  const CustomBottomNav({
    super.key,
    this.backgroundColor = Colors.white, // Default to white if not passed
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: backgroundColor,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}

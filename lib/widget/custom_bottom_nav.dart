import 'package:flutter/material.dart';
import 'package:flutter_cms/global/get_text_color.dart';

class CustomBottomNav extends StatelessWidget {
  final Color backgroundColor;

  const CustomBottomNav({
    super.key,
    this.backgroundColor = Colors.white, // Default to white if not passed
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = getTextColor(backgroundColor);

    return BottomNavigationBar(
      backgroundColor: backgroundColor,
      selectedItemColor: textColor, // Label color for selected item
      unselectedItemColor:
          textColor.withOpacity(0.6), // Label color for unselected items
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: textColor,
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: textColor,
            ),
            label: 'Settings'),
      ],
    );
  }
}

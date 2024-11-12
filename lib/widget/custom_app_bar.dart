import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: themeService.bottomNavBarColor,
      title: const Text('TITLE'),
    );
  }
}

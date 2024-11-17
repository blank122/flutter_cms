import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor = Colors.white, // Default to white if not passed
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style: TextStyle(fontSize: 18.sp),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

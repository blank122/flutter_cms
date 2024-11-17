import 'package:flutter/material.dart';
import 'package:flutter_cms/services/change_themes.dart';
import 'package:flutter_cms/widget/custom_app_bar.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class CreateSystemThemeView extends StatefulWidget {
  //get the appbar color
  final Color appbarColor;
  const CreateSystemThemeView({super.key, required this.appbarColor});

  @override
  State<CreateSystemThemeView> createState() => _CreateSystemThemeViewState();
}

class _CreateSystemThemeViewState extends State<CreateSystemThemeView> {
  final ChangeThemes themesController = ChangeThemes();

  // String appBarColor = 'White';
  // String drawerColor = 'White';
  // String bottomNavColor = 'White';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Default color for Bottom Navigation Bar
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create System Theme',
        backgroundColor: widget.appbarColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Customize System Theme",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          Gap(3.h),
          // AppBar Color Dropdown
          Text(
            "System Theme Logo",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
          Gap(1.h),

          Text(
            "System Theme Title",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
          Gap(1.h),

          Center(
            child: ElevatedButton(
              onPressed: () {
                // themesController.showSaveThemesDialog(
                //     context, appBarColor, drawerColor, bottomNavColor);
              },
              child: const Text("Save Theme Settings"),
            ),
          ),
        ],
      ),
    );
  }
}

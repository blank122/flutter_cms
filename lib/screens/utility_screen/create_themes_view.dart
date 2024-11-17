import 'package:flutter/material.dart';
import 'package:flutter_cms/services/change_themes.dart';
import 'package:flutter_cms/services/color_dropdown.dart';
import 'package:flutter_cms/widget/custom_app_bar.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class CreateThemesView extends StatefulWidget {
  const CreateThemesView({super.key});

  @override
  State<CreateThemesView> createState() => _CreateThemesViewState();
}

class _CreateThemesViewState extends State<CreateThemesView> {
  final ChangeThemes themesController = ChangeThemes();

  String appBarColor = 'White';
  String drawerColor = 'White';
  String bottomNavColor = 'White';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Default color for Bottom Navigation Bar
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create Themes',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Customize Theme",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          Gap(3.h),
          // AppBar Color Dropdown
          Text(
            "AppBar Color",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
          ColorDropdown(
            selectedColor: appBarColor,
            onChanged: (color) {
              setState(() {
                appBarColor = color;
                print('color appbar: $color');
              });
            },
          ),
          Gap(1.h),
          Text(
            "Bottom Navigation Color",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
          ColorDropdown(
            selectedColor: bottomNavColor,
            onChanged: (color) {
              setState(() {
                bottomNavColor = color;
              });
            },
          ),
          Gap(1.h),
          Text(
            "Drawer Color",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
          ColorDropdown(
            selectedColor: drawerColor,
            onChanged: (color) {
              setState(() {
                drawerColor = color;
              });
            },
          ),
          Gap(1.h),
          Center(
            child: ElevatedButton(
              onPressed: () {
                themesController.showSaveThemesDialog(
                    context, appBarColor, drawerColor, bottomNavColor);
              },
              child: const Text("Save Theme Settings"),
            ),
          ),
        ],
      ),
    );
  }
}

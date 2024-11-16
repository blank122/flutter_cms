import 'package:flutter/material.dart';
import 'package:flutter_cms/screens/home.dart';
import 'package:flutter_cms/services/color_dropdown.dart';
import 'package:flutter_cms/widget/custom_app_bar.dart';
import 'package:flutter_cms/widget/reusable_alert_dialog.dart';
import 'package:flutter_cms/widget/reusable_snackbar.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CreateThemesView extends StatefulWidget {
  const CreateThemesView({super.key});

  @override
  State<CreateThemesView> createState() => _CreateThemesViewState();
}

class _CreateThemesViewState extends State<CreateThemesView> {
  String appBarColor = 'White';
  String drawerColor = 'White';
  String bottomNavColor = 'White';
  bool isLoading = false;
  void saveThemeSettings(String appBar, String drawer, String bottomNav) {
    // Display a snackbar to show saved settings
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Theme settings saved! AppBar: $appBar, Drawer: $drawer, Bottom Nav: $bottomNav",
        ),
      ),
    );

    // Here you can add code to save the settings in SQLite or any other local storage
  }

  Future<bool?> showCustomDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return ReusableAlertDialog(
          title: "Save themes?",
          description: "Would you like to save your progress?",
          primaryButtonText: "Save theme",
          onPrimaryButtonPressed: () async {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
            // await saveThemes();
          },
          secondaryButtonText: "Discard changes?",
          onSecondaryButtonPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
        );
      },
    );
  }

  Future<void> saveThemes(String themeTitle) async {
    try {
      // Convert survey data to JSON string

      DateTime now = DateTime.now();
      String formattedDateTime = DateFormat('MM/dd/yyyy HH:mm:ss').format(now);
      // Save to SQLite

      // Show success Snackbar
      if (mounted) {
        ReusableSnackbar.showSuccessSnackbar(
            context: context,
            description: "Themes has been saved successfully");
      }
    } catch (e) {
      print('Error occurred: $e');

      if (mounted) {
        ReusableSnackbar.showErrorSnackbar(
            context: context, description: "Something went wrong: $e");
      }
    } finally {
      setState(() {
        isLoading = false; // End loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Default color for Bottom Navigation Bar
    return Scaffold(
      appBar: const CustomAppBar(
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
                saveThemeSettings(appBarColor, drawerColor, bottomNavColor);
              },
              child: const Text("Save Theme Settings"),
            ),
          ),
        ],
      ),
    );
  }
}

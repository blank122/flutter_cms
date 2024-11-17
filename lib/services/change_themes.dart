import 'package:flutter/material.dart';
import 'package:flutter_cms/services/db/database_helper.dart';
import 'package:flutter_cms/widget/reusable_snackbar.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as developer;

class ChangeThemes {
  Future<void> showSaveThemesDialog(BuildContext context, String appbar,
      String drawer, String bottomNav) async {
    final TextEditingController themeNameController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Save Theme"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Enter a name for your theme:"),
              const SizedBox(height: 16),
              TextField(
                controller: themeNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Theme Name",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final themeName = themeNameController.text.trim();
                if (themeName.isEmpty) {
                  // Optionally show a warning if the theme name is empty
                  ReusableSnackbar.showErrorSnackbar(
                      context: context,
                      description: "Please enter a theme name");
                  return;
                }

                saveThemes(appbar, drawer, bottomNav, themeNameController.text,
                    context);
                Navigator.of(context).pop(); // Close the dialog after saving
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> saveThemes(String appBarColor, String drawerColor,
      String bottomNavColor, String themeTitle, BuildContext context) async {
    try {
      // Convert survey data to JSON string
      DateTime now = DateTime.now();
      String formattedDateTime = DateFormat('MM/dd/yyyy HH:mm:ss').format(now);

      // Save to SQLite
      developer.log(
          'data to be saved: $appBarColor, $drawerColor, $bottomNavColor, $themeTitle, $formattedDateTime');

      final int result = await DatabaseHelper().saveThemes(
          1,
          themeTitle,
          appBarColor,
          bottomNavColor,
          drawerColor,
          0,
          formattedDateTime,
          formattedDateTime);

      developer.log('Survey saved to SQLite with ID: $result');

      // Show success Snackbar
      if (context.mounted) {
        ReusableSnackbar.showSuccessSnackbar(
            context: context,
            description: "$themeTitle has been saved successfully");
      }
    } catch (e) {
      print('Error occurred: $e');
      if (context.mounted) {
        ReusableSnackbar.showErrorSnackbar(
            context: context, description: "Something went wrong: $e");
      }
    }
  }
}

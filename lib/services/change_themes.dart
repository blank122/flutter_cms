import 'package:flutter/material.dart';
import 'package:flutter_cms/screens/home.dart';
import 'package:flutter_cms/services/db/database_helper.dart';
import 'package:flutter_cms/widget/reusable_snackbar.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as developer;

import 'package:sizer/sizer.dart';

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

  Future<void> showConfirmationDialog(
      BuildContext context, int status, int themeID) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            status.toString() == '1' ? 'Deactivate Theme' : 'Activate Theme',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          content: Text(
            status.toString() == '1'
                ? 'Are you sure you want to deactivate this theme?'
                : 'Are you sure you want to activate this theme?',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: status.toString() == '1'
                    ? Colors.red
                    : Colors.blue, // Text color
                backgroundColor: status.toString() == '1'
                    ? Colors.grey[200]
                    : Colors.white, // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: status.toString() == '1'
                        ? Colors.red
                        : Colors.blue, // Border color
                    width: 1,
                  ), // Border
                ),
              ),
              onPressed: () {
                //function to activate the theme
                // onActivate();
                status == 1
                    ? deactivateStatusTheme(status, themeID, context)
                    : updateStatusTheme(status, themeID, context);

                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text(
                status.toString() == '1'
                    ? 'Deactivate Theme'
                    : 'Activate Theme',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: status.toString() == '1' ? Colors.red : Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

Future<void> updateStatusTheme(
    int status, int themeID, BuildContext context) async {
  try {
    // Convert survey data to JSON string
    DateTime now = DateTime.now();
    String updatedDate = DateFormat('MM/dd/yyyy HH:mm:ss').format(now);

    // Save to SQLite
    developer.log('data to be update saved: $themeID, $status, $updatedDate');

    final int result = await DatabaseHelper().useTheme(themeID, 1, updatedDate);

    developer.log('Survey saved to SQLite with ID: $result');

    // Show success Snackbar
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
      ReusableSnackbar.showSuccessSnackbar(
          context: context,
          description: "$themeID has been saved successfully");
    }
  } catch (e) {
    print('Error occurred: $e');
    if (context.mounted) {
      ReusableSnackbar.showErrorSnackbar(
          context: context, description: "Something went wrong: $e");
    }
  }
}

Future<void> deactivateStatusTheme(
    int status, int themeID, BuildContext context) async {
  try {
    // Convert survey data to JSON string
    DateTime now = DateTime.now();
    String updatedDate = DateFormat('MM/dd/yyyy HH:mm:ss').format(now);

    // Save to SQLite
    developer.log('data to be update saved: $themeID, $status, $updatedDate');

    final int result = await DatabaseHelper().useTheme(themeID, 0, updatedDate);

    developer.log('Survey saved to SQLite with ID: $result');

    // Show success Snackbar
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
      ReusableSnackbar.showSuccessSnackbar(
          context: context,
          description: "$themeID has been saved successfully");
    }
  } catch (e) {
    print('Error occurred: $e');
    if (context.mounted) {
      ReusableSnackbar.showErrorSnackbar(
          context: context, description: "Something went wrong: $e");
    }
  }
}

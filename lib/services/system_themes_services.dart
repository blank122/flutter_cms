import 'package:flutter/material.dart';
import 'package:flutter_cms/screens/home.dart';
import 'package:flutter_cms/services/db/database_helper.dart';
import 'package:flutter_cms/widget/reusable_snackbar.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as developer;

import 'package:sizer/sizer.dart';

class SystemThemesServices {
  Future<void> showSaveThemesDialog(
      BuildContext context, String systemName, String logoPath) async {
    final TextEditingController themeNameController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Save System theme"),
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

                saveSystemTheme(
                    themeNameController.text, systemName, logoPath, context);
                Navigator.of(context).pop(); // Close the dialog after saving
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> saveSystemTheme(String themTitle, String systemName,
      String logoPath, BuildContext context) async {
    try {
      // Convert survey data to JSON string
      DateTime now = DateTime.now();
      String formattedDateTime = DateFormat('MM/dd/yyyy HH:mm:ss').format(now);

      // Save to SQLite
      developer.log(
          'data to be saved: $themTitle, $systemName, $logoPath, $formattedDateTime, $formattedDateTime');

      final int result = await DatabaseHelper().saveSystemTheme(1, themTitle,
          systemName, logoPath, 1, formattedDateTime, formattedDateTime);

      developer.log('Survey saved to SQLite with ID: $result');

      // Show success Snackbar
      if (context.mounted) {
        ReusableSnackbar.showSuccessSnackbar(
            context: context,
            description: "$themTitle has been saved successfully");
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
          actions: [
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

    // Get the currently active theme
    List<Map<String, dynamic>> themes = await DatabaseHelper()
        .getSystemThemes(1); // Assuming `usr_id = 1` for simplicity.
    int? activeThemeID;

    // Check if there is already an active theme
    for (var theme in themes) {
      if (theme['status'] == 1) {
        activeThemeID = theme['id'];
        break;
      }
    }

    // If there is an active theme, deactivate it
    if (activeThemeID != null && activeThemeID != themeID) {
      await DatabaseHelper().useTheme(
          activeThemeID, 0, updatedDate); // Deactivate the previous theme
      developer.log('Deactivated previous theme: $activeThemeID');
    }

    // Save to SQLite
    developer.log('data to be update saved: $themeID, $status, $updatedDate');

    final int result =
        await DatabaseHelper().useSystemTheme(themeID, status, updatedDate);

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

    final int result =
        await DatabaseHelper().useSystemTheme(themeID, 0, updatedDate);

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

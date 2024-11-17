import 'package:flutter/material.dart';

class ThemeActionButton extends StatelessWidget {
  final int status;
  final int themeID;
  final Function(BuildContext, int, int) showConfirmationDialog;
  final String activeText;
  final String inactiveText;
  final Color activeColor;
  final Color inactiveColor;

  const ThemeActionButton({
    Key? key,
    required this.status,
    required this.themeID,
    required this.showConfirmationDialog,
    required this.activeText,
    required this.inactiveText,
    required this.activeColor,
    required this.inactiveColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor:
            status == 1 ? activeColor : inactiveColor, // Text color
        backgroundColor:
            status == 1 ? Colors.grey[200] : Colors.white, // Button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: status == 1 ? activeColor : inactiveColor, // Border color
            width: 1,
          ), // Border
        ),
      ),
      onPressed: () {
        showConfirmationDialog(context, status, themeID);
      },
      child: Text(
        status == 1 ? activeText : inactiveText,
        style: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

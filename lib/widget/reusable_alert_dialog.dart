import 'package:flutter/material.dart';

class ReusableAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final String primaryButtonText;
  final VoidCallback onPrimaryButtonPressed;
  final String secondaryButtonText;
  final VoidCallback? onSecondaryButtonPressed;

  const ReusableAlertDialog({
    super.key,
    required this.title,
    required this.description,
    required this.primaryButtonText,
    required this.onPrimaryButtonPressed,
    required this.secondaryButtonText,
    this.onSecondaryButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        TextButton(
          onPressed: () {
            if (onSecondaryButtonPressed != null) {
              onSecondaryButtonPressed!();
            } else {
              Navigator.of(context).pop(); // Default behavior
            }
          },
          child: Text(secondaryButtonText),
        ),
        ElevatedButton(
          onPressed: onPrimaryButtonPressed,
          child: Text(primaryButtonText),
        ),
      ],
    );
  }
}

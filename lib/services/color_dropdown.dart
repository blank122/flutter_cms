import 'package:flutter/material.dart';

class ColorDropdown extends StatefulWidget {
  final String selectedColor;
  final Function(String) onChanged;

  const ColorDropdown({
    super.key,
    required this.selectedColor,
    required this.onChanged,
  });

  @override
  ColorDropdownState createState() => ColorDropdownState();
}

class ColorDropdownState extends State<ColorDropdown> {
  @override
  Widget build(BuildContext context) {
    const Map<String, Color> bootstrapColors = {
      'Blue': Color(0xFF007BFF),
      'Gray': Color(0xFF6C757D),
      'Green': Color(0xFF28A745),
      'Cyan': Color(0xFF17A2B8),
      'Red': Color(0xFFDC3545),
      'Black': Color(0xFF343A40),
      'White': Color(0xFFFFFFFF),
      'Yellow': Color(0xFFFFC107),
    };

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        value: widget.selectedColor, // Use the color passed from the parent
        items: bootstrapColors.entries.map((entry) {
          return DropdownMenuItem<String>(
            value: entry.key,
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  color: entry.value,
                ),
                const SizedBox(width: 8),
                Text(entry.key),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            widget
                .onChanged(value); // Pass the selected color back to the parent
          }
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }
}

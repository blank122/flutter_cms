import 'package:flutter/material.dart';
import 'package:flutter_cms/widget/custom_app_bar.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class CreateThemesView extends StatefulWidget {
  const CreateThemesView({super.key});

  @override
  State<CreateThemesView> createState() => _CreateThemesViewState();
}

class _CreateThemesViewState extends State<CreateThemesView> {
  @override
  Widget build(BuildContext context) {
    String appBarColor = '0xFFFFFFFF'; // Default color for AppBar
    String drawerColor = '0xFFFFFFFF'; // Default color for Drawer
    String bottomNavColor =
        '0xFFFFFFFF'; // Default color for Bottom Navigation Bar
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
                appBarColor = color;
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
                appBarColor = color;
              });
            },
          ),
          Gap(1.h),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Save Theme Settings"),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorDropdown extends StatefulWidget {
  final String selectedColor;
  final Function(String) onChanged;
  const ColorDropdown(
      {super.key, required this.selectedColor, required this.onChanged});

  @override
  ColorDropdownState createState() => ColorDropdownState();
}

class ColorDropdownState extends State<ColorDropdown> {
  String selectedColor = 'Blue'; // Default selection

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
        value: selectedColor,
        items: bootstrapColors.entries.map((entry) {
          return DropdownMenuItem<String>(
            value: entry.key,
            child: Row(
              children: [
                // Color indicator
                Container(
                  width: 24,
                  height: 24,
                  color: entry.value,
                ),
                const SizedBox(width: 8),
                // Color name
                Text(entry.key),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedColor = value!;
          });
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }
}

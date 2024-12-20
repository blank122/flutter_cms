import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cms/services/system_themes_services.dart';
import 'package:flutter_cms/widget/custom_app_bar.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class CreateSystemThemeView extends StatefulWidget {
  //get the appbar color
  final Color appbarColor;
  const CreateSystemThemeView({super.key, required this.appbarColor});

  @override
  State<CreateSystemThemeView> createState() => _CreateSystemThemeViewState();
}

class _CreateSystemThemeViewState extends State<CreateSystemThemeView> {
  final SystemThemesServices systemServices = SystemThemesServices();
  final TextEditingController systemName = TextEditingController();
  File? _pickedImage; // Variable to store the selected image file
  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;
  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    try {
      // Show the image picker dialog
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _pickedImage = File(pickedFile.path); // Save the selected image
        });
      } else {
        // Handle case when no image is selected
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Default color for Bottom Navigation Bar
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create System Theme',
        backgroundColor: widget.appbarColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Customize System Theme",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            Gap(3.h),
            // AppBar Color Dropdown
            Text(
              "App Logo",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            GestureDetector(
              onTap: _pickImage, // Trigger the image picker on tap
              child: _pickedImage == null
                  ? Container(
                      width: 100.w,
                      height: 20.h,
                      color: Colors.grey[200],
                      child: Center(
                        child: Icon(Icons.add_a_photo,
                            size: 30.sp, color: Colors.grey),
                      ),
                    )
                  : Image.file(
                      _pickedImage!,
                      width: 100.w,
                      height: 20.h,
                      fit: BoxFit.cover,
                    ),
            ),
            Gap(2.h),

            Text(
              "App Title",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            Gap(1.h),

            TextFormField(
              controller: systemName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'App title is required';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter a title for the app',
                prefixIcon: Icon(Icons.lock_outline_rounded),
                border: OutlineInputBorder(),
              ),
            ),

            Gap(1.h),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  systemServices.showSaveThemesDialog(
                      context, systemName.text, _pickedImage!.path);
                },
                child: const Text("Save Theme Settings"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

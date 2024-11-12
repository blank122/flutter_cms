import 'package:flutter/material.dart';
import 'package:flutter_cms/widget/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

class CreateThemesView extends StatelessWidget {
  const CreateThemesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Create Themes',
      ),
      body: Column(
        children: [
          Text(
            'SHOSHSOHSH',
            style: TextStyle(fontSize: 16.sp),
          )
        ],
      ),
    );
  }
}

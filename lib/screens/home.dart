import 'package:flutter/material.dart';
import 'package:flutter_cms/widget/custom_app_bar.dart';
import 'package:flutter_cms/widget/custom_bottom_nav.dart';
import 'package:flutter_cms/widget/custom_drawer.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //call the database values
  //create a function to load all the themes
  //then pass all the value to each widgets that need its value
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Home"),
      drawer:
          const CustomDrawer(), //pass the value of the drawer color, image, system title
      body: Column(
        children: [
          Text(
            'Home Screen',
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(), //pass the color
    );
  }
}

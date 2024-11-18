import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cms/global/get_text_color.dart';
import 'package:flutter_cms/screens/utility_screen/utility_screen.dart';
import 'package:flutter_cms/widget/location.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class CustomDrawer extends StatelessWidget {
  //pass the drawer color
  //pass appbar color
  final Color appbarColor;
  final Color backgroundColor;
  final String systemName;
  final String systemLogo;

  const CustomDrawer({
    super.key,
    required this.appbarColor,
    required this.backgroundColor,
    required this.systemName,
    required this.systemLogo,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = getTextColor(backgroundColor);

    return Drawer(
      backgroundColor: backgroundColor,
      child: ListView(
        padding: EdgeInsets.all(16.sp),
        children: [
          //add a condition statement here
          DrawerHeader(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
              child: Image.file(
                File(systemLogo),
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/logo.png');
                },
              ), //same here
            ),
          ),
          Gap(1.5.h),
          Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Text(
              systemName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: textColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "User",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Location",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: textColor),
                        ),
                        trailing: Icon(Icons.map, color: textColor),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Location(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "More actions",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Utility",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: textColor),
                        ),
                        trailing: Icon(Icons.settings, color: textColor),
                        onTap: () {
                          Navigator.pop(context);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UtilityScreen(appBarTheme: appbarColor),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

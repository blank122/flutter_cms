import 'package:flutter/material.dart';
import 'package:flutter_cms/screens/utility_screen/system_themes/system_view.dart';
import 'package:flutter_cms/screens/utility_screen/themes/themes_view.dart';
import 'package:flutter_cms/widget/custom_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class UtilityScreen extends StatelessWidget {
  final Color appBarTheme;
  const UtilityScreen({
    super.key,
    required this.appBarTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            CustomAppBar(title: "Utility Screen", backgroundColor: appBarTheme),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: ListTile(
                    leading: const FaIcon(
                      FontAwesomeIcons.gears,
                      color: Colors.green,
                      size: 40,
                    ),
                    title: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Text(
                        'Theme',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ThemesView(appBarColor: appBarTheme),
                            ),
                          );
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.arrowRight,
                          size: 20,
                        )),
                  ),
                ),
              ),
            ),
            Gap(1.5.h),
            Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: ListTile(
                    leading: const FaIcon(
                      FontAwesomeIcons.code,
                      color: Colors.green,
                      size: 40,
                    ),
                    title: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Text(
                        'System Theme',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SystemView(appBarColor: appBarTheme),
                            ),
                          );
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.arrowRight,
                          size: 20,
                        )),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

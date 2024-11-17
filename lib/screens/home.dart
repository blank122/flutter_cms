import 'package:flutter/material.dart';
import 'package:flutter_cms/services/db/database_helper.dart';
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
  Map<String, dynamic>? activeTheme;
  Color? appBarColor;
  Color? drawerColor;
  Color? bottomNavColor;

  Map<String, Color> bootstrapColors = {
    'Blue': const Color(0xFF007BFF),
    'Gray': const Color(0xFF6C757D),
    'Green': const Color(0xFF28A745),
    'Cyan': const Color(0xFF17A2B8),
    'Red': const Color(0xFFDC3545),
    'Black': const Color(0xFF343A40),
    'White': const Color(0xFFFFFFFF),
    'Yellow': const Color(0xFFFFC107),
  };
  @override
  void initState() {
    super.initState();
    _loadActiveTheme();
  }

  // Function to load the active theme from the database
  Future<void> _loadActiveTheme() async {
    try {
      // Fetch the active theme for the user
      Map<String, dynamic>? theme = await DatabaseHelper().getActivatedTheme(1);

      setState(() {
        activeTheme = theme;

        String appbarTheme =
            theme!['app_bar_color']; // Assuming 'name' holds the theme name
        String drawerTheme =
            theme['drawer_color']; // Assuming 'name' holds the theme name
        String bottomNavTheme = theme[
            'bottom_nav_bar_color']; // Assuming 'name' holds the theme name

        appBarColor = bootstrapColors[
            appbarTheme]; // Get the color based on the theme name
        drawerColor = bootstrapColors[
            drawerTheme]; // Get the color based on the theme name
        bottomNavColor = bootstrapColors[bottomNavTheme];
      });
    } catch (e) {
      // Handle any errors here, maybe show a Snackbar or a message
      print('Error fetching active theme: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Home",
        backgroundColor: appBarColor,
      ),
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

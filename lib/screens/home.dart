import 'package:flutter/material.dart';
import 'package:flutter_cms/widget/custom_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const CustomDrawer(),
      body: const Column(
        children: [
          Text('Home Screen'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: themeService.bottomNavBarColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

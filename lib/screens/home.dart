import 'package:flutter/material.dart';
import 'package:flutter_cms/widget/custom_bottom_nav.dart';
import 'package:flutter_cms/widget/custom_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //call the database values

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        // backgroundColor: ,
      ), //appbar title(page title), color
      drawer:
          const CustomDrawer(), //pass the value of the drawer color, image, system title
      body: const Column(
        children: [
          Text('Home Screen'),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(), //pass the color
    );
  }
}

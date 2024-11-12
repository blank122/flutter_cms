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
      appBar: AppBar(),
      drawer: const CustomDrawer(), //pass the value of the drawer color
      body: const Column(
        children: [
          Text('Home Screen'),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(), //pass the color
    );
  }
}

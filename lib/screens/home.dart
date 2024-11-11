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
      body: const Column(
        children: [
          Text('Home Screen'),
        ],
      ),
      drawer: const CustomDrawer(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:internship_socialmedia/widget/bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomNavigationBarCustom(
          currentIndex: 0,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Text("home"),
        ),
      ),
    );
  }
}

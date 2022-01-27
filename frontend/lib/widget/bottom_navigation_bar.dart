import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:internship_socialmedia/constants/constants.dart';
import 'package:internship_socialmedia/screens/addPost/add_post_page.dart';
import 'package:internship_socialmedia/screens/home/home.dart';
import 'package:internship_socialmedia/screens/profile/profile_page.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({Key? key, required this.currentIndex})
      : super(key: key);
  final int currentIndex;

  @override
  State<BottomNavigationBarCustom> createState() =>
      _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  @override
  Widget build(BuildContext context) {
    List pages = [const HomePage(), const AddPostPage(), const ProfilePage()];
    return BottomNavigationBar(
      backgroundColor: white,
      currentIndex: widget.currentIndex,
      onTap: (newIndex) {
        setState(() {
          if (newIndex != widget.currentIndex) {
            Get.to(pages[newIndex]);
          }
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/svg/home.svg",
            height: 28,
            color: widget.currentIndex == 0 ? primaryBlue : textColor1,
          ),
          label: "home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_rounded,
            size: 30,
            color: widget.currentIndex == 1 ? primaryBlue : textColor1,
          ),
          label: "add post",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/svg/user.svg",
            height: 30,
            color: widget.currentIndex == 1 ? primaryBlue : textColor1,
          ),
          label: "account",
        ),
      ],
    );
  }
}

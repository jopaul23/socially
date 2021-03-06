import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_socialmedia/constants/constants.dart';
import 'package:internship_socialmedia/controller/posts_controller.dart';
import 'package:internship_socialmedia/controller/user_controller.dart';
import 'package:internship_socialmedia/models/post_model.dart';
import 'package:internship_socialmedia/models/user_model.dart';
import 'package:internship_socialmedia/screens/home/post_container.dart';
import 'package:internship_socialmedia/widget/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostController postController = Get.put(PostController());
  UserContrller userController = Get.put(UserContrller());
  String? userId;
  UserModel? user;

  setValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("user_id");
    UserModel user = await userController.getUserDetails(id: userId!);
  }

  @override
  Widget build(BuildContext context) {
    setValues();
    postController.getAllPosts();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const BottomNavigationBarCustom(
          currentIndex: 0,
        ),
        body: SingleChildScrollView(
          child: GetBuilder<PostController>(builder: (context) {
            return Column(children: [
              for (PostModel post in postController.postsList)
                PostContainer(post: post),
            ]);
          }),
        ),
      ),
    );
  }
}

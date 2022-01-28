import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:internship_socialmedia/constants/constants.dart';
import 'package:internship_socialmedia/controller/user_controller.dart';
import 'package:internship_socialmedia/models/post_model.dart';
import 'package:internship_socialmedia/models/user_model.dart';
import 'package:internship_socialmedia/screens/profile/head_container.dart';
import 'package:internship_socialmedia/screens/profile/post_view_container.dart';
import 'package:internship_socialmedia/widget/bottom_navigation_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, this.user}) : super(key: key);
  final UserModel? user;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserContrller userContrller = Get.find<UserContrller>();

  @override
  Widget build(BuildContext context) {
    bool isNavigation = false;
    bool isOwner = false;
    late UserModel user;
    if (widget.user == null) {
      setState(() {
        isOwner = true;
        isNavigation = true;
      });
      user = userContrller.owner!;
    } else {
      user = widget.user!;
    }
    List<PostModel> postList;
    userContrller.getPosts(user.id);

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: isNavigation
            ? const BottomNavigationBarCustom(
                currentIndex: 2,
              )
            : const SizedBox(),
        backgroundColor: bgColor,
        body: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              HeadContainer(
                  isOwner: isOwner, userContrller: userContrller, user: user),
              const SizedBox(
                height: 10,
              ),
              Text(
                user.posts.isEmpty ? "you have no posts" : "posts",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: textColor1,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              user.posts.isEmpty
                  ? Column(children: [
                      const SizedBox(
                        height: 70,
                      ),
                      SvgPicture.asset(
                        "assets/svg/no_post.svg",
                        width: size.width * 2 / 3,
                      ),
                    ])
                  : GetBuilder<UserContrller>(builder: (context) {
                      postList = userContrller.profilePosts;
                      return Expanded(
                          child: GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: defaultPadding,
                        mainAxisSpacing: defaultPadding,
                        children: [
                          for (PostModel post in postList)
                            GestureDetector(
                              onTap: () {
                                Get.to(PostViewPage(post: post));
                              },
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(defaultPadding),
                                child: Image.network(
                                  "http://159.89.161.168:4050/api/posts/" +
                                      post.url,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                        ],
                      ));
                    })
            ],
          ),
        ),
      ),
    );
  }
}

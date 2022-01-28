import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internship_socialmedia/constants/constants.dart';
import 'package:internship_socialmedia/controller/user_controller.dart';
import 'package:internship_socialmedia/models/post_model.dart';
import 'package:internship_socialmedia/models/user_model.dart';
import 'package:internship_socialmedia/screens/profile/profile_page.dart';

class PostContainer extends StatefulWidget {
  const PostContainer({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel post;

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(defaultPadding),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(color: primaryBlue.withOpacity(.1), blurRadius: 30)
          ],
          borderRadius: BorderRadius.circular(defaultPadding)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  UserContrller userContrller = Get.find<UserContrller>();
                  UserModel user = await userContrller.getUserDetails(
                      id: widget.post.userId);
                  Get.to(() => ProfilePage(
                        user: user,
                      ));
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.post.profile,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.post.userName,
                style: TextStyle(
                    color: primaryBlue,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            " " + widget.post.caption,
            style: TextStyle(color: textColor1, fontSize: 14.sp),
          ),
          const SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(defaultPadding),
            child: Image.network(
              "http://159.89.161.168:4050/api/posts/" + widget.post.url,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

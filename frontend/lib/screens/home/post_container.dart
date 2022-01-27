import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_socialmedia/constants/constants.dart';
import 'package:internship_socialmedia/models/post_model.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({
    Key? key,
    required this.post,
  }) : super(key: key);

  final PostModel post;

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
              const CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://m.media-amazon.com/images/I/41jLBhDISxL._SY355_.jpg",
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                post.userName,
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
            " " + post.caption,
            style: TextStyle(color: textColor1, fontSize: 14.sp),
          ),
          const SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(defaultPadding),
            child: Image.network(
              "http://159.89.161.168:4050/api/posts/" + post.url,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

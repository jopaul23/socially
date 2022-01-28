import 'package:flutter/material.dart';
import 'package:internship_socialmedia/constants/constants.dart';
import 'package:internship_socialmedia/models/post_model.dart';
import 'package:internship_socialmedia/screens/home/post_container.dart';

class PostViewPage extends StatelessWidget {
  const PostViewPage({Key? key, required this.post}) : super(key: key);
  final PostModel post;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(
              vertical: defaultPadding, horizontal: defaultPadding),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: PostContainer(
              post: post,
            ),
          ),
        ),
      ),
    );
  }
}

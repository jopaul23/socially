import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internship_socialmedia/constants/constants.dart';
import 'package:internship_socialmedia/models/post_model.dart';
import 'package:internship_socialmedia/screens/home/post_container.dart';
import 'package:internship_socialmedia/widget/toast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PostViewPage extends StatelessWidget {
  const PostViewPage({Key? key, required this.post}) : super(key: key);
  final PostModel post;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: InkWell(
          onTap: () async {
            Map<Permission, PermissionStatus> statuses = await [
              Permission.storage,
              //add more permission to request here.
            ].request();

            if (statuses[Permission.storage]!.isGranted) {
              String dir = (await getExternalStorageDirectories(
                      type: StorageDirectory.downloads))!
                  .first
                  .path; // 1
              // String path = dir.path; // 2
              if (dir != null) {
                String savePath = "$dir/${post.url}";
                print("-------------path-------------");
                print(savePath);
                print("-------------path-------------");

                //output:  /storage/emulated/0/Download/banner.png

                try {
                  await Dio().download(
                      "http://159.89.161.168:4050/api/posts/" + post.url,
                      savePath, onReceiveProgress: (received, total) {
                    if (total != -1) {
                      print((received / total * 100).toStringAsFixed(0) + "%");
                      //you can build progressbar feature too
                    }
                  });
                  showToast(
                      context: context,
                      title: "Image is saved to application directory",
                      description: "",
                      icon: "assets/svg/tick.svg",
                      color: primaryBlue);
                } on DioError catch (e) {
                  print(e.message);
                }
              }
            } else {
              showToast(
                  context: context,
                  title: "no permission given",
                  description: "",
                  icon: "assets/svg/warning.svg",
                  color: toastYellow);
            }
          },
          child: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: primaryBlue),
            child: Icon(
              Icons.download_rounded,
              color: white,
              size: 35,
            ),
          ),
        ),
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

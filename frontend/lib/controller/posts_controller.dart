import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internship_socialmedia/constants/constants.dart';
import 'package:internship_socialmedia/widget/toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:internship_socialmedia/api/post_api.dart';
import 'package:internship_socialmedia/models/post_model.dart';

class PostController extends GetxController {
  List<PostModel> postsList = [];
  bool posting = false;

  addPost(XFile? image, String caption, BuildContext context) async {
    final Directory applicationDirectory =
        await getApplicationDocumentsDirectory();
    String applicationPath = applicationDirectory.path;
    posting = true;
    File compresseedImage = await testCompressAndGetFile(
        File(image!.path), '$applicationPath/${image.name}');
    Map<String, dynamic> map = await PostApi.uploadImage(
        XFile('$applicationPath/${image.name}'), caption);
    if (map["status"] == 200) {
      showToast(
          context: context,
          title: "successfully posted",
          description: "",
          color: primaryBlue,
          icon: "assets/svg/tick.svg");
    } else {
      showToast(
          context: context,
          title: map["message"],
          description: "",
          color: toastYellow,
          icon: "assets/svg/warning.svg");
    }
    posting = false;
    getAllPosts();
    update();
  }

  getAllPosts() async {
    List<Map<String, dynamic>> mapList = [];
    List<PostModel> list = await PostApi.getPosts({});
    postsList = list;
    print("lenght of post list ${postsList.length}");
    update();
  }

  //compresion
  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      minWidth: 720,
      minHeight: 480,
      quality: 50,
    );

    print(file.lengthSync());
    print(result!.lengthSync());

    return result;
  }
}

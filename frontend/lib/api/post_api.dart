import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostApi {
  static uploadImage(XFile image, String caption) async {
    final String mainUrl = "http://159.89.161.168:4050";

    String filePath = image.path;
    String fileName = image.name;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email").toString();
    String owner_name = prefs.getString("user_name").toString();
    String owner_id = prefs.getString("user_id").toString();
    String token = prefs.getString("auth-token").toString();

    try {
      FormData formData = FormData.fromMap({
        "caption": caption,
        "owner_name": owner_name,
        "owner_id": owner_id,
        "image": await MultipartFile.fromFile(filePath, filename: fileName),
      });
      Response response = await Dio().post(mainUrl + '/api/posts/upload-img',
          data: formData, options: Options(headers: {"auth-token": token}));
      print("file upload response $response");
      print(response.statusCode);
    } catch (error) {
      print("error");
    }
  }
}

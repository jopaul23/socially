import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internship_socialmedia/controller/user_controller.dart';
import 'package:internship_socialmedia/models/post_model.dart';
import 'package:internship_socialmedia/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostApi {
  static Future<Map<String, dynamic>> uploadImage(
      XFile image, String caption) async {
    const String mainUrl = "http://159.89.161.168:4050";

    String filePath = image.path;
    String fileName = image.name;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("auth-token").toString();
    String userId = prefs.getString("user_id").toString();

    UserModel user = await UserContrller.getUserDetailsWithoutPosts(id: userId);

    Map<String, dynamic> map = {"status": 500, "message": "failed to post"};
    try {
      FormData formData = FormData.fromMap({
        "caption": caption,
        "owner_name": user.name,
        "owner_id": user.id,
        "owner_profile": user.profile,
        "image": await MultipartFile.fromFile(filePath, filename: fileName),
      });
      Response response = await Dio().post(mainUrl + '/api/posts/upload-img',
          data: formData, options: Options(headers: {"auth-token": token}));
      print("file upload response $response");
      print(response.statusCode);
      map = {
        "status": response.statusCode,
        "message": response.data["message"]
      };
    } catch (error) {
      print("error");
    }
    return map;
  }

  static Future<List<PostModel>> getPosts(Map<String, String> filter) async {
    print("------------------------filter-------------");
    print(filter);
    print(json.encode(filter));
    print("------------------------filter-------------");

    const String url = "http://159.89.161.168:4050/api/posts/get";
    List<PostModel> postList = [];
    final response = await Dio().post(url, data: filter);
    if (response.statusCode == 200) {
      print("Successfull");
      // final List datas = jsonDecode(response.data);
      print("decoded successfuly");
      response.data.forEach((element) {
        print(element);
        postList.add(PostModel.fromMap(map: element));
      });
      print("list appended sucessfully");
      return postList;
    } else if (response.statusCode == 500) {
      print("couldnt fetch quote");
    }
    return postList;
  }
}

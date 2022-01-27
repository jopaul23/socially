import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:internship_socialmedia/models/user_model.dart';

class UserApi {
  static Future<UserModel> getUserDetails(String userId) async {
    const String url = "http://159.89.161.168:4050/api/users/get";
    print("id is ------------$userId");
    Map<String, String> body = {"_id": userId};
    final response = await Dio().post(
      url,
      data: body,
    );
    if (response.statusCode == 200) {
      print(response.data);
      List<String> postList = [];
      for (var post in response.data["posts"]) {
        postList.add(post.toString());
      }
      print("Successfull");
      Map<String, dynamic> data = {
        "_id": response.data["_id"],
        "name": response.data["name"],
        "email": response.data["email"],
        "posts": postList
      };
      print("decoded useer successfuly ");
      UserModel user = UserModel.fromMap(map: data);
      return user;
    } else if (response.statusCode == 500) {
      print("couldnt fetch quote");
    }
    return UserModel(email: "", name: "", posts: [], id: "");
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internship_socialmedia/api/post_api.dart';
import 'package:internship_socialmedia/api/user_api.dart';
import 'package:internship_socialmedia/constants/constants.dart';
import 'package:internship_socialmedia/models/post_model.dart';
import 'package:internship_socialmedia/models/user_model.dart';
import 'package:internship_socialmedia/widget/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserContrller extends GetxController {
  List<PostModel> profilePosts = [];

  UserModel? owner;

  setOwner() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ownerId = prefs.getString("user_id");
    owner = await getUserDetails(id: ownerId!);
    update();
  }

  Future<UserModel> getUserDetails({required String id}) async {
    UserModel user = await UserApi.getUserDetails(id);
    print("----------------email----------");
    print(user.email);
    owner = user;
    return user;
  }

  static Future<UserModel> getUserDetailsWithoutPosts(
      {required String id}) async {
    UserModel user = await UserApi.getUserDetails(id);
    return user;
  }

  getPosts(String userId) async {
    Map<String, String> filter = {"owner_id": userId};
    List<PostModel> list = await PostApi.getPosts(filter);
    profilePosts = list;
    update();
  }

  updateProfile(
      {required String id,
      required String profile_url,
      required BuildContext context}) async {
    Map<String, String> map = {"id": id, "profile_url": profile_url};

    await UserApi.updateProfile(map);

    getUserDetails(id: id);
    update();
  }
}

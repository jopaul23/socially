import 'package:get/get.dart';
import 'package:internship_socialmedia/api/post_api.dart';
import 'package:internship_socialmedia/api/user_api.dart';
import 'package:internship_socialmedia/models/post_model.dart';
import 'package:internship_socialmedia/models/user_model.dart';

class UserContrller extends GetxController {
  List<PostModel> profilePosts = [];

  UserModel? owner;
  Future<UserModel> getUserDetails({required String id}) async {
    UserModel user = await UserApi.getUserDetails(id);
    print("----------------email----------");
    print(user.email);
    owner = user;
    return user;
  }

  getPosts(String userId) async {
    Map<String, String> filter = {"owner_id": userId};
    List<PostModel> list = await PostApi.getPosts(filter);
    profilePosts = list;
    update();
  }
}

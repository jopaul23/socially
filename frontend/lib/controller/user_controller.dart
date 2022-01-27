import 'dart:convert';

import 'package:get/get.dart';
import 'package:internship_socialmedia/api/user_api.dart';
import 'package:internship_socialmedia/models/user_model.dart';

class UserContrller extends GetxController {
  UserModel? owner;
  Future<UserModel> getUserDetails({required String id}) async {
    UserModel user = await UserApi.getUserDetails(id);
    print("----------------email----------");
    print(user.email);
    owner = user;
    return user;
  }
}

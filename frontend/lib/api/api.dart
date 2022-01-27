import 'dart:convert';

import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
import 'package:internship_socialmedia/api/error_handling.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static const url = "http://159.89.161.168:4050";

  static Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    Map req = {
      "email": email,
      "password": password,
    };
    Map<String, dynamic> map = {
      "status": 500,
      "message": "unexpected error occured"
    };
    try {
      // final urLink = Uri.parse(url + "/api/users/login");
      final response = await Dio()
          .post(url + "/api/users/login", data: jsonEncode(req))
          .catchError((error) {
        print(error.response!.statusCode);
        print(error.response!.data);
        map = {
          "status": error.response!.statusCode,
          "message": error.response!.data["message"] ?? "unexpected error"
        };
      });
      print("status is ${response.statusCode}");

      // Map responseMap = jsonDecode(response.data);
      if (response.statusCode == 200) {
        map = {"status": 200, "message": "login successfull"};
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('auth-token', response.data["token"]);
        prefs.setString('email', response.data["email"]);
        prefs.setString('user_id', response.data["id"]);
      }
    } catch (error) {
      print(error);
    }
    print(map);
    return map;
  }

  static Future<Map<String, dynamic>> register(
      {required String email,
      required String password,
      required String name}) async {
    Map req = {"email": email, "password": password, "name": name};
    Map<String, dynamic> map = {
      "status": 500,
      "message": "unexpected error occured"
    };
    try {
      // final urLink = Uri.parse(url + "/api/users/login");
      final response = await Dio()
          .post(url + "/api/users/register", data: jsonEncode(req))
          .catchError((error) {
        print(error.response!.statusCode);
        print(error.response!.data);
        map = {
          "status": error.response!.statusCode,
          "message": error.response!.data["message"] ?? "unexpected error"
        };
      });
      print("status is ${response.statusCode}");

      // Map responseMap = jsonDecode(response.data);
      if (response.statusCode == 200) {
        map = {"status": 200, "message": "account created successfully"};
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('auth-token', response.data["token"]);
        prefs.setString('email', response.data["email"]);
        prefs.setString('user_id', response.data["id"]);
      }
    } catch (error) {
      print(error);
    }
    print(map);
    return map;
  }
}

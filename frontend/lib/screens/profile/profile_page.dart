import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_socialmedia/constants/constants.dart';
import 'package:internship_socialmedia/controller/user_controller.dart';
import 'package:internship_socialmedia/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, this.user}) : super(key: key);
  final UserModel? user;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserContrller userContrller = Get.find<UserContrller>();
  @override
  Widget build(BuildContext context) {
    late UserModel ownerUser;
    if (widget.user == null) {
      ownerUser = userContrller.owner!;
    }
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xffF6F6F6),
                    borderRadius: BorderRadius.circular(defaultPadding)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.user == null
                        ? Text(ownerUser.email)
                        : Text(widget.user!.email),
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://m.media-amazon.com/images/I/41jLBhDISxL._SY355_.jpg",
                      ),
                      radius: 60,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internship_socialmedia/constants/constants.dart';
import 'package:internship_socialmedia/controller/user_controller.dart';
import 'package:internship_socialmedia/models/user_model.dart';
import 'package:internship_socialmedia/screens/profile/profile_pictures.dart';
import 'package:internship_socialmedia/screens/regitration/login/signin_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeadContainer extends StatelessWidget {
  const HeadContainer({
    Key? key,
    required this.isOwner,
    required this.userContrller,
    required this.user,
  }) : super(key: key);

  final bool isOwner;
  final UserContrller userContrller;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color(0xffF6F6F6),
              borderRadius: BorderRadius.circular(defaultPadding)),
          child: Row(
            children: [
              const SizedBox(
                width: defaultPadding,
              ),
              isOwner
                  ? GestureDetector(
                      onTap: () {
                        late OverlayEntry profileOverLay;
                        profileOverLay = OverlayEntry(
                            builder: (context) => ProfileSelection(
                                  userContrller: userContrller,
                                  overlayEntry: profileOverLay,
                                  user: user,
                                ));
                        Overlay.of(context)?.insert(profileOverLay);
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(user.profile),
                            radius: 35,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: primaryBlue,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Icon(
                              Icons.add_a_photo_rounded,
                              size: 20,
                              color: white,
                            ),
                          )
                        ],
                      ),
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(user.profile),
                      radius: 35,
                    ),
              const SizedBox(
                width: defaultPadding,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: primaryBlue,
                    ),
                  ),
                  Text(user.email)
                ],
              ),
            ],
          ),
        ),
        isOwner
            ? Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove("auth-token");
                    prefs.remove("user_name");
                    prefs.remove("email");

                    prefs.remove("user_id");
                    Get.off(() => SigninPage());
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: primaryBlue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "logout",
                      style: TextStyle(color: white, fontSize: 12.sp),
                    ),
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}

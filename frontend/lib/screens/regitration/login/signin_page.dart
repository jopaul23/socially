import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_socialmedia/constants/constants.dart';
import 'package:internship_socialmedia/screens/regitration/login/login_form.dart';
import 'package:internship_socialmedia/screens/regitration/signup/signup_page.dart';
import 'package:internship_socialmedia/widget/buttons/primary_btn.dart';
import 'package:internship_socialmedia/widget/buttons/secondary_btn.dart';
import 'package:internship_socialmedia/widget/textfield_custom.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  bool isLoading = false;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            height: size.height - defaultPadding * 2,
            width: size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    "assets/svg/login.svg",
                    height: size.height * 2 / 10,
                  ),
                  SizedBox(
                    child: Column(
                      children: const [
                        Text(
                          "login",
                          style: TextStyle(
                            fontSize: 19,
                            color: textColor1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Enter your email to continue",
                          style: TextStyle(
                            fontSize: 10,
                            color: textColor1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  LoginForm(size: size),
                  const SizedBox(
                    height: 10,
                  ),
                  isLoading
                      ? Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width -
                              4 * defaultPadding,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const SpinKitFadingCircle(
                            color: white,
                            size: 30,
                          ))
                      : PrimaryButton(
                          onpressed: () {
                            print("pressed");
                          },
                          text: "continue"),
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          "already have an account?",
                          style: TextStyle(fontSize: 10.sp),
                        ),
                        SecondaryBtn(
                            onpressed: () => Get.to(() => const SignupPage()),
                            text: "sign up"),
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}

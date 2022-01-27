import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:internship_socialmedia/constants/constants.dart';
import 'package:internship_socialmedia/screens/regitration/login/signin_page.dart';
import 'package:internship_socialmedia/screens/regitration/signup/signup_form.dart';
import 'package:internship_socialmedia/widget/buttons/primary_btn.dart';
import 'package:internship_socialmedia/widget/buttons/secondary_btn.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  bool isLoading = false;
  final formKey = GlobalKey<SignupFormState>();

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
                    "assets/svg/signup.svg",
                    height: size.height * 2 / 10,
                  ),
                  SizedBox(
                    child: Column(
                      children: const [
                        Text(
                          "signup",
                          style: TextStyle(
                            fontSize: 19,
                            color: textColor1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Enter your email and password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: textColor1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SignupForm(
                    size: size,
                    key: formKey,
                  ),
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
                          text: "Signup"),
                  SizedBox(
                    child: Column(
                      children: [
                        Text(
                          "dont have an account?",
                          style: TextStyle(fontSize: 10.sp),
                        ),
                        SecondaryBtn(
                            onpressed: () => Get.off(() => const SigninPage()),
                            text: "login"),
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

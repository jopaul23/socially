import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_socialmedia/constants/constants.dart';
import 'package:internship_socialmedia/widget/textfield_custom.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final emailKey = GlobalKey<TextFieldCustomState>();
  final passwordKey = GlobalKey<TextFieldCustomState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: widget.size.width - defaultPadding * 2,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(defaultPadding),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ]),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              height: 60,
              width: widget.size.width - defaultPadding * 2,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(defaultPadding),
                    topRight: Radius.circular(defaultPadding)),
              ),
              child: TextFieldCustom(
                key: emailKey,
                underline: false,
                isPass: false,
                prefixSvg: "assets/svg/email.svg",
                padding: defaultPadding,
                hintText: "email",
                width: widget.size.width - defaultPadding * 2,
              )),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              height: 60,
              width: widget.size.width - defaultPadding * 2,
              decoration: const BoxDecoration(
                color: Color(0xffF6F6F6),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(defaultPadding),
                    bottomRight: Radius.circular(defaultPadding)),
              ),
              child: TextFieldCustom(
                isPass: true,
                key: passwordKey,
                underline: false,
                prefixSvg: "assets/svg/lock.svg",
                padding: defaultPadding,
                hintText: "password",
                width: widget.size.width - defaultPadding * 2,
              )),
        ],
      ),
    );
  }
}

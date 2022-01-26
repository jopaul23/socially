import 'package:flutter/material.dart';
import 'package:internship_socialmedia/constants/constants.dart';

class SecondaryBtn extends StatelessWidget {
  const SecondaryBtn({Key? key, required this.onpressed, required this.text})
      : super(key: key);
  final String text;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 4 * defaultPadding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              width: 1.5,
              color: primaryBlue,
            )),
        child: Text(
          text,
          style: const TextStyle(
            color: primaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

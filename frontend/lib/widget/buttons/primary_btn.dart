import 'package:flutter/material.dart';
import 'package:internship_socialmedia/constants/constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({Key? key, required this.onpressed, required this.text})
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
          color: primaryBlue,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

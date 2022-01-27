import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_socialmedia/constants/constants.dart';
import 'package:internship_socialmedia/widget/textfield_custom.dart';

class CaptionContainer extends StatefulWidget {
  const CaptionContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<CaptionContainer> createState() => CaptionContainerState();
}

class CaptionContainerState extends State<CaptionContainer> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(defaultPadding),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.02),
            )
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      width: MediaQuery.of(context).size.width - defaultPadding * 2,
      child: TextFormField(
        maxLength: 200,
        maxLines: 3,
        controller: textEditingController,
        validator: (value) {
          if (value!.isEmpty) {
            print("empty");
            return 'Error Message';
          }
          return null;
        },

        //validator: widget.validateFun!,
        decoration: InputDecoration(
          hintText: "caption..",
          hintStyle: TextStyle(fontSize: 14.sp),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

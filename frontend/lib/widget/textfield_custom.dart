import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldCustom extends StatefulWidget {
  final double? width;
  final String? hintText;
  final String? prefixSvg;
  final double? padding;
  final String? rules;
  final bool isPass;
  final bool underline;
  // final String Function(String?)? validateFun;
  const TextFieldCustom({
    required this.prefixSvg,
    this.padding,
    //this.validateFun,
    this.rules = "",
    this.hintText,
    this.width,
    required this.underline,
    Key? key,
    required this.isPass,
  }) : super(key: key);

  @override
  TextFieldCustomState createState() => TextFieldCustomState();
}

class TextFieldCustomState extends State<TextFieldCustom> {
  TextEditingController myController = TextEditingController();
  String text = "";
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: widget.width,
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              SvgPicture.asset(
                widget.prefixSvg!,
                height: 18.sp,
                color: Theme.of(context).textTheme.bodyText1?.color,
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                width: widget.width == null
                    ? size.width - 2 * widget.padding! - 80
                    : widget.width! - 80,
                child: TextFormField(
                  controller: myController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      print("empty");
                      return 'Error Message';
                    }
                    return null;
                  },
                  obscureText: widget.isPass ? true : false,
                  //validator: widget.validateFun!,
                  onChanged: (value) => text = myController.text,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: GoogleFonts.poppins(fontSize: 14.sp),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          widget.underline
              ? Container(
                  width: widget.width ?? size.width - 2 * widget.padding!,
                  height: .5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).textTheme.bodyText2?.color,
                    borderRadius: BorderRadius.circular(1),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

class PassField extends StatefulWidget {
  const PassField(
      {Key? key,
      this.width,
      this.padding,
      this.readOnly = false,
      this.rules = ""})
      : super(key: key);
  final String? rules;
  final double? width;
  final double? padding;
  final bool readOnly;
  @override
  _PassFieldState createState() => _PassFieldState();
}

class _PassFieldState extends State<PassField> {
  String prefixSvg = "/svg/lock.svg";
  String hintText = "password";
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: widget.width,
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              SvgPicture.asset(
                prefixSvg,
                height: 16,
                color: Theme.of(context).textTheme.bodyText1?.color,
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: widget.width == null
                    ? size.width - 2 * widget.padding! - 100
                    : widget.width! - 100,
                child: TextField(
                  obscuringCharacter: '•',
                  obscureText: showPassword ? false : true,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                child: showPassword
                    ? SvgPicture.asset(
                        "assets/svg/eye_close.svg",
                        height: 16,
                        color: Theme.of(context).textTheme.bodyText1?.color,
                      )
                    : SvgPicture.asset(
                        "assets/svg/eye_open.svg",
                        height: 12,
                        color: Theme.of(context).textTheme.bodyText1?.color,
                      ),
              ),
            ],
          ),
          Container(
            width: widget.width ?? size.width - 2 * widget.padding!,
            height: .5,
            decoration: BoxDecoration(
              color: Theme.of(context).textTheme.bodyText2?.color,
              borderRadius: BorderRadius.circular(1),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_socialmedia/constants/constants.dart';
import 'package:internship_socialmedia/controller/user_controller.dart';
import 'package:internship_socialmedia/models/user_model.dart';
import 'package:internship_socialmedia/screens/profile/profile_page.dart';

class ProfileSelection extends StatefulWidget {
  const ProfileSelection(
      {Key? key,
      required this.overlayEntry,
      required this.user,
      required this.userContrller})
      : super(key: key);
  final OverlayEntry overlayEntry;
  final UserContrller userContrller;
  final UserModel user;
  @override
  _ProfileSelectionState createState() => _ProfileSelectionState();
}

class _ProfileSelectionState extends State<ProfileSelection> {
  List<String> profiles = [
    "https://m.media-amazon.com/images/I/31Cd9UQp6eL._SX355_.jpg",
    "https://m.media-amazon.com/images/I/41jLBhDISxL._SY355_.jpg",
    "https://m.media-amazon.com/images/I/41r0oAaPp0L._AC_.jpg",
    "https://m.media-amazon.com/images/I/41ONa5HOwfL.jpg",
    "https://m.media-amazon.com/images/I/41miU+cgrLL.jpg",
    "https://m.media-amazon.com/images/I/41Brp3Gs6sL.jpg",
    "https://m.media-amazon.com/images/I/31jPSK41kEL.jpg",
    "https://m.media-amazon.com/images/I/31o-VWlOtKL.jpg",
    "https://m.media-amazon.com/images/I/41KUW8tYy5L._SY355_.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.black.withOpacity(.1),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                widget.overlayEntry.remove();
              },
              child: Container(
                color: Colors.black.withOpacity(.4),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                height: 370,
                width: MediaQuery.of(context).size.width - defaultPadding * 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: bgColor),
                child: GridView.count(
                  crossAxisCount: 3,
                  children: [
                    for (String profile in profiles)
                      GestureDetector(
                          onTap: () {
                            widget.userContrller.updateProfile(
                                id: widget.user.id,
                                profile_url: profile,
                                context: context);
                            widget.overlayEntry.remove();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(profile),
                          ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}

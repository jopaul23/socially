import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internship_socialmedia/api/post_api.dart';
import 'package:internship_socialmedia/constants/constants.dart';
import 'package:internship_socialmedia/controller/add_post_controller.dart';
import 'package:internship_socialmedia/controller/add_post_controller.dart';
import 'package:internship_socialmedia/screens/addPost/caption_constainer.dart';
import 'package:internship_socialmedia/widget/buttons/primary_btn.dart';
import 'package:internship_socialmedia/widget/textfield_custom.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  AddPostController addPostController = Get.put(AddPostController());
  final captionKey = GlobalKey<CaptionContainerState>();
  String path = '';
  XFile? image;
  File? storedImage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    "assets/svg/back.svg",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "add medicine",
                style: TextStyle(
                  color: textColor1,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  storedImage == null
                      ? Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.width -
                              defaultPadding * 5,
                          width: MediaQuery.of(context).size.width -
                              defaultPadding * 2,
                          child: const Text("no image added"),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: textColor1.withOpacity(0.1),
                          ),
                        )
                      : Image.file(
                          storedImage!,
                          width: MediaQuery.of(context).size.width,
                        ),
                  GestureDetector(
                    onTap: imageAdd,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: primaryBlue,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Icon(
                        Icons.add_a_photo,
                        color: white,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              CaptionContainer(
                key: captionKey,
              ),
              const SizedBox(
                height: 50,
              ),
              PrimaryButton(
                  onpressed: () async {
                    final Directory applicationDirectory =
                        await getApplicationDocumentsDirectory();
                    String applicationPath = applicationDirectory.path;

                    File compresseedImage = await testCompressAndGetFile(
                        File(image!.path), '$applicationPath/${image!.name}');
                    PostApi.uploadImage(
                        XFile('$applicationPath/${image!.name}'),
                        captionKey.currentState!.textEditingController.text);
                    print(
                        "caption ${captionKey.currentState!.textEditingController.text}");
                  },
                  text: "post")
            ],
          ),
        ),
      ),
    );
  }

  imageAdd() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image

    image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      storedImage = File(image!.path);
    });

// copy the file to a new path
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      minWidth: 720,
      minHeight: 480,
      quality: 50,
    );

    print(file.lengthSync());
    print(result!.lengthSync());

    return result;
  }
}

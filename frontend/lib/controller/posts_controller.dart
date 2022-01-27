import 'package:get/get.dart';
import 'package:internship_socialmedia/api/post_api.dart';
import 'package:internship_socialmedia/models/post_model.dart';

class PostController extends GetxController {
  List<PostModel> postsList = [];
  getAllPosts() async {
    List<Map<String, dynamic>> mapList = [];
    List<PostModel> list = await PostApi.getPosts();
    postsList = list;
    print("lenght of post list ${postsList.length}");
    update();
  }
}

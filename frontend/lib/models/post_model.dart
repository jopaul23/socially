class PostModel {
  final String url;
  final String userId;
  final String userName;
  final String caption;
  final String postId;

  PostModel(
      {required this.url,
      required this.postId,
      required this.userId,
      required this.userName,
      required this.caption});
  factory PostModel.fromMap({required Map<String, dynamic> map}) {
    return PostModel(
        url: map["file"],
        userId: map["owner_id"],
        userName: map["owner_name"],
        caption: map["caption"],
        postId: map["_id"]);
  }
}

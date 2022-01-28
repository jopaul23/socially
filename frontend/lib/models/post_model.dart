class PostModel {
  final String url;
  final String userId;
  final String userName;
  final String caption;
  final String postId;
  final String profile;

  PostModel(
      {required this.url,
      required this.postId,
      required this.profile,
      required this.userId,
      required this.userName,
      required this.caption});
  factory PostModel.fromMap({required Map<String, dynamic> map}) {
    return PostModel(
        url: map["file"],
        userId: map["owner_id"],
        userName: map["owner_name"],
        caption: map["caption"],
        profile: map["owner_profile"] ??
            "https://conference.pecb.com/wp-content/uploads/2017/10/no-profile-picture-300x216.jpg",
        postId: map["_id"]);
  }
}

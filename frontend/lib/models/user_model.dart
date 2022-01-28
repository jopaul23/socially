class UserModel {
  final String name;
  final String email;
  final String id;
  final String profile;
  final List<String> posts;

  UserModel({
    required this.profile,
    required this.name,
    required this.email,
    required this.posts,
    required this.id,
  });
  factory UserModel.fromMap({required Map<String, dynamic> map}) {
    return UserModel(
        name: map["name"],
        email: map["email"],
        id: map["_id"],
        profile: map["profile"],
        posts: map["posts"]);
  }
}

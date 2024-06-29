class User {
  User({
    required this.nickName,
    required this.name,
    required this.avatar,
  }) : skills = [];

  final String nickName;
  final String name;
  final String avatar;
  List<String> skills;
}

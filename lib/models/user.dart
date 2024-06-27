class User {
  User({
    required this.nickName,
    required this.name,
    required this.avatar,
  });

  final String nickName;
  final String name;
  final String avatar;
  List<Map<String, Expertise>>? skills;
}

enum Expertise {
  beginner,
  intermediate,
  proefficient,
  expert,
}

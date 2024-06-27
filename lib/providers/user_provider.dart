import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skillshunt/models/user.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void createUser({
    required nickName,
    required name,
    required avatar,
  }) {
    state = User(nickName: nickName, name: name, avatar: avatar);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) => UserNotifier());

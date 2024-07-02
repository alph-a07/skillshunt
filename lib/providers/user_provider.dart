import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skillshunt/db/firebase_methods.dart';
import 'package:skillshunt/models/user.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void updateUser() async {
    state = await fetchUser();
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) => UserNotifier());

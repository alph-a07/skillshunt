import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skillshunt/data/skills.dart';
import 'package:skillshunt/db/firebase_methods.dart';
import 'package:skillshunt/models/user.dart';
import 'package:skillshunt/providers/skills_provider.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier(this.ref) : super(null);

  final Ref ref;

  void updateUser() async {
    state = await fetchUser();
    ref.read(selectedSkillsProvider.notifier).updateSkills(state!.skills);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) => UserNotifier(ref));

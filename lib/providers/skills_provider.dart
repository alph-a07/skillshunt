import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedSkillsNotifier extends StateNotifier<List<String>> {
  SelectedSkillsNotifier() : super([]);

  void selectSkill(String skill) {
    if (state.contains(skill)) return;

    state = [...state, skill];
  }

  void unselectSkill(String skill) {
    if (!state.contains(skill)) return;

    state = state.where((item) => item != skill).toList();
  }

  void uploadSkills() {
    DatabaseReference dbRef =
        FirebaseDatabase.instance.ref('users/${FirebaseAuth.instance.currentUser!.uid}');

    dbRef.update({'skills': state});
  }
}

final selectedSkillsProvider =
    StateNotifierProvider<SelectedSkillsNotifier, List<String>>((ref) => SelectedSkillsNotifier());

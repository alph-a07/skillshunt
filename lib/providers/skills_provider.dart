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
}

final selectedSkillsProvider =
    StateNotifierProvider<SelectedSkillsNotifier, List<String>>((ref) => SelectedSkillsNotifier());

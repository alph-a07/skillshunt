import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skillshunt/providers/skills_provider.dart';
import 'package:skillshunt/providers/user_provider.dart';
import 'package:skillshunt/screens/dashboard_screen.dart';
import 'package:skillshunt/widgets/gradient_button.dart';
import 'package:skillshunt/widgets/search_bar.dart';

class SkillsSelectionScreen extends ConsumerStatefulWidget {
  const SkillsSelectionScreen({super.key});

  @override
  ConsumerState<SkillsSelectionScreen> createState() => _SkillsSelectionScreenState();
}

class _SkillsSelectionScreenState extends ConsumerState<SkillsSelectionScreen> {
  void onSaveSkills() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DashboardScreen(),
      ),
    );

    ref.read(selectedSkillsProvider.notifier).uploadSkills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Select your Skills'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MySearchBar(),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                runSpacing: 8,
                spacing: 8,
                children: [
                  for (String skill in ref.watch(selectedSkillsProvider))
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).colorScheme.surfaceTint.withAlpha(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            skill,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                            onTap: () {
                              ref.read(selectedSkillsProvider.notifier).unselectSkill(skill);
                            },
                            child: const Icon(
                              Icons.close_rounded,
                              size: 16,
                              color: Colors.white30,
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
            GradientButton(
              onPressed: onSaveSkills,
              label: 'Start Learning',
              icon: Icons.rocket,
            ),
          ],
        ),
      ),
    );
  }
}

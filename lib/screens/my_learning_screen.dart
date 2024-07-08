import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skillshunt/data/gradients.dart';
import 'package:skillshunt/providers/skills_provider.dart';
import 'package:skillshunt/widgets/skill_tile.dart';

class MyLearningScreen extends ConsumerStatefulWidget {
  const MyLearningScreen({super.key});

  @override
  ConsumerState<MyLearningScreen> createState() => _MyLearningScreenState();
}

class _MyLearningScreenState extends ConsumerState<MyLearningScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedSkills = ref.watch(selectedSkillsProvider);
    final random = Random();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ongoing Skills',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xff16222a), Color(0xff3a6073)],
                          stops: [0, 1],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.add_circle_outline_rounded,
                          color: Colors.white60,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'New Skill',
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white60,
                              ),
                        ),
                      ],
                    ),
                  ),
                  for (final skill in selectedSkills)
                    SkillTile(randomIndex: random.nextInt(gradients.length))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

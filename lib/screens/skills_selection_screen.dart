import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skillshunt/models/skill.dart';
import 'package:skillshunt/providers/utilities_provider.dart';

class SkillsSelectionScreen extends ConsumerWidget {
  const SkillsSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('What do you know?'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ref.read(toNormalTextProvider)(Expertise.beginner.name),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              ref.read(toNormalTextProvider)(Expertise.intermediate.name),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              ref.read(toNormalTextProvider)(Expertise.advanced.name),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

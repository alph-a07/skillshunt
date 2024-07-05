import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyLearningScreen extends ConsumerWidget {
  const MyLearningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Ongoing Skills',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
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
          ],
        ),
      ),
    );
  }
}

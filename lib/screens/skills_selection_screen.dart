import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skillshunt/widgets/search_bar.dart';

class SkillsSelectionScreen extends ConsumerStatefulWidget {
  const SkillsSelectionScreen({super.key});

  @override
  ConsumerState<SkillsSelectionScreen> createState() => _SkillsSelectionScreenState();
}

class _SkillsSelectionScreenState extends ConsumerState<SkillsSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('What do you know?'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: MySearchBar()),
          ],
        ),
      ),
    );
  }
}

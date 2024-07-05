import 'package:flutter/material.dart';
import 'package:skillshunt/data/gradients.dart';

class SkillTile extends StatelessWidget {
  const SkillTile({required this.randomIndex, super.key});

  final int randomIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration:
          BoxDecoration(gradient: gradients[randomIndex], borderRadius: BorderRadius.circular(8)),
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
    );
  }
}

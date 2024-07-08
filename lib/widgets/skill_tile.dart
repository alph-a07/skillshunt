import 'package:flutter/material.dart';
import 'package:skillshunt/data/gradients.dart';

class SkillTile extends StatelessWidget {
  const SkillTile({
    required this.title,
    required this.randomIndex,
    super.key,
  });

  final int randomIndex;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration:
          BoxDecoration(gradient: gradients[randomIndex], borderRadius: BorderRadius.circular(8)),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white60,
            ),
      ),
    );
  }
}

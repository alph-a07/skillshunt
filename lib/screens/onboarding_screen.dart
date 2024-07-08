import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skillshunt/models/user.dart';
import 'package:skillshunt/screens/skills_selection_screen.dart';
import 'package:skillshunt/widgets/gradient_button.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen(
      {required this.nickName, required this.name, required this.avatar, super.key});

  final String nickName;
  final String name;
  final String avatar;

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  String? nickName;
  String? name;
  User? user;

  final _nameController = TextEditingController();
  final _nickNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nickNameController.text = widget.nickName;
      _nameController.text = widget.name;
    });
  }

  void onNextPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SkillsSelectionScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: CircleAvatar(
                child: Image.network(widget.avatar),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            TextField(
              controller: _nickNameController,
              decoration: const InputDecoration(
                label: Text('Nickname'),
                suffixIcon: Icon(Icons.edit),
              ),
              onChanged: (value) {
                setState(() {
                  nickName = value;
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                label: Text('Name'),
                suffixIcon: Icon(Icons.edit),
              ),
              onChanged: (value) {
                setState(() {
                  nickName = value;
                });
              },
            ),
            const SizedBox(height: 48),
            GradientButton(
              label: 'Next',
              icon: Icons.arrow_forward_rounded,
              onPressed: onNextPressed,
            ),
          ],
        ),
      ),
    );
  }
}

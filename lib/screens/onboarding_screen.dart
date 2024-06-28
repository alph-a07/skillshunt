import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skillshunt/providers/user_provider.dart';
import 'package:skillshunt/widgets/gradient_button.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  String? nickName;
  String? name;

  final _nameController = TextEditingController();
  final _nickNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(userProvider);
      _nickNameController.text = user!.nickName;
      _nameController.text = user.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);

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
                child: Image.network(user!.avatar),
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
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

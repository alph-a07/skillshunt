import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skillshunt/providers/user_provider.dart';
import 'package:skillshunt/screens/onboarding_screen.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  Future<void> _onGitHubSignUp() async {
    GithubAuthProvider githubProvider = GithubAuthProvider();

    try {
      final credentials = await FirebaseAuth.instance.signInWithProvider(githubProvider);
      final profile = credentials.additionalUserInfo!.profile!;
      final isNewUser = credentials.additionalUserInfo!.isNewUser;

      ref.read(userProvider.notifier).createUser(
            nickName: profile['login'],
            name: profile['name'],
            avatar: profile['avatar_url'],
          );

      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Action could not be performed. Try again!'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SkillsHunt',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _onGitHubSignUp,
          label: const Text('GitHub'),
          icon: const Icon(Icons.login),
        ),
      ),
    );
  }
}

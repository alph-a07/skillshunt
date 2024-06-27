import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skillshunt/providers/user_provider.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  Future<void> _onGitHubSignUp() async {
    // Create a new provider
    GithubAuthProvider githubProvider = GithubAuthProvider();

    try {
      final credentials = await FirebaseAuth.instance.signInWithProvider(githubProvider);
      final profile = credentials.additionalUserInfo!.profile!;

      ref.read(userProvider.notifier).createUser(
            nickName: profile['login'],
            name: profile['name'],
            avatar: profile['avatar_url'],
          );
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
        title: const Text('SkillsHunt'),
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  Future<void> _onGitHubSignUp() async {
    // Create a new provider
    GithubAuthProvider githubProvider = GithubAuthProvider();

    try {
      final credentials = await FirebaseAuth.instance.signInWithProvider(githubProvider);
      print('🚀 $credentials');
    } catch (e) {
      print('💥 $e');
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

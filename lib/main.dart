import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:skillshunt/firebase_options.dart';
import 'package:skillshunt/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blueGrey,
  brightness: Brightness.dark,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillsHunt',
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        colorScheme: kColorScheme,
      ),
      home: const SignupScreen(),
    );
  }
}

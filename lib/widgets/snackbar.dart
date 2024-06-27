import 'package:flutter/material.dart';

class Snackbar extends StatelessWidget {
  const Snackbar({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SnackBar(content: Text(message));
  }
}

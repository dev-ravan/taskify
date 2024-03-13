import 'package:flutter/material.dart';
import 'package:taskify/widgets/texts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [myTexts.med32dmSans(text: "Login", context: context)],
      ),
    );
  }
}

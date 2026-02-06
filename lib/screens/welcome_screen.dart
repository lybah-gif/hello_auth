import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('👋', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            const Text('HelloAuth',
                style: TextStyle(
                    fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            CustomButton(
              text: 'Sign up',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SignupScreen()));
              },
            ),
            const SizedBox(height: 12),
            TextButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}

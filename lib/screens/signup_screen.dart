import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/auth_header.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  final AuthService _authService = AuthService();

  void _signup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      await _authService.signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      Navigator.pop(context); // Auth state handles redirect
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthHeader(
                  title: 'Let’s get you signed up!',
                  subtitle:
                  'By signing up, you agree to our Terms & Privacy Policy.',
                ),
                const SizedBox(height: 32),

                CustomTextField(
                  controller: _emailController,
                  hint: 'Email',
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: _passwordController,
                  hint: 'Password',
                  obscure: true,
                ),
                const SizedBox(height: 24),

                _loading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                  text: 'Sign up',
                  onPressed: _signup,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

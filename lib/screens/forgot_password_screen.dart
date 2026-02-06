import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/auth_header.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _loading = false;

  void _resetPassword() async {
    setState(() => _loading = true);

    try {
      await _authService.resetPassword(_emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );
      Navigator.pop(context);
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthHeader(
                title: 'Reset Password',
                subtitle: 'Enter your email to receive a reset link',
              ),
              const SizedBox(height: 32),

              CustomTextField(
                controller: _emailController,
                hint: 'Email',
              ),
              const SizedBox(height: 24),

              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                text: 'Send reset link',
                onPressed: _resetPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

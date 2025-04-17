import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ocr/constant.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_login_row.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _obscurePassword = true;
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                // App Logo
                Center(
                  child: Image.asset(
                    'assets/images/Asset 1@2x.png',
                    height: 80,
                  ),
                ),
                const SizedBox(height: 30),
                // Sign up text
                const Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                // First name field
                CustomTextField(
                  label: 'First Name',
                  controller: _firstNameController,
                ),
                const SizedBox(height: 20),
                // Last name field
                CustomTextField(
                  label: 'Last Name',
                  controller: _lastNameController,
                ),
                const SizedBox(height: 20),
                // Email field
                CustomTextField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                // Password field
                CustomTextField(
                  label: 'Password',
                  isPassword: true,
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  onToggleVisibility: _togglePasswordVisibility,
                ),
                const SizedBox(height: 40),
                // Register button
                ElevatedButton(
                  onPressed: () {
                    context.go('/home'); // If using go_router
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'REGISTER',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have an account?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/signin');
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Social login
                const SocialLoginRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

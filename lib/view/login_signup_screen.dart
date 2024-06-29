// lib/login_signup_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/auth.dart';
import 'package:shopping_app/services/auth_service.dart';
import 'home_screen.dart';

class LoginSignupScreen extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final AuthService authService = AuthService();

  LoginSignupScreen({super.key});

  void signUpUser(BuildContext context) {
    authService.signup(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(authNotifier.isLogin ? 'Login' : 'Signup'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!authNotifier.isLogin) ...[
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  obscureText: true,
                ),
                if (!authNotifier.isLogin) ...[
                  const SizedBox(height: 20),
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    obscureText: true,
                  ),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _submit(context, ref),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    authNotifier.isLogin ? 'Login' : 'Signup',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                TextButton(
                  onPressed: authNotifier.toggleFormType,
                  child: Text(
                    authNotifier.isLogin
                        ? 'Don’t have an account? Signup'
                        : 'Already have an account? Login',
                    style: const TextStyle(color: Colors.teal),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  void _submit(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider);
    final email = _emailController.text;
    final password = _passwordController.text;

    if (authNotifier.isLogin) {
      // Dummy login logic
      if (email.isNotEmpty && password.isNotEmpty) {
        // Login successful
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Show error (invalid input)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter valid credentials')),
        );
      }
    } else {
      final username = _usernameController.text;
      final confirmPassword = _confirmPasswordController.text;

      if (password == confirmPassword &&
          email.isNotEmpty &&
          username.isNotEmpty) {
        // Signup successful
        signUpUser(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup successful!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Show error (passwords do not match or invalid input)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Passwords do not match or invalid input!')),
        );
      }
    }
  }
}

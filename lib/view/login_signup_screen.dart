// lib/login_signup_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/model/auth.dart';
import 'home_screen.dart';

class LoginSignupScreen extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
              boxShadow: [
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
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
                  SizedBox(height: 20),
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
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _submit(context, ref),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    authNotifier.isLogin ? 'Login' : 'Signup',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                TextButton(
                  onPressed: authNotifier.toggleFormType,
                  child: Text(
                    authNotifier.isLogin
                        ? 'Don’t have an account? Signup'
                        : 'Already have an account? Login',
                    style: TextStyle(color: Colors.teal),
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
          SnackBar(content: Text('Login successful!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Show error (invalid input)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter valid credentials')),
        );
      }
    } else {
      final confirmPassword = _confirmPasswordController.text;
      if (password == confirmPassword && email.isNotEmpty) {
        // Signup successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup successful!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Show error (passwords do not match or invalid input)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match or invalid input!')),
        );
      }
    }
  }
}

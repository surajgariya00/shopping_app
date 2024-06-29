// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/view/login_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Signup Demo with Riverpod',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true
      ),
      home: LoginSignupScreen(),
    );
  }
}

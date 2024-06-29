// lib/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

final authProvider = ChangeNotifierProvider<AuthNotifier>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends ChangeNotifier {
  bool isLogin = true;
  bool isLoggedIn = false;  // Track logged-in state

  void toggleFormType() {
    isLogin = !isLogin;
    notifyListeners();
  }

  void login() {
    isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    isLoggedIn = false;
    notifyListeners();
  }
}

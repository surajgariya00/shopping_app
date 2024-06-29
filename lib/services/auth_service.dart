import 'package:flutter/material.dart';
import 'package:shopping_app/constants/error_handling.dart';
import 'package:shopping_app/constants/utils.dart';
import 'package:shopping_app/model/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // Signup user
  void signup({
    required BuildContext context,
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      User user = User(
        id: '',
        email: email,
        name: username,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse("$uri/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account created successfully!');
        },
      );
    } catch (e) {
      print('Error: $e');
      showSnackBar(context, e.toString());
    }
  }
}

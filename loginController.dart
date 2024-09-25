import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'loginModel.dart';


class LoginController with ChangeNotifier {
  LoginModel? _loginModel;
  bool isLoading = false;
  String? errorMessage;

  // Getter for the login model
  LoginModel? get loginModel => _loginModel;

  // Method to handle login API call
  Future<void> login(String identifier) async {
    isLoading = true;
    notifyListeners();

    const   url = 'http://hovee.in/app/public/api/login';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'identifier': identifier});

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        _loginModel = LoginModel.fromJson(jsonResponse);
        errorMessage = null;
      } else {
        // Handle error response
        errorMessage = 'Login failed: ${response.body}';
      }
    } catch (e) {
      errorMessage = 'Error: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
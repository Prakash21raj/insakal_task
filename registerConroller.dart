import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'registerModel.dart';


class RegisterController with ChangeNotifier {
  bool isTermsAccepted = false; void toggleTermsAccepted(bool value) {
    isTermsAccepted = value;
    notifyListeners();
  }

  bool isLoading = false;
  String? errorMessage;
  String? successMessage;

  // Method to handle the registration API call
  Future<void> register(RegisterModel registerModel) async {
    isLoading = true;
    notifyListeners();

    const   url = 'http://hovee.in/app/public/api/register';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(registerModel.toJson());

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        successMessage = jsonResponse['message'] ?? 'Registration successful';
        errorMessage = null;
      } else {
        errorMessage = 'Registration failed: ${response.body}';
      }
    } catch (e) {
      errorMessage = 'Error: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
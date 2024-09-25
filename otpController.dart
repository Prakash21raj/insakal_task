import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'otpModel.dart';

class OtpController with ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  Future<void> verifyOtp(OtpModel otpModel) async {
    isLoading = true;
    notifyListeners();

    const url = 'http://hovee.in/app/public/api/verifyOTP';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(otpModel.toJson());

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        // Handle successful response
        errorMessage = null;
        print('OTP Verified successfully');
      } else {
        errorMessage = 'Failed to verify OTP: ${response.body}';
      }
    } catch (e) {
      errorMessage = 'Error: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}
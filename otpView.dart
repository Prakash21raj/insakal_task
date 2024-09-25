import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'otpController.dart';
import 'otpModel.dart';


class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final otpController = Provider.of<OtpController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userIdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'User ID',
                border: OutlineInputBorder(), // Added border
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(), // Added border
              ),
            ),
            const SizedBox(height: 20),
            if (otpController.isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () {
                  int userId = int.tryParse(_userIdController.text) ?? 0;
                  String otp = _otpController.text;

                  if (userId > 0 && otp.isNotEmpty) {
                    // Create the OtpModel object and pass the platform as 'ANDROID'
                    OtpModel otpModel = OtpModel(
                      userId: userId,
                      otp: otp,
                      platform: 'ANDROID', // Hardcoded platform field
                    );

                    otpController.verifyOtp(otpModel);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill in all fields')),
                    );
                  }
                },
                child: const Text('Verify OTP'),
              ),
            if (otpController.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  otpController.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
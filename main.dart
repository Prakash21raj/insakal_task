import 'package:flutter/material.dart';
import 'package:insakal_task/register/registerConroller.dart';
import 'package:insakal_task/register/registerView.dart';
import 'package:provider/provider.dart';

import 'login/logiView.dart';
import 'login/loginController.dart';

import 'otp/otpController.dart';
import 'otp/otpView.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => RegisterController()),
        ChangeNotifierProvider(create: (_) => OtpController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',  // Set the initial route
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/otp': (context) => const OtpScreen(),
      },
    );
  }
}
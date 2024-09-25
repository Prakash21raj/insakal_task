import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'loginController.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController identifierController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            TextField(
              controller: identifierController,
              decoration: const InputDecoration(
                labelText: 'Identifier',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final identifier = identifierController.text;
                if (identifier.isNotEmpty) {
                  await loginController.login(identifier);
                  if (loginController.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(loginController.errorMessage!)),
                    );
                  } else {
                    // Handle successful login (e.g., navigate to another screen)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Login successful')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter an identifier')),
                  );
                }
              },
              child: loginController.isLoading
                  ? const CircularProgressIndicator(
                color: Colors.white,
              )
                  : const Text('Login'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Does not have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');

                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 15,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
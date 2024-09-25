import 'package:flutter/material.dart';
import 'package:insakal_task/register/registerConroller.dart';

import 'package:provider/provider.dart';

import 'registerModel.dart';


class RegisterScreen extends StatelessWidget {
  final GlobalKey _formkey= GlobalKey();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController governmentProofController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registerController = Provider.of<RegisterController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                _buildTextField(firstNameController, 'First Name'),
                const SizedBox(height: 10),
                _buildTextField(lastNameController, 'Last Name'),
                const SizedBox(height: 10),
                _buildTextField(dobController, 'Date of Birth (YYYY-MM-DD)'),
                const SizedBox(height: 10),
                _buildTextField(mobileNoController, 'Mobile Number'),
                const SizedBox(height: 10),
                _buildTextField(emailController, 'Email'),
                const SizedBox(height: 10),
                _buildTextField(pincodeController, 'Pincode'),
                const SizedBox(height: 10),
                _buildTextField(governmentProofController, 'Government Proof ID'),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: registerController.isTermsAccepted,  // Bind to controller state
                      onChanged: (value) {
                        registerController.toggleTermsAccepted(value!);  // Update state
                      },
                    ),
                    const Text('Accept Terms & Conditions'),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {

                    final registerModel = RegisterModel(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      dob: dobController.text,
                      mobileNo: mobileNoController.text,
                      email: emailController.text,
                      pincode: pincodeController.text,
                      governmentProof: int.tryParse(governmentProofController.text),
                      termsAccepted: true,
                      wVerify: true,

                    );
                    await registerController.register(registerModel);

                    // Handle success or error
                    if (registerController.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(registerController.errorMessage!)),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(registerController.successMessage!)),
                      );
                      Navigator.pushNamed(context, '/otp');

                    }
                  },
                  child: registerController.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
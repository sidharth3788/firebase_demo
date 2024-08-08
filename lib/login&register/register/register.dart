import 'package:flutter/material.dart';
import 'register_controller.dart';

class RegisterPage extends StatelessWidget {
  final RegController registerController = RegController();
  RegisterPage({super.key});
  // Key for Form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                //Call Like Below
                customTextFormField(
                    controller: registerController.usernameTXT,
                    hint: '@gmail.com',
                    label: 'Username',
                    leadingIcon: Icons.person,
                    validator: (value) => emptyValidation(value: value)),
                customTextFormField(
                  controller: registerController.passwordTXT,
                  hint: '****',
                  label: 'Enter Password',
                  leadingIcon: Icons.password,
                  obscureText: true,
                  validator: (value) => emptyValidation(value: value),
                ),
                customTextFormField(
                  controller: registerController.conpassTXT,
                  hint: '****',
                  label: 'Confirm Password',
                  leadingIcon: Icons.password,
                  obscureText: true,
                  validator: (value) => emptyValidation(value: value),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print(registerController.register);
                      //Add your action
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Processing Data'),
                        ),
                      );
                    }
                  },
                  child: const Text('Register'),
                ),
              ],
            )),
      )),
    );
  }

  Widget customTextFormField({
    required String label,
    required String hint,
    required String? Function(String?)? validator,
    required IconData leadingIcon,
    required TextEditingController controller,
    double borderRadius = 10.0, // Default obscureText
    bool obscureText = false, // Default obscureText
    Color borderColor = Colors.grey, // Default border color
    Color focusedBorderColor = Colors.redAccent, // Default focus border color
    double borderWidth = 0.3, // Default border width set to 0.3
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          isDense: true,
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(
            leadingIcon,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: focusedBorderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        validator: validator,
      ),
    );
  }

  // Your Validation Method
  String? emptyValidation({String? value}) {
    if (value == null || value.isEmpty) {
      return 'Field Empty!';
    }
    return null;
  }
}

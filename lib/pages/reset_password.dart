import 'package:auths_road/utils.dart';
import 'package:auths_road/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required TextEditingController controller});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              id: 1,
              controller: emailController,
              hintText: 'Your Email',
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              name: 'Email',
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                height: 50,
                width: 150,
                child: TextButton(
                  onPressed: () {
                    final email = emailController.text.trim();

                    if (email.isEmpty) {
                      Utils.toastMessage('Please enter your email');
                      return;
                    }
                    auth.sendPasswordResetEmail(email: email).then((value) {
                      Utils.toastMessage(
                          'We have sent you an email to change your password');
                    }).catchError((error) {
                      Utils.toastMessage(error.toString());
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Center(child: Text('email sent')),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.deepOrange,
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

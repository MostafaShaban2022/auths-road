import 'package:auths_road/cubit/auth_cubit.dart';
import 'package:auths_road/pages/home.dart';
import 'package:auths_road/pages/log_in.dart';
import 'package:auths_road/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogUp extends StatelessWidget {
  LogUp({super.key, required this.controller});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    Widget emailInput() {
      return CustomTextFormField(
        id: 1,
        controller: emailController,
        hintText: 'your email',
        keyboardType: TextInputType.name,
        obscureText: false,
        name: 'Email',
      );
    }

    Widget passwordInput() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: CustomTextFormField(
          id: 2,
          controller: passwordController,
          hintText: '********',
          keyboardType: TextInputType.phone,
          obscureText: true,
          name: 'Password',
        ),
      );
    }

    Widget logUpButton() {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            );
          }
          if (state is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.deepOrange,
                content: Text(state.error),
                duration: const Duration(seconds: 1),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Align(
            alignment: Alignment.center,
            child: Container(
              height: 50,
              width: 150,
              margin: const EdgeInsets.only(top: 30),
              child: TextButton(
                onPressed: () async {
                  if (kDebugMode) {
                    print(passwordController.text);
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                  context.read<AuthCubit>().signUp(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Center(
                  child: Text(
                    'Log Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    Widget footer() {
      return Center(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LogIn(
                  controller: TextEditingController(),
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(top: 50),
            child: const Text.rich(
              TextSpan(
                  text: 'Do you have an account?  ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: 'Log In',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      );
    }

    Widget engines() {
      return Container(
        margin: const EdgeInsets.only(top: 25),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  final GoogleSignIn googleSignIn = GoogleSignIn();

                  try {
                    final GoogleSignInAccount? googleSignInAccount =
                        await googleSignIn.signIn();

                    if (googleSignInAccount != null) {
                      final GoogleSignInAuthentication
                          googleSignInAuthentication =
                          await googleSignInAccount.authentication;

                      final AuthCredential credential =
                          GoogleAuthProvider.credential(
                        accessToken: googleSignInAuthentication.accessToken,
                        idToken: googleSignInAuthentication.idToken,
                      );

                      // Use the FirebaseAuth instance to sign in
                      await _auth.signInWithCredential(credential);
                    }
                  } catch (e) {
                    if (kDebugMode) {
                      print("Error signing in with Google: $e");
                    }
                  }
                },
                child: Image.asset(
                  'assets/google.png',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                'assets/apple.png',
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              emailInput(),
              passwordInput(),
              logUpButton(),
              footer(),
              engines(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:auths_road/cubit/auth_cubit.dart';
import 'package:auths_road/pages/home.dart';
import 'package:auths_road/pages/reset_password.dart';
import 'package:auths_road/widgets/custom_text_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogIn extends StatelessWidget {
  LogIn({super.key, required this.controller});
  final TextEditingController controller;
  final TextEditingController emailController = TextEditingController(
    text: '',
  );
  final TextEditingController passwordController = TextEditingController(
    text: '',
  );
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
          hintText: '********',
          controller: passwordController,
          keyboardType: TextInputType.phone,
          obscureText: true,
          name: 'Password',
        ),
      );
    }

    Widget logInButton() {
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
              margin: const EdgeInsets.only(top: 50),
              child: TextButton(
                onPressed: () async {
                  if (kDebugMode) {
                    print(passwordController.text);
                  }
                  context.read<AuthCubit>().signIn(
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
                    'Log In',
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
      return Container(
        margin: const EdgeInsets.only(top: 75),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResetPassword(
                  controller: controller,
                ),
              ),
            );
          },
          child: const Text(
            'forgot your password?',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            emailInput(),
            passwordInput(),
            logInButton(),
            footer(),
          ],
        ),
      ),
    );
  }
}

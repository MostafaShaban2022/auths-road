import 'package:auths_road/models/user_model.dart';
import 'package:auths_road/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = await UserService().getUserById(
        userCredential.user!.uid,
      );
      return user;
    } catch (e) {
      if (kDebugMode) {
        print("Error during sign-in: $e");
      }
      throw FirebaseAuthException(
        code: "sign_in_failed",
        message: "Failed to sign in. Please check your credentials.",
      );
    }
  }

  // SignUp method
  Future<UserModel> signUp({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: email,
      );
      await UserService().setUser(user);

      return user;
    } catch (e) {
      if (kDebugMode) {
        print("Error during sign-up: $e");
      }
      throw FirebaseAuthException(
        code: "sign_up_failed",
        message: "Failed to sign up. Please check your details and try again.",
      );
    }
  }

  // SignOut method
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print("Error during sign-out: $e");
      }
      rethrow;
    }
  }
}

import 'package:auths_road/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference _userRefrence =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userRefrence.doc(user.id).set({
        'email': user.email,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await _userRefrence.doc(id).get();
      return UserModel(
        id: id,
        email: snapshot['email'],
      );
    } catch (e) {
      rethrow;
    }
  }
}

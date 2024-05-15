import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../models/user.dart';
import '../utils/fb_constants.dart';

class UserService {
  static final UserService shared = UserService._();

  factory UserService() => shared;

  UserService._();

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User?> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final auth.UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final auth.User user = userCredential.user!;
      await _db.collection(FBConstants.user).doc(user.uid).set({
        'email': email,
        'name': name,
      });

      return User(
        id: user.uid,
        email: email,
        name: name,
      );
    } catch (e) {
      rethrow;
    }
  }
}

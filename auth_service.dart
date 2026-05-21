import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<String> signUp(String email, String password) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User created successfully");
      return userCredential.user!.uid;
    } catch (e) {
      print("error signing up: $e");
      return "";
    }
  }

  Future<String> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User logged in successfully");
      return userCredential.user!.uid;
    } catch (e) {
      print("Failed to LoginUser");
      print("error logging in: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
      return "";
    }
  }
}

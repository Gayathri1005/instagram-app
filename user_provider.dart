import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/services/auth_service.dart';
import 'package:instagram_app/services/firestore_service.dart';

class UserProvider with ChangeNotifier {
  // user auth flow, user account create, edit
  // notify listeners

  final _authService = AuthService();
  final _firestoreService = FirestoreService();
  Future<String> createUserInBackend(
    String name,
    String email,
    String password,
    String dob,
    String mobile,
    String city,
    String gender,
    String profileImageUrl,
  ) async {
    final String uid = await _authService.signUp(email, password);
    if (uid.isNotEmpty) {
      await _firestoreService.createUser(
        uid,
        name,
        email,
        dob,
        mobile,
        city,
        gender,
        profileImageUrl,
      );
    }
    return uid;
  }

  Future<String> loginUserInBackend(
    String email,
    String password,
    BuildContext context,
  ) async {
    final String uid = await _authService.login(email, password, context);
    return uid;
  }
}

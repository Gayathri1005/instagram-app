import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final userFirestoreInstance = FirebaseFirestore.instance.collection("users");

  Future<void> createUser(
    String uid,
    String name,
    String email,
    String dob,
    String mobile,
    String city,
    String gender,
    String profileImageUrl,
  ) async {
    try {
      await userFirestoreInstance.add({
        "uid": uid,
        "name": name,
        "email": email,
        "dob": dob,
        "mobile": mobile,
        "city": city,
        "gender": gender,
        "profileImageUrl": profileImageUrl,
      });
    } catch (e) {
      print("Error creating user in firestore: $e");
    }
  }
}

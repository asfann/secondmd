import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String name;

  const User({
    required this.uid,
    required this.email,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        "username": name,
        "uid": uid,
        "email": email,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        name: snapshot['username'],
        uid: snapshot['uid'],
        email: snapshot['email']);
  }
}

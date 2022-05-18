import 'package:cloud_firestore/cloud_firestore.dart';

class Waiter {
  final String surname;
  final String uid;
  final String name;
  final String postId;

  const Waiter({
    required this.postId,
    required this.uid,
    required this.surname,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "surname": name,
    "uid": uid,
    "email": surname,
  };

  static Waiter fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Waiter(
      postId: snapshot['postId'],
        name: snapshot['name'],
        uid: snapshot['uid'],
        surname: snapshot['surname']);
  }
}
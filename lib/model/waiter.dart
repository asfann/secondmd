import 'package:cloud_firestore/cloud_firestore.dart';

class Waiter {
  final String surname;
  final String uid;
  final String name;
  final String waiterId;

  const Waiter({
    required this.waiterId,
    required this.uid,
    required this.surname,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
    "waiterId": waiterId,
    "name": name,
    "uid": uid,
    "surname": surname,
  };

  static Waiter fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Waiter(
        waiterId: snapshot['waiterId'],
        name: snapshot['name'],
        uid: snapshot['uid'],
        surname: snapshot['surname']);
  }
}
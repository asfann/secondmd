import 'package:cloud_firestore/cloud_firestore.dart';

class Table {
  final String uid;
  final String name;
  final int tNumber;
  final String postId;

  const Table({
    required this.uid,
    required this.tNumber,
    required this.postId,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
    "tNumber": tNumber,
    "surname": name,
    "postId": postId,
    "uid": uid,
  };

  static Table fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Table(
      postId: snapshot['postId'],
        tNumber: snapshot['tNumber'],
        name: snapshot['name'],
        uid: snapshot['uid']);
  }
}
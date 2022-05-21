import 'package:cloud_firestore/cloud_firestore.dart';

class Table {
  final String uid;
  final String name;
  final int tNumber;
  final String tableId;

  const Table({
    required this.uid,
    required this.tNumber,
    required this.tableId,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
    "tNumber": tNumber,
    "name": name,
    "tableId": tableId,
    "uid": uid,
  };

  static Table fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Table(
        tableId: snapshot['tableId'],
        tNumber: snapshot['tNumber'],
        name: snapshot['name'],
        uid: snapshot['uid']);
  }
}
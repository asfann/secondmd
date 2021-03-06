import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secondmd/model/post.dart';
import 'package:secondmd/model/waiter.dart';
import 'package:secondmd/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../model/table.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String name,
      int price,
  ) async {
    String res = "Some error occured";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('dishes', file, true);

      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          price: price,
          uid: uid,
          name: name,
          postId: postId,
          postUrl: photoUrl);
      _firestore.collection('dishes').doc(postId).set(
            post.toJson(),
          );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }


  Future<String> uploadWaiter(
      String surname,
      String uid,
      String name,
      ) async {
    String res = "Some error occured";
    try {

      String waiterId = const Uuid().v1();
            Waiter waiter = Waiter(
                uid: uid,
                name: name,
                surname: surname,
              waiterId: waiterId,);

      _firestore.collection('waiters').doc(waiterId).set(
        waiter.toJson(),
      );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> uploadTable(
      int tNumber,
      String uid,
      String name,
      ) async {
    String res = "Some error occured";
    try {
      String tableId = const Uuid().v1();
      Table table = Table(
        uid: uid,
        name: name,
        tNumber: tNumber,
        tableId: tableId,);
      _firestore.collection('tables').doc(tableId).set(
        table.toJson(),
      );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('dishes').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteTable(String postId) async {
    try {
      await _firestore.collection('tables').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }


  Future<String> updateWaiter(String surname,
      String name,String waiterId,
      String uid) async {

    String res = "Some error occured";
    try{
      Waiter waier = Waiter(
        uid: uid,
        name: name,
        surname: surname,
        waiterId: waiterId,);
      await _firestore.collection('dishes').doc(waiterId).update(waier.toJson());
    res = "success";
    } catch (err) {
    res = err.toString();
    }
    return res;

    }

  Future<void> deleteWaiter(String postId) async {
    try {
      await _firestore.collection('waiters').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}

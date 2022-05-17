import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secondmd/model/post.dart';
import 'package:secondmd/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String name,
  ) async {
    String res = "Some error occured";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('dishes', file, true);

      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          name: name,
          postId: postId,
          postUrl: photoUrl,);

      _firestore.collection('dishes').doc(postId).set(
            post.toJson(),
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

}

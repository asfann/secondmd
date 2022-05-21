import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final int price;
  final String uid;
  final String name;
  final String postId;
  final String postUrl;

  const Post({
    required this.price,
    required this.uid,
    required this.description,
    required this.postId,
    required this.name,
    required this.postUrl,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "description": description,
        "postId": postId,
        "postUrl": postUrl,
    "price":price
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      price: snapshot['price'],
        name: snapshot['name'],
        uid: snapshot['uid'],
        description: snapshot['description'],
        postId: snapshot['postId'],
        postUrl: snapshot['postUrl']);
  }
}

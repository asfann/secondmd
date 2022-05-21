import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secondmd/resources/firestore_methods.dart';

class DisCard extends StatefulWidget {
  const DisCard({Key? key}) : super(key: key);

  @override
  State<DisCard> createState() => _DisCardState();
}

class _DisCardState extends State<DisCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('dishes')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return  SafeArea(
              child: Column(
                 children: (snapshot.data as dynamic).docs.map<Widget>((document) {
                    return ListTile(
                      title: Text(document['name']),
                      subtitle: Text(document['description']),
                      leading: CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(
                          document['postUrl'],
                        ),),
                   trailing: IconButton(
                   icon: const Icon(
                   Icons.delete,
                   color: Colors.red,
                   ),
                   onPressed: () {
                     FirestoreMethods().deletePost(document["postId"]);
                   }
                    ));
                  }).toList(),
                  ),
            );
            },
        ),
      );
  }
}
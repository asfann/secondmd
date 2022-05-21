import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secondmd/resources/firestore_methods.dart';

class WaiCard extends StatefulWidget {
  const WaiCard({Key? key}) : super(key: key);

  @override
  State<WaiCard> createState() => _WaiCardState();
}

class _WaiCardState extends State<WaiCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('waiters')
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
                    title: Text(document['surname']),
                    subtitle: Text(document['name']),
                    trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          FirestoreMethods().deleteWaiter(document["waiterId"]);
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
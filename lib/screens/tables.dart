import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secondmd/resources/firestore_methods.dart';

class TabCard extends StatefulWidget {
  const TabCard({Key? key}) : super(key: key);

  @override
  State<TabCard> createState() => _TabCardState();
}

class _TabCardState extends State<TabCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tables')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return  SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: (snapshot.data as dynamic).docs.map<Widget>((document) {
                  return ListTile(
                      title: Text(document['surname']),
                      subtitle: Text(document['email']),

                      trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            FirestoreMethods().deleteTable(document["postId"]);
                          }
                      ),
                    onTap: () {

                    },
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secondmd/resources/firestore_methods.dart';
import 'package:secondmd/utils/colors.dart';
import 'package:secondmd/utils/utils.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../providers/user_provider.dart';
import '../widget/comment_card.dart';

class AddTableScreen extends StatefulWidget {
  const AddTableScreen({Key? key, this.snap}) : super(key: key);
final snap;
  @override
  State<AddTableScreen> createState() => _AddTableScreen();
}

class _AddTableScreen extends State<AddTableScreen> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;

  void postTable(
      String uid,
      ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadWaiter(
          _numberController.text, uid, _nameController.text);

      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Posted!', context);
        clearTextField();
      } else {
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }
  void clearTextField() {
    setState(() {
      _nameController.clear();
      _numberController.clear();
    });
  }

  @override
  void dispose() {
    _numberController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Post to '),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () => postTable(
              user.uid,
            ),
            child: const Text(
              'Post',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          _isLoading? const LinearProgressIndicator()
              : const Padding(
            padding: EdgeInsets.only(top: 0),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child:  TextField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                      hintText: 'Table number',
                      border: InputBorder.none),
                  maxLines: 8,
                ),
              ),
              const Divider(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child:  TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      hintText: 'Waiter name...',
                      border: InputBorder.none),
                  maxLines: 8,
                ),
              ),
              const Divider(),
            ],
          ),
          Column(
            children: [
              StreamBuilder(stream: FirebaseFirestore.instance
                  .collection('tables')
                  .snapshots(),
              builder:  (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(
    child: CircularProgressIndicator(),
    );
    }
    return ListView.builder(
    itemCount: (snapshot.data! as dynamic).docs.length,
    itemBuilder: (context, index) => CommentCard(
    snap: (snapshot.data! as dynamic).docs[index].data()),
    );})
            ],
          )
        ],
      ),
    );
  }
}
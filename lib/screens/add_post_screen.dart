import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secondmd/resources/firestore_methods.dart';
import 'package:secondmd/utils/colors.dart';
import 'package:secondmd/utils/utils.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../providers/user_provider.dart';
import '../widget/rounded_elecated_button.dart';
import 'dishes.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;

  void postImage(
    String uid,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text, _file!, uid, _nameController.text, int.parse(_priceController.text));

      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Posted!', context);
        clearImage();
      } else {
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);

                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }



  void clearImage() {
    setState(() {
      _file=null;
    });
  }
  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text('Post to '),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () => postImage(
                    user.uid
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child:  TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                              hintText: 'Write a caption...',
                              border: InputBorder.none),
                          maxLines: 3,
                        ),
                      ),
                    ), SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child:  TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                            hintText: 'Write a description...',
                            border: InputBorder.none),
                        maxLines: 3,
                      ),
                    ),SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child:  TextField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: 'Write a price...',
                            border: InputBorder.none),
                        maxLines: 3,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child:  _file == null
                       ? Container(child: IconButton(
                       icon: const Icon(Icons.upload),
                         onPressed: () => _selectImage(context),
                         ),
                         ):
                           Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: MemoryImage(_file!),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                          ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
                RoundedElevatedButton(title: 'Dishes', onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DisCard()));
                },   padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.4,
                  vertical: MediaQuery.of(context).size.height * 0.02,
                ),
                ),
              ],
            ),
          );
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_app/screens/dashboard.dart';


class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  XFile? image;
  final captionController = TextEditingController();

  Future<void> addPost(String postUrl) async {
    Map<String, dynamic> postData = {
      "userName": "Ramesh",
      "postUrl": postUrl,
      "caption": captionController.text,
      "dateTime": DateTime.now(),
      "likes": [],
      "comments": [],
      "shares": [],
    };
    await FirebaseFirestore.instance.collection("posts").add(postData);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Post added successfully")));
    Navigator.of(context).pop();
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => Dashboard()));
  }

  Future<String> uploadImageToStorage(String imagePath) async {
    final uploadedImage = await FirebaseStorage.instance
        .ref("posts/${DateTime.now().millisecondsSinceEpoch}")
        .putFile(File(imagePath));
    return await uploadedImage.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Post")),
      body: Column(
        children: [
          Container(
            height: 400,
            width: double.infinity,
            color: Colors.grey[300],
            child: image != null
                ? Image.file(File(image!.path))
                : Center(
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Choose Image from"),
                            // actions: [
                            //   TextButton(onPressed: () {}, child: Text("Cancel")),
                            //   TextButton(onPressed: () {}, child: Text("Okay")),
                            // ],
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    image = await ImagePicker().pickImage(
                                      source: ImageSource.camera,
                                    );
                                    setState(() {});
                                    print("Image selected");
                                    print(image?.path);
                                  },
                                  icon: Icon(Icons.camera, size: 60),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();

                                    image = await ImagePicker().pickImage(
                                      source: ImageSource.gallery,
                                    );
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.photo_library, size: 60),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel"),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(Icons.image, size: 50, color: Colors.blue),
                    ),
                  ),
          ),
          SizedBox(height: 16),
          TextFormField(
            minLines: 3,
            maxLines: 5,
            controller: captionController,
            decoration: InputDecoration(
              hintText: "Write a caption",
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              filled: true,
              fillColor: Colors.grey[300],
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () async {
              final String postUrl = await uploadImageToStorage(image!.path);
              await addPost(postUrl);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 43, 61, 76),
            ),
            child: Text("Post", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}

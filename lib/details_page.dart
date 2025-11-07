import 'dart:io';

import 'package:firebase_setup_g3/model/post_model.dart';
import 'package:firebase_setup_g3/service/rtdb_service.dart';
import 'package:firebase_setup_g3/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _jobscontroller = TextEditingController();
  File? file;
  final picker = ImagePicker();

  Future _getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print("Rasm Tanlanmadi");
      }
    });
  }

  Future _getImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print("Rasm Tanlanmadi");
      }
    });
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Get Gallery'),
              onTap: () {
                _getImageGallery();
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt_outlined),
              title: Text('Get Camera'),
              onTap: () {
                _getImageCamera();
              },
            ),
          ],
        );
      },
    );
  }

  void createPost() {
    String name = _namecontroller.text.trim().toString();
    String jobs = _jobscontroller.text.trim().toString();

    StorageService.uploadImage(file!).then((image_url) {
      addPost(name, jobs, image_url);
    });
  }

  void addPost(String name, String jobs, String image) {
    Post post = Post(name: name, jobs: jobs, image: image);

    RTDBService.addPost(post).then((value) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Post Qo'shildi")));
      Navigator.of(context).pop({"date": "done"});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Malumot Qo'shing", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _modalBottomSheetMenu,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image:
                            file != null
                                ? FileImage(file!)
                                : AssetImage("assets/img_2.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Rasm Kiiriting",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade300,
            ),
            child: TextField(
              controller: _namecontroller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                border: InputBorder.none,
                hintText: "Ism Kiriting",
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade300,
            ),
            child: TextField(
              controller: _jobscontroller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                border: InputBorder.none,
                hintText: "Ishingizni Kiriting",
              ),
            ),
          ),

          InkWell(
            onTap: createPost,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: 66,
              decoration: BoxDecoration(
                color: Colors.orange,

                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "Saqlash",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static final _storage = FirebaseStorage.instance.ref();

  static final _folder = "post_image";

  static Future<String> uploadImage(File file) async {
    String image_name = "image_${DateTime.now()}";
    var firebaseStorage = _storage.child(_folder).child(image_name);
    var uploadTask = firebaseStorage.putFile(file);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});

    String downloadUrl = await firebaseStorage.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }
}

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';

import '../api/Firebase.dart';

class ImageController extends ChangeNotifier {
  File _image = File('');
  final _picker = ImagePicker();
  UploadTask? task;
  File get image => _image;
  set image(File value) {
    _image = value;
    notifyListeners();
  }

  Future<void> selectImage() async {
    final result = await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    if (result == null) return;
    final path = result.path;

    image = File(path);
  }

  Future<String> uploadImage(File image) async {
    if (image == null) return '';

    final fileName = basename(image.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, image);

    if (task == null) return '';

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    return urlDownload;
  }
}

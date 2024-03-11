import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  File? photo;
  final ImagePicker imagePicker = ImagePicker();
  Future imgFromGallery() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    photo = File(pickedFile?.path ?? '');
    uploadFile();
  }

  Future imgFromCamera() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    photo = File(pickedFile?.path ?? '');
    uploadFile();
  }

  Future uploadFile() async {
    if (photo == null) {
      return;
    }
    final fileName = basename(photo?.path ?? '');

    try {
      final ref = _firebaseStorage.ref().child(fileName);
      await ref.putFile(photo!);
      final url = await ref.getDownloadURL();
      log('url is $url');
    } catch (e) {
      log('error is $e');
    }
  }
}

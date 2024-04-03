import 'dart:developer';
import 'dart:io';

import 'package:firebase_demo3/core/models/user_model.dart';
import 'package:firebase_demo3/core/services/database_service.dart';
import 'package:firebase_demo3/core/viewmodels/base_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateProfileViewModel extends BaseModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String image = '';
  List gender = ["Male", "Female"];
  String select = '';
  String uid = "";

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  File? photo;
  final ImagePicker imagePicker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      updateUI();
    } else {
      debugPrint('No image selected.');
    }
  }

  Future imgFromCamera() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      updateUI();
    } else {
      debugPrint('No image selected.');
    }
  }

  changeGender(String gender) {
    select = gender;
    updateUI();
  }

  permissionForGallery(BuildContext context) async {
    PermissionStatus galleryStatus =
        await Permission.accessMediaLocation.request();
    if (galleryStatus == PermissionStatus.granted) {
      imgFromGallery();
    }

    if (galleryStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  permissionForCamera(BuildContext context) async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    if (cameraStatus == PermissionStatus.granted) {
      imgFromCamera();
    }

    if (cameraStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  Future uploadFile() async {
    if (photo == null) {
      return;
    }
    final fileName = basename(photo?.path ?? '');
    image = fileName;
    log('filename $fileName');
    log('photo $photo');
    try {
      final ref = _firebaseStorage.ref().child('/images').child(fileName);
      await ref.putFile(photo!);
      final url = await ref.getDownloadURL();
      debugPrint('url is $url');
    } catch (e) {
      debugPrint('error is $e');
    }
  }

  Future<UserModel> getData(String id) async {
    return await DataBaseService().getUpdatedUserData(id);
  }

  void updateProfile(String uid) async {
    String email = emailController.text;
    String name = nameController.text;
    String phoneNo = phoneNoController.text;
    String pass = passController.text;

    if (formKey.currentState?.validate() ?? false) {
      uploadFile();
      await DataBaseService(uid: uid).updateUserDetails(UserModel(
          uid: uid,
          email: email,
          name: name,
          phoneNo: phoneNo,
          image: image,
          pass: pass,
          gender: select));
      updateUI();
    }
  }
}

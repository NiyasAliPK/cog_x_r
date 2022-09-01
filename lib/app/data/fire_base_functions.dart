import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cog_x_r/app/data/local_database.dart';
import 'package:cog_x_r/app/data/models/profile_details_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FireBaseController extends GetxController {
  final HiveController _hiveController = Get.put(HiveController());
  int doneCount = 0;
  final profilesCollection = FirebaseFirestore.instance.collection('Profiles');
  List<ProfileModel> firebaseList = [];
  UploadTask? _uploadTask;
  String? urlDownload;

//UPLOAD PROFILES TO FIREBASE FROM LOCAL DATABASE//
  uploadToFireBase() async {
    doneCount = 0;

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      Get.snackbar('Oops',
          'There is no internet connection. Please connect to internet and try again.');
      return;
    }

    if (_hiveController.allProfileList.isEmpty) {
      Get.snackbar('Oops',
          'There is no profiles to upload to firebase. Please add some and try again.',
          isDismissible: true);
      return;
    }
    Get.defaultDialog(
        barrierDismissible: false,
        title: 'Uploading',
        content: GetBuilder<FireBaseController>(builder: (cont) {
          return Text(
              "Please wait... ${cont.doneCount.toString()}/${_hiveController.allProfileList.length} completed.");
        }));
    try {
      for (var element in _hiveController.allProfileList) {
        final id = DateTime.now().microsecondsSinceEpoch.toString();
        await imageToFirebase(paths: element.path);
        final data = {
          'name': element.name,
          'gender': element.gender,
          'age': element.age,
          'path': urlDownload
        };
        await profilesCollection.doc(id).set(data);
        doneCount++;
        update();
      }
    } catch (e) {
      Get.snackbar('Oops',
          'Somthing went wrong please try again... error code${e.hashCode}');
    }
    await _hiveController.clearHiveDataBase();
    Get.back();
  }

// GET ALL PROFILES FROM FIREBASE //
  Future<List<ProfileModel>> getAllDataFromFireBase() async {
    try {
      firebaseList.clear();
      final data = await profilesCollection.get();
      firebaseList.clear();
      if (data.docs.isNotEmpty) {
        Get.defaultDialog(
            title: 'Loading...', content: LinearProgressIndicator());
        await Future.delayed(Duration(milliseconds: 1500));
      }
      for (var element in data.docs) {
        final temp = ProfileModel(
            name: element['name'],
            gender: element['gender'],
            age: element['age'],
            path: element['path']);
        firebaseList.add(temp);
      }
    } catch (e) {
      Get.snackbar('Oops',
          'Somthing went wrong please try again... error code ${e.hashCode}');
    }
    Get.back();
    return firebaseList;
  }

  imageToFirebase({required String paths}) async {
    final file = 'images/${paths.substring(38)}';
    log(file);
    final path = File(paths);
    final ref = FirebaseStorage.instance.ref().child(file);
    _uploadTask = ref.putFile(path);
    final snapshot = await _uploadTask!.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();
  }
}

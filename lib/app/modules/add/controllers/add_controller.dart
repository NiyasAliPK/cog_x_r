import 'dart:convert';
import 'dart:io';

import 'package:cog_x_r/app/data/local_database.dart';
import 'package:cog_x_r/app/data/models/profile_details_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddController extends GetxController {
  List<String> items = ['Male', 'Female', 'Other'];
  String dropdownvalue = 'Male';
  String img = '';
  String? path;
  final HiveController _hiveController = Get.put(HiveController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  changeDropDownValue(String value) {
    dropdownvalue = value;
    update();
  }

  pickimage() async {
    img = '';
    path = '';
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) {
      img = '';
      update();
      return;
    } else {
      final bytes = File(pickedImage.path).readAsBytesSync();
      img = base64Encode(bytes);
      path = pickedImage.path;
    }

    update();
  }

  validation() async {
    if (nameController.text.isEmpty) {
      Get.snackbar('Alert', "Please enter a proper name", isDismissible: true);
      return;
    } else if (ageController.text.isEmpty) {
      Get.snackbar('Alert', 'Please eneter age', isDismissible: true);
      return;
    } else if (img == '') {
      Get.snackbar('Alert', 'Please add a profile picture',
          isDismissible: true);
      return;
    }
    final newProfile = ProfileModel(
        name: nameController.text,
        gender: dropdownvalue,
        age: int.parse(ageController.text),
        image: img,
        path: path!);
    await _hiveController.addToDataBase(newProfile);
    nameController.clear();
    ageController.clear();
    img = '';
    update();
    Get.snackbar('Success', 'Profile added successfully');
  }
}

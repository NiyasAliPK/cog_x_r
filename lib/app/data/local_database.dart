import 'package:cog_x_r/app/data/models/profile_details_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class HiveController extends GetxController {
  List<ProfileModel> allProfileList = [];

  //GET ALL DATA FROM HIVE
  getAllData() async {
    final hiveDb = await Hive.openBox<ProfileModel>('profile_db');
    allProfileList.clear();
    allProfileList.addAll(hiveDb.values);
    update();
  }

  //ADD DATA TO HIVE
  addToDataBase(ProfileModel value) async {
    final hiveDb = await Hive.openBox<ProfileModel>('profile_db');
    int id = await hiveDb.add(value);
    value.id = id;
    await hiveDb.put(value.id, value);
    await getAllData();
  }

  //TO CLEAR HIVE AFTER UPLOADING TO FIREBASE
  clearHiveDataBase() async {
    final hiveDb = await Hive.openBox<ProfileModel>('profile_db');
    await hiveDb.clear();
    allProfileList.clear();
    update();
  }
}

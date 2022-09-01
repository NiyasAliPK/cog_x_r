import 'package:cog_x_r/app/data/local_database.dart';
import 'package:cog_x_r/app/data/models/profile_details_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'app/routes/app_pages.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  final HiveController hiveController = Get.put(HiveController());
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(ProfileModelAdapter().typeId)) {
    Hive.registerAdapter(ProfileModelAdapter());
  }
  await hiveController.getAllData();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
  await Future.delayed(Duration(milliseconds: 1500));
  FlutterNativeSplash.remove();
}

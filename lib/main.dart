import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task_app/app/routes/app_pages.dart';

void main() {
  runApp(ScreenUtilInit(
      designSize: const Size(414, 716),
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Application",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      }));
}

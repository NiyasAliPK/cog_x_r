import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final LoginController _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('LoginView'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.sp),
          child: SafeArea(
              child: ListView(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  contentPadding: EdgeInsets.all(15.h),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 3),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: EdgeInsets.all(15.h),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 3),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await _loginController.loginVerification();
                  },
                  child: Text('Login'))
            ],
          )),
        ));
  }
}

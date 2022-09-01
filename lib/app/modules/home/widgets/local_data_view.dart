import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/local_database.dart';

class LocalDataView extends StatelessWidget {
  LocalDataView({Key? key}) : super(key: key);
  final HiveController _hiveController = Get.put(HiveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<HiveController>(builder: (_) {
      return _hiveController.allProfileList.isEmpty
          ? Center(
              child: Text(
                "Please add new profiles",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.separated(
              itemCount: _hiveController.allProfileList.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 15);
              },
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_hiveController.allProfileList[index].name),
                  subtitle: Text(_hiveController.allProfileList[index].gender),
                  trailing: Text(
                      _hiveController.allProfileList[index].age.toString()),
                  leading: CircleAvatar(
                    backgroundImage: MemoryImage(Base64Decoder()
                        .convert(_hiveController.allProfileList[index].image!)),
                  ),
                );
              },
            );
    }));
  }
}

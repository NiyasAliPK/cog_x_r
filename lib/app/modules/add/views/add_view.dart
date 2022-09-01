import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_controller.dart';

class AddView extends GetView<AddController> {
  final SizedBox spacer = SizedBox(height: 20);
  final AddController _addController = Get.put(AddController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back, color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Add Profile',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
              child: ListView(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              GetBuilder<AddController>(builder: (_) {
                return _addController.img == ''
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/profile-image.png'),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage: _addController.img == ''
                            ? null
                            : MemoryImage(
                                Base64Decoder().convert(_addController.img)),
                      );
              }),
              IconButton(
                  onPressed: () async {
                    await _addController.pickimage();
                  },
                  icon: Icon(Icons.camera))
            ]),
            spacer,
            TextField(
              controller: _addController.nameController,
              decoration: const InputDecoration(
                label: Text('Name'),
                border: OutlineInputBorder(),
              ),
            ),
            spacer,
            TextField(
              controller: _addController.ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text('Age'),
                border: OutlineInputBorder(),
              ),
            ),
            spacer,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Gender', style: TextStyle(fontSize: 17)),
                    GetBuilder<AddController>(builder: (_) {
                      return DropdownButton<String>(
                        value: _addController.dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: _addController.items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          _addController.changeDropDownValue(newValue!);
                        },
                      );
                    }),
                  ]),
            ),
            SizedBox(height: 50),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  _addController.validation();
                },
                child: Text('Save'),
                style: ElevatedButton.styleFrom(primary: Colors.black),
              ),
            )
          ])),
        ));
  }
}

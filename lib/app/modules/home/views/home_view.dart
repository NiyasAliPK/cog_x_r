import 'package:cog_x_r/app/data/fire_base_functions.dart';
import 'package:cog_x_r/app/modules/add/views/add_view.dart';
import 'package:cog_x_r/app/modules/home/widgets/firebase_view.dart';
import 'package:cog_x_r/app/modules/home/widgets/local_data_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final HomeController _controller = Get.put(HomeController());

  final FireBaseController _fireBaseController = Get.put(FireBaseController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _controller.pageIndex,
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                bottom: TabBar(
                  isScrollable: false,
                  indicatorColor: Colors.black,
                  onTap: (value) {
                    _controller.changeIndex(value);
                  },
                  tabs: [
                    Tab(
                      text: 'Local Storage',
                    ),
                    Tab(text: 'FireBase')
                  ],
                  labelColor: Colors.black,
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              preferredSize: Size(100, 50)),
          floatingActionButton: GetBuilder<HomeController>(builder: (_) {
            return _controller.pageIndex == 1
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        backgroundColor: Colors.black,
                        heroTag: 'button_one',
                        onPressed: () {
                          Get.to(
                              transition: Transition.leftToRight,
                              () => AddView());
                        },
                        child: Icon(Icons.add),
                      ),
                      SizedBox(width: 10),
                      FloatingActionButton(
                        backgroundColor: Colors.black,
                        heroTag: 'button_two',
                        onPressed: () async {
                          await _fireBaseController.uploadToFireBase();
                        },
                        child: Icon(Icons.upload),
                      )
                    ],
                  );
          }),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
                child: TabBarView(children: [LocalDataView(), FirebaseView()])),
          )),
    );
  }
}

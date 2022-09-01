import 'package:cog_x_r/app/data/fire_base_functions.dart';
import 'package:cog_x_r/app/data/models/profile_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseView extends StatelessWidget {
  FirebaseView({Key? key}) : super(key: key);

  final FireBaseController _fireBaseController = Get.put(FireBaseController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
          child: FutureBuilder<List<ProfileModel>>(
        future: _fireBaseController.getAllDataFromFireBase(),
        initialData: _fireBaseController.firebaseList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _fireBaseController.firebaseList.isEmpty
              ? Center(
                  child: Text('No profiles has been uploaded to firebase',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                )
              : ListView.separated(
                  itemCount: _fireBaseController.firebaseList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 15);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(_fireBaseController.firebaseList[index].name),
                      subtitle:
                          Text(_fireBaseController.firebaseList[index].gender),
                      trailing: Text(_fireBaseController.firebaseList[index].age
                          .toString()),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            _fireBaseController.firebaseList[index].path),
                      ),
                    );
                  },
                );
        },
      )),
    );
  }
}

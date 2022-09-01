import 'package:hive_flutter/hive_flutter.dart';
part 'profile_details_model.g.dart';

@HiveType(typeId: 1)
class ProfileModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String gender;
  @HiveField(2)
  final int age;
  @HiveField(3)
  int? id;
  @HiveField(4)
  final String? image;
  @HiveField(5)
  final String path;

  ProfileModel(
      {required this.name,
      required this.gender,
      required this.age,
      this.id,
      this.image,
      required this.path});
}

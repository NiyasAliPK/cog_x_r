import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final client = http.Client();
  var uri = Uri.parse('https://reqres.in/api/login');

  loginVerification() async {
    final response = await client.post(uri,
        body: ({'email': "eve.holt@reqres.in", 'password': "cityslica"}));
    log(response.statusCode.toString());
  }
}

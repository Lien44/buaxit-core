import 'dart:convert';

import 'package:bauxite_admin_app/models/user_model.dart';
import 'package:bauxite_admin_app/pages/login.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:get/get.dart';

class ProfileState extends GetxController {
  Repository rep = Repository();
  UserModel? userModel;
  bool check = false;
  //test
  checkToken() {
    if (rep.appVerification.token == '') {
    } else {
      getUserInformation();
    }
  }

  getUserInformation() async {
    try {
      var res = await rep.get(url: rep.urlApi + rep.user, auth: true);

      if (res.statusCode == 200) {
        userModel = UserModel.fromJson(jsonDecode(res.body));
      } else {
        Get.offAll(() => const LoginPage());
        rep.appVerification.removeToken();
      }
      check = true;
    } catch (e) {
      Get.offAll(() => const LoginPage());
      rep.appVerification.removeToken();
    }

    update();
  }

  @override
  void onReady() {
    checkToken();
    super.onReady();
  }
}

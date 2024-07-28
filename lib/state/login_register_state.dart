import 'dart:convert';

import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/pages/dashboard_page.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginRegisterState extends GetxController {
  int indexPage = 0;
  Repository rep = Repository();
  bool checkLogin = false;
  bool checkRegister = false;
  setIndexPage(int page) {
    indexPage = page;
    update();
  }

  login({
    required BuildContext context,
    required String phone,
    required String password,
  }) async {
    CustomDialogs().dialogLoading();
    try {
      var res = await rep.post(
        url: rep.urlApi + rep.login,
        body: {
          'phone': phone,
          'password': password,
        },
      );
      if (res.statusCode == 200) {
        if (jsonDecode(res.body)['user'].toString() == "null") {
          Get.back();
          return CustomDialogs().dialogShowMessage(message: 'something_wrong');
        }
        Get.back();
        if (jsonDecode(res.body)['user']['role_id'] != 4) {
          await rep.appVerification.setNewToken(
              text: jsonDecode(res.body)['token'],
              role: jsonDecode(res.body)['user']["role_id"].toString());
          Get.off(() => DashboardPage(), transition: Transition.rightToLeft);
        } else {
          checkLogin = false;
          CustomDialogs().dialogShowMessage(
              message: "ເບີໂທ ຫຼື ລະຫັດຜ່ານ ບໍ່ຖືກຕ້ອງ! ກະລຸນາລອງໃຫມ່...");
        }
      } else if (res.statusCode == 201) {
        Get.back();
        checkLogin = false;
        CustomDialogs().dialogShowMessage(
            message: jsonDecode(res.body)['message'].toString());
      } else {
        Get.back();
        checkLogin = false;
        CustomDialogs().dialogShowMessage(
            message: 'ເບີໂທ ຫຼື ລະຫັດຜ່ານ ບໍ່ຖືກຕ້ອງ! ກະລຸນາລອງໃຫມ່...');
      }
    } catch (e) {
      Get.back();
      CustomDialogs().dialogShowMessage(
          message: 'ເບີໂທ ຫຼື ລະຫັດຜ່ານ ບໍ່ຖືກຕ້ອງ! ກະລຸນາລອງໃຫມ່...');
    }
    update();
  }
}

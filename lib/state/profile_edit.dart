import 'dart:convert';

import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/models/user_model.dart';
import 'package:bauxite_admin_app/services/app_verification.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileEditState extends GetxController {
  Repository rep = Repository();
  AppVerification appVerification = Get.put(AppVerification());
  // List<UserModel> userList = [];
  bool check = false;
  UserModel? userModel;
  checkToken() {
    if (appVerification.token == '') {
    } else {
      getProfile();
    }
  }

  getProfile() async {
    try {
      check = false;
      var res = await rep.get(url: rep.urlApi + rep.getprofile, auth: true);
      userModel = null;
      update();
      if (res.statusCode == 200) {
        userModel = UserModel.fromJson(jsonDecode(res.body)['data']);
      } else {
        throw res.body;
      }
    } catch (e) {
      print(e.toString());
    }
    check = true;
    update();
  }

  Future<void> profileEdit(
      String? nameT, String? phoneT, String? passT, String? confT) async {
    if (passT != confT) {
      // Password and confirmation mismatch
      await CustomDialogs().dialogShowMessage(
        message: 'ລະຫັດຜ່ານຍືນຍັນບໍ່ຕົງກັນ!',
        icon: Icons.error_outline,
      );
      return;
    }

    try {
      CustomDialogs().dialogLoading();

      var res = await rep.post(
        url: rep.urlApi + rep.editProfile,
        auth: true,
        body: {
          'name': nameT ?? '',
          'phone': phoneT ?? '',
          'new_password': passT ?? '',
          'confirm_password': confT ?? '',
        },
      );

      if (res.statusCode == 200) {
        await CustomDialogs().dialogShowMessage(
          message: jsonDecode(res.body)['message'],
          icon: Icons.check,
        );
        Get.back(result: true);
      } else if (res.statusCode == 402) {
        await CustomDialogs().dialogShowMessage(
          message: jsonDecode(res.body)['message'],
          icon: Icons.error_outline,
        );
        Get.back(result: false);
      } else {
        // Handle other error cases
        throw Exception(
            'ບາງຢ່າງຜິດພາດລອງອີກຄັ້ງ. Status code: ${res.statusCode}');
      }
    } catch (e) {
      // Handle exceptions or unexpected errors
      print('Error: $e');
    // await CustomDialogs().showToast(text: 'ມີບາງຢ່າງຜິດພາດ!');
      Get.back(result: false);
    }
  }

// profileEdit(String? nameT, String? phoneT, String? passT, String? confT) async {
//   try {
//     CustomDialogs().dialogLoading();

//     var res = await rep.post(
//       url: rep.urlApi + rep.editProfile,
//       auth: true,
//       body: {
//         'name': nameT.toString(),
//         'phone': phoneT.toString(),
//         'password': passT.toString(),
//       },
//     );

//     if (res.statusCode == 200) {
//       // Successful response
//       await CustomDialogs().dialogShowMessage(
//         message: jsonDecode(res.body)['message'],
//         icon: Icons.check,
//       );
//       Get.back(result: true);
//     } else if (res.statusCode == 402) {
//       // Handle specific error code
//       await CustomDialogs().dialogShowMessage(
//         message: jsonDecode(res.body)['message'],
//         icon: Icons.error_outline,
//       );
//       Get.back(result: false);
//     } else {
//       // Handle other error cases
//       throw res.body;
//     }
//   } catch (e) {
//     // Handle exceptions or unexpected errors
//     print('Error: $e');
//     // await CustomDialogs().showToast(text: 'ມີບາງຢ່າງຜິດພາດ!');
//     Get.back(result: false);
//   }
// }
}

import 'dart:convert';

import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/models/chauffer_model.dart';
import 'package:bauxite_admin_app/models/user_model.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserSettingState extends GetxController {
  Repository rep = Repository();
  List<UserModel> userList = [];
  List<ChaufferModel> chaufferList = [];
  bool check = false;

  getUserByRole(String roleId) async {
    try {
      check = false;
      var res = await rep.get(
          url: rep.urlApi + rep.getUserByRole + roleId, auth: true);
      userList = [];
      if (res.statusCode == 200) {
        for (var element in jsonDecode(res.body)['data']) {
          userList.add(UserModel.fromJson(element));
        }
      } else {
        throw res.body;
      }
    } catch (e) {
      // print(e.toString());
    }
    check = true;
    update();
  }

  addUser(BuildContext context, UserModel userModel) async {
    try {
      check = false;
      CustomDialogs().dialogLoading();
      var res = await rep.post(
          url: rep.urlApi + rep.addUser, auth: true, body: userModel.toJson());
      Get.back();
      if (res.statusCode == 200) {
        // ignore: use_build_context_synchronously
        CustomDialogs().showToast(
            context: context,
            backgroundColor: AppColors().mainColor.withOpacity(0.5),
            text: 'add_success');
        Get.back(result: true);
      } else if (res.statusCode == 201) {
        // ignore: use_build_context_synchronously
        CustomDialogs().showToast(
            context: context,
            backgroundColor: AppColors().mainColor.withOpacity(0.5),
            text: 'ເບີໂທນີ້ມີຢູ່ໃນລະບົບແລ້ວ!');
        Get.back(result: true);
      } else {
        throw res.body;
      }
    } catch (e) {
      CustomDialogs().showToast(
          context: context,
          backgroundColor: AppColors().mainColor.withOpacity(0.5),
          text: 'ມີບາງຢ່າງຜິດພາດ');
      // print(e.toString());
    }
    check = true;
    update();
  }

  editUser(BuildContext context, UserModel userModel) async {
    try {
      CustomDialogs().dialogLoading();
      var res = await rep.post(
          url: rep.urlApi + rep.editUser, auth: true, body: userModel.toJson());
      Get.back();
      if (res.statusCode == 200) {
        // ignore: use_build_context_synchronously
        CustomDialogs().showToast(
            context: context,
            backgroundColor: AppColors().mainColor.withOpacity(0.5),
            text: 'edit_success');
        Get.back(result: true);
      } else {
        throw res.body;
      }
    } catch (e) {
      CustomDialogs().showToast(
          context: context,
          backgroundColor: AppColors().mainColor.withOpacity(0.5),
          text: 'something_went_wrong');
      // print(e.toString());
    }

    update();
  }

  deleteUser(BuildContext context, UserModel userModel) async {
    try {
      CustomDialogs().dialogLoading();
      var res = await rep.put(
        url: rep.urlApi + rep.deleteUser + userModel.id.toString(),
        auth: true,
      );
      Get.back();
      if (res.statusCode == 200) {
        // ignore: use_build_context_synchronously
        CustomDialogs().showToast(
            context: context,
            backgroundColor: AppColors().mainColor.withOpacity(0.5),
            text: 'delete_success');
        Get.back(result: true);
      } else {
        throw res.body;
      }
    } catch (e) {
      CustomDialogs().showToast(
          context: context,
          backgroundColor: AppColors().mainColor.withOpacity(0.5),
          text: 'something_went_wrong');
      // print(e.toString());
    }

    update();
  }

  // for chauffer
  getChauffer() async {
    try {
      check = false;
      var res = await rep.get(url: rep.urlApi + rep.getChauffer, auth: true);
      chaufferList = [];
      if (res.statusCode == 200) {
        for (var element in jsonDecode(res.body)['data']) {
          chaufferList.add(ChaufferModel.fromJson(element));
        }
      } else {
        throw res.body;
      }
    } catch (e) {
      //  print(e.toString());
    }
    check = true;
    update();
  }

  addChauffer(BuildContext context, ChaufferModel chaufferModel) async {
    try {
      check = false;
      CustomDialogs().dialogLoading();
      var res = await rep.post(
          url: rep.urlApi + rep.addChauffer,
          auth: true,
          body: chaufferModel.toJson());
      Get.back();

      if (res.statusCode == 200) {
        // ignore: use_build_context_synchronously
        CustomDialogs().showToast(
            context: context,
            backgroundColor: AppColors().mainColor.withOpacity(0.5),
            text: 'add_success');
        Get.back(result: true);
      } else {
        throw res.body;
      }
    } catch (e) {
      CustomDialogs().showToast(
          context: context,
          backgroundColor: AppColors().mainColor.withOpacity(0.5),
          text: 'something_wrong');
    }
    check = true;
    update();
  }

  editChauffer(BuildContext context, ChaufferModel chaufferModel) async {
    try {
      CustomDialogs().dialogLoading();
      var res = await rep.post(
          url: rep.urlApi + rep.editChauffer,
          auth: true,
          body: chaufferModel.toJson());
      Get.back();

      if (res.statusCode == 200) {
        // ignore: use_build_context_synchronously
        CustomDialogs().showToast(
            context: context,
            backgroundColor: AppColors().mainColor.withOpacity(0.5),
            text: 'edit_success');
        Get.back(result: true);
      } else {
        throw res.body;
      }
    } catch (e) {
      CustomDialogs().showToast(
          context: context,
          backgroundColor: AppColors().mainColor.withOpacity(0.5),
          text: 'something_wrong');
    }

    update();
  }

  deleteChauffer(BuildContext context, ChaufferModel chaufferModel) async {
    try {
      CustomDialogs().dialogLoading();
      var res = await rep.put(
        url: rep.urlApi + rep.deleteChauffer + chaufferModel.id.toString(),
        auth: true,
      );
      Get.back();
      if (res.statusCode == 200) {
        CustomDialogs().showToast(
            context: context,
            backgroundColor: AppColors().mainColor.withOpacity(0.5),
            text: 'delete_success');
        Get.back(result: true);
      } else {
        throw res.body;
      }
    } catch (e) {
      CustomDialogs().showToast(
          context: context,
          backgroundColor: AppColors().mainColor.withOpacity(0.5),
          text: 'something_went_wrong');
    }

    update();
  }
}

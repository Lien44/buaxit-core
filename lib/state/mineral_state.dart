// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:bauxite_admin_app/models/mineral_model.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../customs/custom_dialog.dart';

class MineralState extends GetxController {
  AppColors appColors = AppColors();
  bool check = false;
  Repository rep = Repository();
  List<MineralModel> mineralList = [];
  MineralModel? selectMineral;
  selectMineralData(MineralModel newSelect) {
    selectMineral = newSelect;
    update();
  }

  getData() async {
    try {
      check = false;
      update();
      var res = await rep.get(url: rep.urlApi + rep.mineral, auth: true);
      mineralList = [];
      if (res.statusCode == 200) {
        for (var element in jsonDecode(res.body)['data']) {
          mineralList.add(MineralModel.fromJson(element));
        }
      } else {
        throw res.body;
      }
    } catch (e) {
//
    }
    check = true;
    update();
    if(mineralList.isNotEmpty){
      selectMineral =  mineralList.firstWhere((element) => element.id == 2);
      update();
    }
  }

  addMineral(
      {required BuildContext context,
      required String name,
      required String address}) async {
    try {
      check = false;
      CustomDialogs().dialogLoading();
      var res = await rep.post(
          url: rep.urlApi + rep.addmineral,
          auth: true,
          body: {'name': name.toString(), 'address': address.toString()});
      Get.back();
      if (res.statusCode == 200) {
        CustomDialogs().showToast(
            context: context,
            backgroundColor: appColors.mainColor.withOpacity(0.5),
            text: 'add_success');
        Get.back(result: true);
      } else {
        throw res.body;
      }
    } catch (e) {
      CustomDialogs().showToast(
          context: context,
          backgroundColor: appColors.mainColor.withOpacity(0.5),
          text: 'something_went_wrong');
    }
    check = true;
    update();
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/models/scan_out_model.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:bauxite_admin_app/state/camera_scan_page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../pages/scan_out.dart';

class SearchScanOut extends GetxController {
  AppColors appColors = AppColors();
  final CameraScanPageState cameraScanPageState =
      Get.put(CameraScanPageState());
  bool check = false;
  Repository rep = Repository();
  searchscanoutCar(BuildContext context, String search) async {
    try {
      var res = await rep.post(
          url: rep.urlApi + rep.searchscanoutCar,
          auth: true,
          body: {'search': search.toString()});
      if (res.statusCode == 200) {
        cameraScanPageState.setscanOutModel(
            ScanOutModel.fromJson(jsonDecode(res.body)['scan_detail']));
        Get.to(() => const ScanOutPage());
      } else if (res.statusCode == 405) {
        CustomDialogs().showToast(
            bottom: 500,
            context: context,
            backgroundColor: appColors.mainColor.withOpacity(0.5),
            text: jsonDecode(res.body)['message']);
      } else {
        throw res.body;
      }
    } catch (e) {
//
    }
    update();
  }
}

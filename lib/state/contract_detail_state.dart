// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/models/contract_detail_model.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContractDetailState extends GetxController {
  Repository rep = Repository();
  ContractDetailModel? contractDetailModel;
  bool check = false;
  Future<void> setContractIdAndInitData({
    required String contractId,
  }) async {
    check = false;
    update();
    try {
      var res = await rep.get(
        url: rep.urlApi + rep.getAllScanInByContractId + contractId,
        auth: true,
      );

      if (res.statusCode == 200) {
        contractDetailModel = ContractDetailModel.fromJson(
          jsonDecode(res.body),
        );
        check = true;
        update();
      } else {
        throw res.statusCode;
      }
    } catch (e) {
      check = false;
      update();
      return Future.error(e);
    }
  }

  cancelContract(
      {required BuildContext context, required String contractId}) async {
    try {
      CustomDialogs().dialogLoading();
      var res = await rep.put(
        url: rep.urlApi + rep.cancelContract + contractId,
        auth: true,
      );
      Get.back();
      if (res.statusCode == 200) {
        CustomDialogs()
            .showToast(context: context, text: 'ຍົກເລີກສັນຍາສຳເລັດ!');
        Get.back(result: true);
      } else {
        throw res.body;
      }
    } catch (e) {
      CustomDialogs().showToast(context: context, text: 'ມີບາງຢ່າງຜິດພາດ!');
    }
  }
}

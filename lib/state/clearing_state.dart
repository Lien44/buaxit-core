import 'dart:convert';

import 'package:bauxite_admin_app/models/scan_in_out_model.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:bauxite_admin_app/state/custom_date_picker_state.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ClearingState extends GetxController {
  List<ClearingSelectModel> clearingList = [];
  bool check = false;
  bool selectAll = false;
  Repository rep = Repository();
  CustomDatePickerState customDatePickerState =
      Get.put(CustomDatePickerState());
  TextEditingController servicePriceController = TextEditingController();
  getData() async {
    check = false;
    update();
    var res = await rep.post(
      url: rep.urlApi + rep.getAllScanInOut,
      auth: true,
      body: {
        'start_date':
            '${customDatePickerState.startDate?.year.toString().padLeft(2, "0")}-${customDatePickerState.startDate?.month.toString().padLeft(2, "0")}-${customDatePickerState.startDate?.day.toString().padLeft(2, "0")} 00:00:00',
        'end_date':
            '${customDatePickerState.endDate?.year.toString().padLeft(2, "0")}-${customDatePickerState.endDate?.month.toString().padLeft(2, "0")}-${customDatePickerState.endDate?.day.toString().padLeft(2, "0")} 23:59:59',
        'status': '5', // status = 5 ດຶງສະເເກນລົງສາງມາ ເຄຍລິ້ງ
      },
    );
    clearingList = [];
    if (res.statusCode == 200) {
      for (var element in jsonDecode(res.body)['data']) {
        clearingList.add(
          ClearingSelectModel(
            scanDetail: ScanInOutModel.fromJson(
              element,
            ),
          ),
        );
      }
      check = true;
      update();
    } else {
      check = false;
      update();
    }
  }

  setSelect(int index, bool newValue) {
    clearingList[index].setSelect(newValue);
    if (!newValue) {
      selectAll = false;
    }
    if (clearingList.where((element) => !element.select).isEmpty) {
      selectAll = true;
    }
    update();
  }

  setAllSelect(bool newValue) {
    selectAll = newValue;
    for (var element in clearingList) {
      element.setSelect(newValue);
    }
    update();
  }

  Future<http.Response> addClearing({required String contractId}) async {
    // contract_id, qty, total_actual_weight, actual_price, service_price, total_price
    //        scan_id_list:[scan_id]
    num actualPrice = 0.0;
    num actualWeight = 0.0;
    num servicePrice = 0.0;
    try {
      actualPrice = clearingList.where((element) => element.select).fold(
            num.parse("0.0"),
            (value, element) => (value +
                (num.parse(
                      element.scanDetail.actualWeight.toString(),
                    ) *
                    num.parse(
                      element.scanDetail.contractModel!.shippingPriceCal
                          .toString(),
                    ) /
                    num.parse(
                      element.scanDetail.contractModel!.weightPriceCal
                          .toString(),
                    ))),
          );
      actualWeight = clearingList.where((element) => element.select).fold(
            num.parse("0.0"),
            (value, element) => (value +
                num.parse(
                  element.scanDetail.actualWeight.toString(),
                )),
          );
      if (servicePriceController.text.isNotEmpty) {
        servicePrice =
            num.parse(servicePriceController.text.replaceAll(",", ""));
      }
    } catch (e) {
      return Future.error("format error");
    }

    try {
      var res = await rep.post(
        url: rep.urlApi + rep.addClearing,
        auth: true,
        body: {
          "contract_id": contractId,
          "qty":
              clearingList.where((element) => element.select).length.toString(),
          "total_actual_weight": actualWeight.toString(),
          "actual_price": actualPrice.toString(),
          "service_price": servicePrice.toString(),
          "total_price": (actualPrice + servicePrice).toString(),
          "scan_id_list": jsonEncode(
            [
              clearingList
                  .where((element) => element.select)
                  .map(
                    (e) => e.scanDetail.id.toString(),
                  )
                  .toList(),
            ],
          )
        },
      );
      return res;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}

class ClearingSelectModel {
  bool select = false;
  final ScanInOutModel scanDetail;
  ClearingSelectModel({
    required this.scanDetail,
  });
  setSelect(bool newValue) {
    select = newValue;
  }
}

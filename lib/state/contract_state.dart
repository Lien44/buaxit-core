import 'dart:convert';

import 'package:bauxite_admin_app/models/contract_model.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:bauxite_admin_app/state/company_state.dart';
import 'package:bauxite_admin_app/state/custom_date_picker_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ContractState extends GetxController {
  TextEditingController totalWeight = TextEditingController();
  TextEditingController shippingPrice = TextEditingController();
  TextEditingController weightCal = TextEditingController();
  TextEditingController note = TextEditingController();
  List<ContractModel> listContracts = [];
  Repository rep = Repository();
  CustomDatePickerState customDatePickerState =
      Get.put(CustomDatePickerState());
  CompanyState companyState = Get.put(CompanyState());
  bool check = false;

  initData(ContractModel contract) async {
    try {
      companyState.selectedCompany = companyState.companyList
          .where((element) =>
              element.id.toString() == contract.companyId?.id.toString())
          .first;
    } catch (e) {
      companyState.selectedCompany = null;
    }
    totalWeight.text = contract.totalWeight.toString();
    shippingPrice.text = contract.shippingPriceCal.toString();
    weightCal.text = contract.weightPriceCal.toString();
    note.text = contract.note ?? "";
    try {
      customDatePickerState.startDate = DateTime.parse(contract.startDate!);
      customDatePickerState.endDate = DateTime.parse(contract.endDate!);
    } catch (e) {
      customDatePickerState.startDate = null;
      customDatePickerState.endDate = null;
    }
    customDatePickerState.update();
    update();
  }

  Future<http.Response> addContract() async {
    if (totalWeight.text.isEmpty ||
        shippingPrice.text.isEmpty ||
        weightCal.text.isEmpty) {
      return Future.error("fill_info_error");
    }
    if (companyState.selectedCompany == null) {
      return Future.error("company_select_error");
    }
    if (customDatePickerState.startDate == null ||
        customDatePickerState.endDate == null) {
      return Future.error("date_error");
    }
    try {
      double.parse(totalWeight.text.replaceAll(",", ""));
      double.parse(shippingPrice.text.replaceAll(",", ""));
      double.parse(weightCal.text.replaceAll(",", ""));
    } catch (e) {
      return Future.error("invalid_format");
    }
    try {
      var res = await rep.post(
        url: rep.urlApi + rep.addContracts,
        auth: true,
        body: {
          "company_id": companyState.selectedCompany!.id.toString(),
          "total_weight":
              double.parse(totalWeight.text.replaceAll(",", "")).toString(),
          "shipping_price_cal":
              double.parse(shippingPrice.text.replaceAll(",", "")).toString(),
          "weight_price_cal":
              double.parse(weightCal.text.replaceAll(",", "")).toString(),
          "start_date": customDatePickerState
              .converToDateTimeApi(customDatePickerState.startDate!),
          "end_date": customDatePickerState
              .converToDateTimeApi(customDatePickerState.endDate!),
          "note": note.text,
        },
      );

      if (res.statusCode == 200) {
        return res;
      } else {
        return Future.error("${res.statusCode}");
      }
    } catch (e) {
      return Future.error("something_went_wrong");
    }
  }

  Future<http.Response> editContract({required String contractId}) async {
    if (totalWeight.text.isEmpty ||
        shippingPrice.text.isEmpty ||
        weightCal.text.isEmpty) {
      return Future.error("fill_info_error");
    }
    if (companyState.selectedCompany == null) {
      return Future.error("company_select_error");
    }
    if (customDatePickerState.startDate == null ||
        customDatePickerState.endDate == null) {
      return Future.error("date_error");
    }
    try {
      double.parse(totalWeight.text.replaceAll(",", ""));
      double.parse(shippingPrice.text.replaceAll(",", ""));
      double.parse(weightCal.text.replaceAll(",", ""));
    } catch (e) {
      return Future.error("invalid_format");
    }
    try {
      var res = await rep.post(
        url: rep.urlApi + rep.editContract,
        auth: true,
        body: {
          "contract_id": contractId,
          "company_id": companyState.selectedCompany!.id.toString(),
          "total_weight":
              double.parse(totalWeight.text.replaceAll(",", "")).toString(),
          "shipping_price_cal":
              double.parse(shippingPrice.text.replaceAll(",", "")).toString(),
          "weight_price_cal":
              double.parse(weightCal.text.replaceAll(",", "")).toString(),
          "start_date": customDatePickerState
              .converToDateTimeApi(customDatePickerState.startDate!),
          "end_date": customDatePickerState
              .converToDateTimeApi(customDatePickerState.endDate!),
          "note": note.text,
        },
      );

      if (res.statusCode == 200) {
        return res;
      } else {
        return Future.error("${res.statusCode}");
      }
    } catch (e) {
      return Future.error("something_went_wrong");
    }
  }

  getContracts() async {
    customDatePickerState.initData();
    try {
      check = false;
      update();
      var res = await rep.get(url: rep.urlApi + rep.getContracts, auth: true);
      listContracts = [];
      if (res.statusCode == 200) {
        for (var element in jsonDecode(res.body)['data']) {
          listContracts.add(ContractModel.fromJson(element));
        }
        check = true;
        update();
      } else {
        throw res.statusCode;
      }
    } catch (e) {
      check = false;
      update();
    }
  }

  clearData() {
    totalWeight.clear();
    shippingPrice.clear();
    weightCal.clear();
    note.clear();
    customDatePickerState.initData();
    companyState.clearSelection();
  }

  @override
  void onReady() {
    getContracts();
    super.onReady();
  }
}

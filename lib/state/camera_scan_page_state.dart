import 'dart:convert';

import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/models/chauffer_model.dart';
import 'package:bauxite_admin_app/models/contract_model.dart';
// ignore: library_prefixes
import 'package:bauxite_admin_app/models/scan_in_out_model.dart' as scanMOdel;
import 'package:bauxite_admin_app/models/scan_out_model.dart';
import 'package:bauxite_admin_app/pages/sacn_in_select_contract.dart';
import 'package:bauxite_admin_app/pages/scan_down_warehouse.dart';
import 'package:bauxite_admin_app/pages/scan_out.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:bauxite_admin_app/state/car_state.dart';
import 'package:bauxite_admin_app/state/custom_date_picker_state.dart';
import 'package:bauxite_admin_app/state/scan_history_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CameraScanPageState extends GetxController {
  AppColors appColors = AppColors();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Repository rep = Repository();
  Barcode? barcode;
  QRViewController? controller;
  ChaufferModel? chaufferModel;
  CarModel? carModel;
  List<ContractModel> listContracts = [];
  CarState carState = Get.put(CarState());
  ScanOutModel? scanOutModel;
  ScanOutModel? checkScanOut;
  ScanOutModel? checkScanDownWareHouse;
  CustomDatePickerState customDatePickerState =
      Get.put(CustomDatePickerState());
  ScanHistoryState scanHistoryState = Get.put(ScanHistoryState());
  Future<http.Response> scanIn(
      {required String contractId, required String carId, d}) async {
    try {
      var res = await rep.post(url: rep.urlApi + rep.scanIn, auth: true, body: {
        "contract_id": contractId,
        // "chauffer_id": chaufferModel!.id.toString(),
        "car_id": carId,
        "car_weight":
            double.parse(carState.weightT.text.replaceAll(',', "")).toString(),
        "created_at": customDatePickerState
            .converToDateTimeApi(customDatePickerState.startDate!),
      });
      if (res.statusCode == 200) {
        return res;
      } else {
        throw res.statusCode;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> updateBarCode(Barcode newBarCode) async {
    chaufferModel = null;
    barcode = newBarCode;
    return;
  }

  Future<http.Response> getCarByCode() async {
    if (barcode == null) {
      return Future.error("empty_barcode");
    }
    try {
      var res = await rep.get(
        url: rep.urlApi + rep.getcarByCode + barcode!.code.toString(),
        auth: true,
      );
      print(res.body);
      carModel = null;
      listContracts = [];
      if (res.statusCode == 200) {
        carModel = CarModel.fromJson(
          jsonDecode(res.body)['data'],
        );
        for (var element in jsonDecode(res.body)['contracts']) {
          listContracts.add(
            ContractModel.fromJson(element),
          );
        }
        update();
        return res;
      } else if (res.statusCode == 405) {
        return res;
      } else {
        return throw res.statusCode;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

// ========== for scan out ========= //
  Future<http.Response> getChaufferByCodeForScanOut() async {
    if (barcode == null) {
      return Future.error("empty_barcode");
    }
    try {
      var res = await rep.get(
        url: rep.urlApi +
            rep.getChaufferByCodeForScanOut +
            barcode!.code.toString(),
        auth: true,
      );
      chaufferModel = null;
      scanOutModel = null;
      listContracts = [];

      if (res.statusCode == 200) {
        // chaufferModel = ChaufferModel.fromJson(
        //   jsonDecode(res.body)['data'],
        // );
        scanOutModel =
            ScanOutModel.fromJson(jsonDecode(res.body)['scan_detail']);

        update();
        return res;
      } else if (res.statusCode == 405) {
        return res;
      } else {
        return throw res.statusCode;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  setscanOutModel(ScanOutModel v) {
    scanOutModel = v;
    update();
    if (scanOutModel != null) {
      Get.off(() => const ScanOutPage());
    }
  }

  Future<http.Response> scanOut(
      {required String code,
      required String totalWeight,
      required String mineralId,
      required String metalWeight,
      required String actualWeight}) async {
    try {
      CustomDialogs().dialogLoading();
      var res =
          await rep.post(url: rep.urlApi + rep.scanOut, auth: true, body: {
        'code': code,
        'total_weight': totalWeight,
        'mineral_id': mineralId,
        'metal_weight': metalWeight,
        'actual_weight': actualWeight,
        'updated_at': customDatePickerState
            .converToDateTimeApi(customDatePickerState.startDate!),
      });
      Get.back();
      if (res.statusCode == 200) {
        return res;
      } else {
        throw res.body;
      }
    } catch (e) {
      return Future.error('ມີບາງຢ່າງຜິດພາດ');
    }
  }

  checkScanOutForWaiting({String? code}) async {
    if (code == null) {
      if (scanOutModel == null) {
        return;
      }
    }

    try {
      var res = await rep.get(
        url: rep.urlApi +
            rep.checkScanOut +
            (code ?? (scanOutModel!.code.toString())),
        auth: true,
      );
      checkScanOut = null;

      if (res.statusCode == 200) {
        checkScanOut = ScanOutModel.fromJson(jsonDecode(res.body)['data']);
        update();
      } else if (res.statusCode == 202) {
        Get.back();
        CustomDialogs().dialogShowMessage(
          message: 'ຄົນຂັບໄດ້ມີການຍົກເລິກ!',
        );
      }
    } catch (e) {
      //  print(e.toString());
    }
  }

  editScanInOut(BuildContext context, String id, String totalweight,
      String carweight, String metalweight, String actualweight) async {
    try {
      CustomDialogs().dialogLoading();
      var res = await rep
          .post(url: rep.urlApi + rep.editScanInOut, auth: true, body: {
        "id": id,
        "car_weight": carweight,
        "total_weight": totalweight,
        "metal_weight": metalweight,
        "actual_weight": actualweight,
      });
      print(jsonDecode(res.body));
      Get.back();
      if (res.statusCode == 200) {
        scanHistoryState.getScanInOut();
        // ignore: use_build_context_synchronously
        CustomDialogs().showToast(
            context: context,
            backgroundColor: appColors.mainColor.withOpacity(0.5),
            text: 'edit_success');
        Get.back(result: true);
      } else {
        throw res.body;
      }
    } catch (e) {
      CustomDialogs().showToast(
          context: context,
          backgroundColor: appColors.mainColor.withOpacity(0.5),
          text: 'ມີບາງຢ່າງຜິດພາດ');
    }
    update();
  }

  searchCar(BuildContext context, String search) async {
    try {
      listContracts = [];
      update();
      var res = await rep.post(
          url: rep.urlApi + rep.searchCar,
          auth: true,
          body: {'search': search.toString()});
      if (res.statusCode == 200) {
        carState.clearcarModel();
        for (var element in jsonDecode(res.body)['contracts']) {
          listContracts.add(
            ContractModel.fromJson(element),
          );
        }
        Get.to(() => ScanInSelectContract(
            carModel:
                scanMOdel.CarModel.fromJson(jsonDecode(res.body)['data'])));
      } else if (res.statusCode == 405) {
        // ignore: use_build_context_synchronously
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

  @override
  void onClose() {
    if (controller != null) {
      controller!.dispose();
    }
    super.onClose();
  }

  // ========== for scan down ware house ========= //
  Future<http.Response> getChaufferByCodeForScanDownWareHouse() async {
    if (barcode == null) {
      return Future.error("empty_barcode");
    }
    try {
      var res = await rep.get(
        url: rep.urlApi +
            rep.getChaufferByCodeForScanDownWareHouse +
            barcode!.code.toString(),
        auth: true,
      );
      print(res.body);
      chaufferModel = null;
      scanOutModel = null;
      listContracts = [];

      if (res.statusCode == 200) {
        // chaufferModel = ChaufferModel.fromJson(
        //   jsonDecode(res.body)['data'],
        // );
        scanOutModel =
            ScanOutModel.fromJson(jsonDecode(res.body)['scan_detail']);

        update();
        return res;
      } else if (res.statusCode == 405) {
        return res;
      } else {
        return throw res.statusCode;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  setscanDownWareHouseModel(ScanOutModel v) {
    scanOutModel = v;
    update();
    if (scanOutModel != null) {
      Get.off(() => const ScanDownWarehousePage());
    }
  }

  Future<http.Response> scanDownWarehouse(
      {required String code,
      required String totalWeight,
      required String mineralId,
      required String metalWeight,
      required String actualWeight}) async {
    try {
      CustomDialogs().dialogLoading();
      var res = await rep
          .post(url: rep.urlApi + rep.scanDownWarehouse, auth: true, body: {
        'code': code,
        'mineral_id': mineralId,
        'total_weight': totalWeight,
        'metal_weight': metalWeight,
        'actual_weight': actualWeight,
        'updated_at': customDatePickerState
            .converToDateTimeApi(customDatePickerState.startDate!),
      });
      Get.back();
      print('8888888888888888888888888888888888888888888888888888');
      print(res.body);
      if (res.statusCode == 200) {
        return res;
      } else {
        throw res.body;
      }
    } catch (e, stackTrack) {
      print('9999999999999999999999999999999999999999999999999999');
      print(e.toString());
      print(stackTrack.toString());
      return Future.error('ມີບາງຢ່າງຜິດພາດ');
    }
  }

  checkScanDownWareHouseForWaiting({String? code}) async {
    if (code == null) {
      if (scanOutModel == null) {
        return;
      }
    }

    try {
      var res = await rep.get(
        url: rep.urlApi +
            rep.checkScanOut +
            (code ?? (scanOutModel!.code.toString())),
        auth: true,
      );
      checkScanDownWareHouse = null;

      if (res.statusCode == 200) {
        checkScanDownWareHouse =
            ScanOutModel.fromJson(jsonDecode(res.body)['data']);
        update();
      } else if (res.statusCode == 202) {
        Get.back();
        CustomDialogs().dialogShowMessage(
          message: 'ຄົນຂັບໄດ້ມີການຍົກເລິກ!',
        );
      }
    } catch (e) {
      //  print(e.toString());
    }
  }

  editScanDown(BuildContext context, String id, String actualweight) async {
    try {
      CustomDialogs().dialogLoading();
      var res = await rep
          .post(url: rep.urlApi + rep.editScanInOut, auth: true, body: {
        "id": id,
        "actual_weight": actualweight,
      });
      print(jsonDecode(res.body));
      Get.back();
      if (res.statusCode == 200) {
        scanHistoryState.getScanInOut();
        // ignore: use_build_context_synchronously
        CustomDialogs().showToast(
            context: context,
            backgroundColor: appColors.mainColor.withOpacity(0.5),
            text: 'edit_success');
        Get.back(result: true);
      } else {
        throw res.body;
      }
    } catch (e) {
      CustomDialogs().showToast(
          context: context,
          backgroundColor: appColors.mainColor.withOpacity(0.5),
          text: 'ມີບາງຢ່າງຜິດພາດ');
    }
    update();
  }
}

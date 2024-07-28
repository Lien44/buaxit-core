// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/models/cars_model.dart';
import 'package:bauxite_admin_app/models/contract_model.dart';
import 'package:bauxite_admin_app/models/scan_in_out_model.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../pages/sacn_in_select_contract.dart';

class CarState extends GetxController {
  final NumberFormat _formatter = NumberFormat("#,###.##", "en_US");
  AppColors appColors = AppColors();
  bool check = false;
  Repository rep = Repository();
  List<CarsModel> carsList = [];
  List<CarsModel> searchcarsList = [];
  List<CarsModel> carsListBycompany = [];
  TextEditingController weightT = TextEditingController();
    TextEditingController actualweight = TextEditingController();
  // TextEditingController metalweight = TextEditingController();
  CarsModel? selectedCar;
  CarModel? carModel;
  bool checkselectCar = false;
  bool textCheck = false;

  get metalweight => null;
  selectCars(CarsModel newSelect) {
    selectedCar = newSelect;
    update();
  }

  caculateMetalWeight(double total) {
    actualweight.text = _formatter
        .format(total - double.parse(weightT.text.toString()))
        .toString();
    // metalweight.text = _formatter
    //     .format(total - double.parse(weightT.text.toString()))
    //     .toString();
    update();
  }

  selectcarModel(CarModel data) {
    carModel = data;
    update();
  }

  clearcarModel() {
    carModel = null;
    update();
  }

  gotoScaninPage(CarModel? data) {
    if (data != null) {
      Get.to(() => ScanInSelectContract(carModel: data));
    }
  }

  getCars() async {
    try {
      check = false;
      update();
      var res = await rep.get(url: rep.urlApi + rep.getCars, auth: true);
      carsList = [];
      if (res.statusCode == 200) {
        for (var element in jsonDecode(res.body)['data']) {
          carsList.add(CarsModel.fromJson(element));
        }
      } else {
        throw res.body;
      }
    } catch (e) {
//
    }
    check = true;
    update();
  }

  addCars(BuildContext context, CarsModel carsModel) async {
    try {
      check = false;
      CustomDialogs().dialogLoading();
      var res = await rep.post(
          url: rep.urlApi + rep.addCars, auth: true, body: carsModel.toJson());
      Get.back();
      if (res.statusCode == 200) {
        CustomDialogs().showToast(
            context: context,
            backgroundColor: appColors.mainColor.withOpacity(0.5),
            text: 'add_success');
        Get.back(result: true);
      } else if (res.statusCode == 402) {
        CustomDialogs().showToast(
            context: context,
            backgroundColor: appColors.mainColor.withOpacity(0.5),
            text: jsonDecode(res.body)['message']);
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

  editCars(BuildContext context, CarsModel carsModel) async {
    try {
      check = false;
      CustomDialogs().dialogLoading();
      var res = await rep.post(
          url: rep.urlApi + rep.editCars, auth: true, body: carsModel.toJson());
      Get.back();
      if (res.statusCode == 200) {
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
          text: 'something_went_wrong');
    }
    check = true;
    update();
  }

  getCarsByCompany(String companyId) async {
    try {
      check = false;
      update();
      var res = await rep.get(
          url: rep.urlApi + rep.getCarsByCompany + companyId, auth: true);
      carsListBycompany = [];
      if (res.statusCode == 200) {
        for (var element in jsonDecode(res.body)['data']) {
          carsListBycompany.add(CarsModel.fromJson(element));
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

  deleteCar(BuildContext context, CarsModel carModel) async {
    try {
      CustomDialogs().dialogLoading();
      var res = await rep.put(
        url: rep.urlApi + rep.deleteCar + carModel.id.toString(),
        auth: true,
      );
      Get.back();
      if (res.statusCode == 200) {
        CustomDialogs().showToast(
            context: context,
            backgroundColor: appColors.mainColor.withOpacity(0.5),
            text: 'delete_success');
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

    update();
  }

  setInitCars({CarsModel? carsModel}) {
    for (var element in carsList) {
      if (element.id == carsModel?.id) {
        selectedCar = element;
        break;
      }
    }
    update();
  }

  setInitCarsByCompany({CarsModel? carsModel}) {
    for (var element in carsListBycompany) {
      if (element.id == carsModel?.id) {
        selectedCar = element;
        break;
      }
    }

    update();
  }

  @override
  void onReady() {
    getCars();
    super.onReady();
  }

  edittipNumber(
      {required BuildContext context,
      required String id,
      required String tisNumber,
      required ContractModel contractModel}) async {
    try {
      check = false;
      CustomDialogs().dialogLoading();
      var res = await rep.post(
          url: rep.urlApi + rep.editTisnumber,
          auth: true,
          body: {'id': id, 'tis_number': tisNumber});
      Get.back();
      if (res.statusCode == 200) {
        carModel = CarModel.fromJson(jsonDecode(res.body)['data']);
        Get.back(result: true);
      } else {
        throw res.body;
      }
    } catch (e) {
      // print(e);
      CustomDialogs().showToast(
          context: context,
          backgroundColor: appColors.mainColor.withOpacity(0.5),
          text: 'ມີບາງຢ່າງຜິດພາດ');
    }
    check = true;
    update();
  }

  clearsearchCar() {
    searchcarsList = [];
    update();
  }
}

import 'dart:convert';

import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/models/land_model.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LandState extends GetxController {
  LandState({this.useInit = true});
  final bool useInit;

  Repository repository = Repository();
  List<ProvinceModel> allProvinces = [];
  List<DistrictsModel> allDistricts = [];
  List<VillagesModel> allVillages = [];

  List<ProvinceModel> allProvincesOnly = [];
  List<DistrictsModel> allDistrictsOnly = [];
  List<VillagesModel> allVillagesOnly = [];

  ProvinceModel? provinceSelect;
  DistrictsModel? districtSelect;
  VillagesModel? villageSelect;

  //for check when fecth data from database
  bool checkDataAllLand = false;
  bool checkGet = false;

  //
  getAllLand() async {
    await getAllProvice();
    update();
  }

  getAllProvice() async {
    allProvinces = [];
    var res =
        await repository.get(url: repository.urlApi + repository.province);

    if (res.statusCode == 200) {
      for (var element in jsonDecode(res.body)['data']) {
        allProvinces.add(ProvinceModel.fromMap(element));
      }
    }
    update();
  }

  getAllDistrict(ProvinceModel provinceModel) async {
    allDistricts = [];
    var res = await repository.get(
        url: repository.urlApi +
            repository.district +
            provinceModel.id.toString());

    if (res.statusCode == 200) {
      for (var element in jsonDecode(res.body)['data']) {
        allDistricts.add(DistrictsModel.fromMap(element));
      }
    }
    //print(allDistricts);
    update();
    //getAllVillages();
  }

  getAllVillages(DistrictsModel districtsModel) async {
    allVillages = [];
    var res = await repository.get(
        url: repository.urlApi +
            repository.village +
            districtsModel.id.toString());
    if (res.statusCode == 200) {
      for (var element in jsonDecode(res.body)['data']) {
        allVillages.add(VillagesModel.fromMap(element));
      }
    }

    update();
  }

  updateDropDownProvince(ProvinceModel? provinceModel) async {
    provinceSelect = provinceModel;
    districtSelect = null;
    villageSelect = null;
    if (provinceModel != null) {
      await getAllDistrict(provinceModel);
    }

    update();
  }

  updateDropDownDistrict(DistrictsModel? districtsModel) async {
    districtSelect = districtsModel;
    villageSelect = null;
    if (districtsModel != null) {
      await getAllVillages(districtsModel);
    }

    update();
  }

  updateDropDownVillage(VillagesModel? villagesModel) {
    villageSelect = villagesModel;
    update();
  }

  clearData(bool useUpdate) async {
    allDistricts = [];
    allVillages = [];
    provinceSelect = null;
    districtSelect = null;
    villageSelect = null;
    if (useUpdate) {
      update();
    }
  }

  setValueProDisVil(
      {ProvinceModel? provinceModel,
      DistrictsModel? districtsModel,
      VillagesModel? villagesModel}) async {
    checkDataAllLand = false;
    update();

    if (useInit == false) {
      await getAllLand();
    }

    if (provinceModel != null) {
      await getAllDistrict(provinceModel);

      if (districtsModel != null) {
        await getAllVillages(districtsModel);
        if (villagesModel != null) {
          villageSelect = villagesModel;
        }
      }
    }

    for (var element in allProvinces) {
      if (element.id == provinceModel?.id) {
        provinceSelect = element;
        break;
      }
    }
    for (var element in allDistricts) {
      if (element.id == districtsModel?.id) {
        districtSelect = element;
        break;
      }
    }
    for (var element in allVillages) {
      if (element.id == villagesModel?.id) {
        villageSelect = element;
        break;
      }
    }

    checkDataAllLand = true;
    update();
  }

  getAllOnlyProvice() async {
    checkGet = false;
    allProvincesOnly = [];
    update();
    var res =
        await repository.get(url: repository.urlApi + repository.province);

    if (res.statusCode == 200) {
      for (var element in jsonDecode(res.body)['data']) {
        allProvincesOnly.add(ProvinceModel.fromMap(element));
      }
    }
    checkGet = true;
    update();
  }

  getAllOnlyDistrict() async {
    checkGet = false;
    allDistrictsOnly = [];
    update();
    var res = await repository.get(
        url: repository.urlApi + repository.getDistrictAll);

    if (res.statusCode == 200) {
      for (var element in jsonDecode(res.body)['data']) {
        allDistrictsOnly.add(DistrictsModel.fromMap(element));
      }
    }
    checkGet = true;
    update();
  }

  getAllOnlyVillage() async {
    checkGet = false;
    allVillagesOnly = [];
    update();
    var res = await repository.get(
        url: repository.urlApi + repository.getVillagesAll);

    if (res.statusCode == 200) {
      for (var element in jsonDecode(res.body)['data']) {
        allVillagesOnly.add(VillagesModel.fromMap(element));
      }
    }
    checkGet = true;
    update();
  }


  addProvince(String name) async {
    CustomDialogs().dialogLoading();
    try {
      var res = await repository.post(
          auth: true,
          url: repository.urlApi + repository.addProvince,
          body: {'name': name});
      Get.back();
      if (res.statusCode == 200) {
        Get.back(result: 'added');
      } else {
        throw res.body;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'something_wrong'.tr);
    }
  }

  addDistrict(DistrictsModel districtsModel) async {
    CustomDialogs().dialogLoading();
    try {
      var res = await repository.post(
          url: repository.urlApi + repository.addDistrict,
          body: {
            'name': districtsModel.name ?? '',
            'pro_id': districtsModel.proId.toString()
          },
          auth: true);
      Get.back();
      if (res.statusCode == 200) {
        Get.back(result: 'added');
      } else {
        throw res.body;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'something_wrong'.tr);
    }
  }

  addVillage(VillagesModel villageModel) async {
    CustomDialogs().dialogLoading();
    try {
      var res = await repository.post(
          url: repository.urlApi + repository.addDistrict,
          body: {
            'name': villageModel.name ?? '',
            'pro_id': villageModel.proId.toString(),
            'dis_id': villageModel.disId.toString(),
          },
          auth: true);
      Get.back();
      if (res.statusCode == 200) {
        Get.back(result: 'added');
      } else {
        throw res.body;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'something_wrong'.tr);
    }
  }

  editProvince(ProvinceModel provinceModel) async {
    CustomDialogs().dialogLoading();
    try {
      var res = await repository.post(
          auth: true,
          url: repository.urlApi + repository.editProvince,
          body: {
            'id': provinceModel.id.toString(),
            'name': provinceModel.name ?? ''
          });
      Get.back();
      if (res.statusCode == 200) {
        Get.back(result: 'edited');
      } else {
        throw res.body;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'something_wrong'.tr);
    }
  }

  editDistrict(DistrictsModel districtsModel) async {
    CustomDialogs().dialogLoading();
    try {
      var res = await repository.post(
          url: repository.urlApi + repository.editDistrict,
          body: {
            'id': districtsModel.id.toString(),
            'name': districtsModel.name ?? '',
            'pro_id': districtsModel.proId.toString()
          },
          auth: true);
      Get.back();
      if (res.statusCode == 200) {
        Get.back(result: 'edited');
      } else {
        throw res.body;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'something_wrong'.tr);
    }
  }

  editVillage(VillagesModel villageModel) async {
    CustomDialogs().dialogLoading();
    try {
      var res = await repository.post(
          url: repository.urlApi + repository.editVillage,
          body: {
            'id': villageModel.id.toString(),
            'name': villageModel.name ?? '',
            'pro_id': villageModel.proId.toString(),
            'dis_id': villageModel.disId.toString(),
          },
          auth: true);
      Get.back();
      if (res.statusCode == 200) {
        Get.back(result: 'added');
      } else {
        throw res.body;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'something_wrong'.tr);
    }
  }

  deleteProvince(BuildContext context, ProvinceModel provinceModel) async {
    try {
      CustomDialogs().dialogLoading();
      var res = await repository.put(
        url: repository.urlApi +
            repository.deleteProvince +
            provinceModel.id.toString(),
        auth: true,
      );
      Get.back();
      if (res.statusCode == 200) {
        CustomDialogs().showToast(context: context, text: 'delete_success');
        Get.back(result: 'deleted');
      } else {
        throw res.body;
      }
    } catch (e) {
      CustomDialogs().showToast(context: context, text: 'something_went_wrong');
    }

    update();
  }

  deleteVillage(BuildContext context, VillagesModel villageModel) async {
    try {
      CustomDialogs().dialogLoading();
      var res = await repository.put(
        url: repository.urlApi +
            repository.deleteVillage +
            villageModel.id.toString(),
        auth: true,
      );
      Get.back();
      if (res.statusCode == 200) {
        // ignore: use_build_context_synchronously
        CustomDialogs().showToast(context: context, text: 'delete_success');
        Get.back(result: 'deleted');
      } else {
        throw res.body;
      }
    } catch (e) {
      CustomDialogs().showToast(context: context, text: 'something_went_wrong');
    }

    update();
  }

  deleteDistrict(BuildContext context, DistrictsModel districtModel) async {
    try {
      CustomDialogs().dialogLoading();
      var res = await repository.put(
        url: repository.urlApi +
            repository.deleteDistrict +
            districtModel.id.toString(),
        auth: true,
      );
      Get.back();
      if (res.statusCode == 200) {
        CustomDialogs().showToast(context: context, text: 'delete_success');
        Get.back(result: 'deleted');
      } else {
        throw res.body;
      }
    } catch (e) {
      CustomDialogs().showToast(context: context, text: 'something_went_wrong');
    }

    update();
  }

  @override
  void onInit() {
    if (useInit == true) {
      getAllLand();
    }
    super.onInit();
  }
}

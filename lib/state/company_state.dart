// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:convert';

import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/models/company_model.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CompanyState extends GetxController {
  AppColors appColors = AppColors();
  bool check = false;
  Repository rep = Repository();
  List<CompanyModel> companyList = [];
  CompanyModel? selectedCompany;
  selectCompany(CompanyModel newSelect) {
    selectedCompany = newSelect;
    update();
  }

  clearSelection() {
    selectedCompany = null;
    update();
  }

  getCompany() async {
    try {
      check = false;
      update();
      var res = await rep.get(url: rep.urlApi + rep.getCompany, auth: true);
      companyList = [];
      if (res.statusCode == 200) {
        for (var element in jsonDecode(res.body)['data']) {
          companyList.add(CompanyModel.fromJson(element));
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

  addCompany(BuildContext context, CompanyModel companyModel) async {
    try {
      check = false;
      CustomDialogs().dialogLoading();
      var res = await rep.post(
          url: rep.urlApi + rep.addCompany,
          auth: true,
          body: companyModel.toJson());
      Get.back();
      if (res.statusCode == 200) {
        // ignore: use_build_context_synchronously
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
//print(e.toString());
    }
    check = true;
    update();
  }

  editCompany(BuildContext context, CompanyModel companyModel) async {
    try {
      check = false;
      CustomDialogs().dialogLoading();
      var res = await rep.post(
          url: rep.urlApi + rep.editCompany,
          auth: true,
          body: companyModel.toJson());
      Get.back();
      if (res.statusCode == 200) {
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
          text: 'something_went_wrong');
//print(e.toString());
    }
    check = true;
    update();
  }

  deleteCompany(BuildContext context, CompanyModel companyModel) async {
    try {
      check = false;
      CustomDialogs().dialogLoading();
      var res = await rep.put(
        url: rep.urlApi + rep.deleteCompany + companyModel.id.toString(),
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
    check = true;
    update();
  }
  setInitCompany({CompanyModel? companyModel}) async {
    await Future.delayed(const Duration(seconds: 1));

    for (var element in companyList) {
      if (element.id == companyModel?.id) {
        selectedCompany = element;
        break;
      }
    }
    update();
  }
  @override
  void onReady() {
    getCompany();
    super.onReady();
  }
}

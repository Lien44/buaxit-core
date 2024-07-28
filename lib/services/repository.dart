import 'dart:convert';

import 'package:bauxite_admin_app/models/image_upload_model.dart';
import 'package:bauxite_admin_app/pages/login.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/services/app_verification.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class Repository {
  //link url api
  // String urlApi = 'https://laobauxite.com/';
  String urlApi = 'http://192.168.1.5:8000/';
  // String urlApi = 'http://192.168.30.102:8000/';

  String login = 'api/login';
  String getprofile = 'api/get_profile';
  String editProfile = 'api/edit_profile';
  String user = 'api/user';
  String logout = 'api/logout';
  String updateUser = 'api/user/update';
  String getAppVersion = 'api/check_app_version';
  String getUserByRole = 'api/get_user_by_role/';
  String addUser = 'api/add_user';
  String editUser = 'api/edit_user';
  String deleteUser = 'api/delete_user/';

  String province = 'api/get_provinces';
  String district = 'api/get_districts_by_pro_id/';
  String village = 'api/get_villages_by_dis_id/';
  String getDistrictAll = 'api/get_districts_all';
  String getVillagesAll = 'api/get_villages_all';

  String addProvince = 'api/add_province';
  String editProvince = 'api/edit_province';
  String deleteProvince = 'api/delete_province/';

  String addDistrict = 'api/add_district';
  String editDistrict = 'api/edit_district';
  String deleteDistrict = 'api/delete_district/';

  String addVillage = 'api/add_village';
  String editVillage = 'api/edit_village';
  String deleteVillage = 'api/delete_village/';

  String getCompany = 'api/get_company';
  String addCompany = 'api/add_company';
  String editCompany = 'api/edit_company';
  String deleteCompany = 'api/delete_company/';

  String getCars = 'api/get_cars';
  String getCarsByCompany = 'api/get_cars_by_company/';
  String addCars = 'api/add_cars';
  String editCars = 'api/edit_cars';
  String deleteCar = 'api/delete_cars/';
  String editTisnumber = 'api/edit_tis_number';
  String searchCar = 'api/search_car';
   String searchscanoutCar = 'api/search_scan_out_car';

  String getChauffer = 'api/get_chauffer';
  String addChauffer = 'api/add_chauffer';
  String editChauffer = 'api/edit_chauffer';
  String deleteChauffer = 'api/delete_chauffer/';

  String getContracts = 'api/get_contracts';
  String addContracts = 'api/add_new_contract';
  String editContract = 'api/edit_contract';
  String getAllScanInByContractId = 'api/get_all_scan_in_by_contract_id/';
  String cancelContract = 'api/cancel_contract/';

  String getChaufferByCode = 'api/get_chauffer_by_code/';
  String getcarByCode = 'api/get_car_by_code/';
  String getChaufferByCodeForScanOut = 'api/get_chauffer_by_code_for_scan_out/';
  String scanIn = 'api/scan_in';

  String getScanInHistory = 'api/get_scan_in_history';
  String getScanOutHistory = 'api/get_scan_out_history';
  String getAllScanInOut = 'api/get_all_scan_in_out';
  String addClearing = 'api/add_clearing';
  String getAllClearingLogs = 'api/get_all_clearing_logs';

  String scanOut = 'api/scan_out';
  String checkScanOut = 'api/check_scan_out/';
  String getDashboard = 'api/get_dashboard';
  String dailyDash = 'api/daily_dashboard';
// khamdev dev custom
  String getChaufferByCodeForScanDownWareHouse = 'api/get_chauffer_by_code_for_scan_down_ware_house/';
   String searchscanDownWareHouseCar = 'api/search_scan_down_ware_house_car';
  String scanDownWarehouse = 'api/scan_down_warehouse';
// end khamdev dev custom

  String reportAll = 'api/report_all';
  String mineral = 'api/get_mineral';
  String addmineral = 'api/add_mineral';
  String editScanInOut = 'api/edit_scan_in_out';
  AppVerification appVerification = Get.put(AppVerification());
  Future<http.Response> get(
      {required String url, Map<String, String>? header, bool? auth}) async {
    try {
      var res = await http
          .get(Uri.parse(url),
              headers: header ??
                  {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    if (auth ?? false)
                      'Authorization': 'Bearer ${appVerification.token}'
                  })
          .timeout(const Duration(seconds: 30), onTimeout: () {
        return http.Response("Error", 408);
      });
      if (res.statusCode == 401) {
        Fluttertoast.showToast(
            msg: 'ເຂົ້າສູ່ລະບົບໝົດອາຍຸ',
            backgroundColor: AppColors().mainColor.withOpacity(0.75));
        appVerification.removeToken();
        Get.off(() => const LoginPage());
        return res;
      }
      return res;
    } catch (e) {
      // please comment print line before release
      // print(e);
      return http.Response("error", 503);
    }
  }

  Future<http.Response> post(
      {required String url,
      Map<String, String>? header,
      Map<String, String>? body,
      bool? auth}) async {
    try {
      var res = await http
          .post(Uri.parse(url),
              body: jsonEncode(body),
              headers: header ??
                  {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    if (auth ?? false)
                      'Authorization': 'Bearer ${appVerification.token}',
                  })
          .timeout(const Duration(seconds: 30), onTimeout: () {
        return http.Response("Error", 408);
      });
      if (res.statusCode == 401) {
        Fluttertoast.showToast(
            msg: 'ເຂົ້າສູ່ລະບົບໝົດອາຍຸ',
            backgroundColor: AppColors().mainColor.withOpacity(0.75));
        appVerification.removeToken();
        Get.off(() => const LoginPage());
        return res;
      }
      return res;
    } catch (e) {
      // please comment print line before release
      // print(e);
      return http.Response("error", 503);
    }
  }

  Future<http.Response> put(
      {required String url, Map<String, String>? header, bool? auth}) async {
    try {
      var res = await http
          .put(Uri.parse(url),
              headers: header ??
                  {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    if (auth ?? false)
                      'Authorization': 'Bearer ${appVerification.token}'
                  })
          .timeout(const Duration(seconds: 30), onTimeout: () {
        return http.Response("Error", 408);
      });
      if (res.statusCode == 401) {
        Fluttertoast.showToast(
            msg: 'ເຂົ້າສູ່ລະບົບໝົດອາຍຸ',
            backgroundColor: AppColors().mainColor.withOpacity(0.75));
        appVerification.storage.erase();
        Get.off(() => const LoginPage());
        return res;
      }
      return res;
    } catch (e) {
      // please comment print line before release
      // print(e);
      return http.Response("error", 503);
    }
  }

  Future<http.Response> delete(
      {required String url, Map<String, String>? header, bool? auth}) async {
    try {
      var res = await http
          .delete(Uri.parse(url),
              headers: header ??
                  {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    if (auth ?? false)
                      'Authorization': 'Bearer ${appVerification.token}'
                  })
          .timeout(const Duration(seconds: 30), onTimeout: () {
        return http.Response("Error", 408);
      });
      if (res.statusCode == 401) {
        Fluttertoast.showToast(
            msg: 'ເຂົ້າສູ່ລະບົບໝົດອາຍຸ',
            backgroundColor: AppColors().mainColor.withOpacity(0.75));
        appVerification.storage.erase();
        Get.off(() => const LoginPage());
        return res;
      }
      return res;
    } catch (e) {
      // please comment print line before release
      // print(e);
      return http.Response("error", 503);
    }
  }

  Future<http.Response> postMultiPart(
      {required String url,
      Map<String, String>? header,
      bool? auth,
      Map<String, String>? body,
      required List<ImageUploadModel> listFile}) async {
    var headers = header ??
        {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (auth ?? false) 'Authorization': 'Bearer ${appVerification.token}'
        };
    try {
      var res = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      res.headers.addAll(headers);

      if (body != null) {
        res.fields.addAll(body);
      }
      for (var element in listFile) {
        res.files.add(
            await _addImage(fieldName: element.fieldName, file: element.xFile));
      }

      var response = await res.send();
      var result = await http.Response.fromStream(response);
      return result;
    } catch (e) {
      // please comment print line before release
      // print(e);
      return http.Response("error", 503);
    }
  }

  Future<http.MultipartFile> _addImage(
      {XFile? file, required String fieldName}) async {
    Uint8List data = await file!.readAsBytes();
    List<int> list = data.cast();
    var picture = http.MultipartFile.fromBytes(fieldName, list,
        filename: path.basename(file.path));
    return picture;
  }
}

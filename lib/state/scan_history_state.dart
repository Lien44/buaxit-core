import 'dart:convert';
import 'package:bauxite_admin_app/models/scan_in_out_log_model.dart';
import 'package:bauxite_admin_app/models/scan_in_out_model.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:bauxite_admin_app/state/custom_date_picker_state.dart';
import 'package:get/get.dart';

class ScanHistoryState extends GetxController {
  Repository rep = Repository();
  CustomDatePickerState customDatePickerState =
      Get.put(CustomDatePickerState());
  bool check = false;
  List<ScanInOutLogModel> listScan = [];
  List<ScanInOutLogModel> searchList = [];

  List<ScanInOutModel> listAllScan = [];
  List<ScanInOutModel> searchAllScan = [];
  getData(String? query) async {
    check = false;
    update();
    // try {
    var res = await rep.get(
      url: rep.urlApi + rep.getScanInHistory,
      auth: true,
    );
    listScan = [];
    if (res.statusCode == 200) {
      for (var element in jsonDecode(res.body)['data']) {
        listScan.add(ScanInOutLogModel.fromJson(element));
      }
      searchList = listScan;
      check = true;
      update();
    }
    // } catch (e) {
    //   check = false;
    //   update();
    // }
  }

  getDataScanOut() async {
    check = false;
    update();
    try {
      var res = await rep.get(
        url: rep.urlApi + rep.getScanOutHistory,
        auth: true,
      );
      listScan = [];
      if (res.statusCode == 200) {
        for (var element in jsonDecode(res.body)['data']) {
          listScan.add(ScanInOutLogModel.fromJson(element));
        }
        searchList = listScan;
        check = true;
        update();
      }
    } catch (e) {
      check = false;
      update();
    }
  }

  getScanInOut() async {
    check = false;
    update();
    try {
      var res = await rep.post(
        url: rep.urlApi + rep.getAllScanInOut,
        auth: true,
        body: {
          'start_date':
              '${customDatePickerState.startDate?.year.toString().padLeft(2, "0")}-${customDatePickerState.startDate?.month.toString().padLeft(2, "0")}-${customDatePickerState.startDate?.day.toString().padLeft(2, "0")} 00:00:00',
          'end_date':
              '${customDatePickerState.endDate?.year.toString().padLeft(2, "0")}-${customDatePickerState.endDate?.month.toString().padLeft(2, "0")}-${customDatePickerState.endDate?.day.toString().padLeft(2, "0")} 23:59:59',
        },
      );
      // log(res.body);
      listAllScan = [];
      if (res.statusCode == 200) {
        for (var element in jsonDecode(res.body)['data']) {
          listAllScan.add(
            ScanInOutModel.fromJson(element),
          );
        }
        searchAllScan = listAllScan;
        check = true;
        update();
      }
    } catch (e) {
      check = false;
      update();
    }
  }
}

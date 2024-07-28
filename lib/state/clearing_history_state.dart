import 'dart:convert';


import 'package:bauxite_admin_app/models/clearing_history_model.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:bauxite_admin_app/state/custom_date_picker_state.dart';
import 'package:get/get.dart';

class ClearingHistoryState extends GetxController {
  Repository rep = Repository();
  CustomDatePickerState customDatePickerState =
      Get.put(CustomDatePickerState());
  ClearingHistoryModel? clearingHistoryModel;
  bool check = false;
  getData() async {
    check = false;
    update();
    try {
      var res = await rep.post(
        url: rep.urlApi + rep.getAllClearingLogs,
        auth: true,
        body: {
          'start_date':
              '${customDatePickerState.startDate?.year.toString().padLeft(2, "0")}-${customDatePickerState.startDate?.month.toString().padLeft(2, "0")}-${customDatePickerState.startDate?.day.toString().padLeft(2, "0")} 00:00:00',
          'end_date':
              '${customDatePickerState.endDate?.year.toString().padLeft(2, "0")}-${customDatePickerState.endDate?.month.toString().padLeft(2, "0")}-${customDatePickerState.endDate?.day.toString().padLeft(2, "0")} 23:59:59',
        },
      );
      clearingHistoryModel = null;

      if (res.statusCode == 200) {
        try {
          clearingHistoryModel =
              ClearingHistoryModel.fromJson(jsonDecode(res.body));
        } catch (e) {
          clearingHistoryModel = null;
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
}

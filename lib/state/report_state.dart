import 'dart:convert';
import 'dart:developer';

import 'package:bauxite_admin_app/models/report_model.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:bauxite_admin_app/state/company_state.dart';
import 'package:bauxite_admin_app/state/custom_date_picker_state.dart';
import 'package:get/get.dart';

class ReportState extends GetxController {
  bool check = true;
  Repository rep = Repository();
  CustomDatePickerState customDatePickerState =
      Get.put(CustomDatePickerState());
  CompanyState companyState = Get.put(CompanyState());
  ReportModel? reportModel;
  getData() async {
    try {
      check = false;
      update();
      var res = await rep.post(
        url: rep.urlApi + rep.reportAll,
        auth: true,
        body: {
          if (companyState.selectedCompany != null)
            "company_id": companyState.selectedCompany!.id.toString(),
          "start_date":
              "${customDatePickerState.startDate.toString().split(" ")[0]} 00:00:00",
          "end_date":
              "${customDatePickerState.endDate.toString().split(" ")[0]} 23:59:59",
        },
      );
    
      if (res.statusCode == 200) {
        reportModel = ReportModel.fromJson(jsonDecode(res.body));
        check = true;
        update();
      } else {
        throw res.body;
      }
    } catch (e) {
      log(e.toString());
      check = true;
      reportModel = null;
      update();
    }
  }
}

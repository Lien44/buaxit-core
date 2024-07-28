import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDatePickerState extends GetxController {
  DateTime? startDate;
  DateTime? endDate;
  final AppColors appColors = AppColors();
  pickStartDate(BuildContext context) async {
    startDate = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime.parse("2014-05-01 00:00:00"),
      lastDate: DateTime.parse("2030-05-01 23:59:59"),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: appColors.mainColor,
            ),
          ),
          child: child!,
        );
      },
    );

    endDate = null;
    update();
  }
  setStartDate(){
    startDate =  DateTime.now();
    endDate = DateTime.now();
    update();
  }
  pickEndDate(BuildContext context) async {
    endDate = await showDatePicker(
      context: context,
      initialDate: endDate ?? (startDate ?? DateTime.now()),
      firstDate: startDate ?? DateTime.parse("2014-05-01 00:00:00"),
      lastDate: DateTime.parse("2030-05-01 23:59:59"),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: appColors.mainColor,
            ),
          ),
          child: child!,
        );
      },
    );

    update();
  }

  String converToDateTimeApi(DateTime date) {
    String datetime =
        "${date.year.toString().padLeft(2, "0")}-${date.month.toString().padLeft(2, "0")}-${date.day.toString().padLeft(2, "0")} ${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}:${date.second.toString().padLeft(2, "0")}";
    return datetime;
  }

  String converToDateTimeLaos(DateTime date) {
    String datetime =
        "${date.day.toString().padLeft(2, "0")}-${date.month.toString().padLeft(2, "0")}-${date.year.toString().padLeft(2, "0")} ${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}:${date.second.toString().padLeft(2, "0")}";
    return datetime;
  }

  initData() {
    startDate = null;
    endDate = null;
  }

  @override
  void onReady() {
    initData();
    super.onReady();
  }
}

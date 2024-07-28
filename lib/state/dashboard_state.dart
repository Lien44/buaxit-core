import 'dart:convert';

import 'package:bauxite_admin_app/models/daily_dash_model.dart';
import 'package:bauxite_admin_app/models/dashboard_model.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardState extends GetxController {
  final ScrollController controller = ScrollController();
  Repository rep = Repository();
  DashboardModel? dashboardModel;
  bool check = false;
  List<DailyDashModel> dailyDashList = [];

  getDailyDashBoard() async {
    try {
      var res = await rep.get(url: rep.urlApi + rep.dailyDash, auth: true);
      dailyDashList = [];
      if (res.statusCode == 200) {
        for (var element in jsonDecode(res.body)['data']) {
          dailyDashList.add(DailyDashModel.fromJson(element));
        }
      } else {
        throw res.body;
      }
    } catch (e) {
      check = false;
      update();
    }

    update();
  }

  setStart() async {
    check = false;
    update();
    await getData();
    await getDailyDashBoard();
    await Future.delayed(const Duration(milliseconds: 1200)).then((value) {
      controller.jumpTo(controller.position.maxScrollExtent);
    });
  }

  getData() async {
    var res = await rep.get(
      url: rep.urlApi + rep.getDashboard,
      auth: true,
    );

    if (res.statusCode == 200) {
      dashboardModel = DashboardModel.fromJson(jsonDecode(res.body)['data']);
      check = true;
      update();
    }
  }

  @override
  void onReady() {
    setStart();

    super.onReady();
  }
}

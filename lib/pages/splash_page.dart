import 'dart:convert';
import 'dart:io';

import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/pages/dashboard_page.dart';

import 'package:bauxite_admin_app/pages/login.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/services/app_version.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int changeSize = 0;
  AppVersion appVersion = AppVersion();
  Repository rep = Repository();
  AppColors appColors = AppColors();
  @override
  void initState() {
    super.initState();
    rep.appVerification.setInitToken();
    initSplash();
  }

  initSplash() async {
    await Future.delayed(const Duration(milliseconds: 300)).then((value) {
      setState(() {
        changeSize = 50;
      });
    }).then((value) async {
      await Future.delayed(const Duration(milliseconds: 300)).then((value) {
        setState(() {
          changeSize = 100;
        });
      });
    }).then((value) async {
      await Future.delayed(const Duration(milliseconds: 500))
          .then((value) async {
        var res = await rep.get(url: rep.urlApi + rep.getAppVersion);

        if (res.statusCode == 200) {
          if (appVersion.version >= jsonDecode(res.body)['data']['version']) {
            if (rep.appVerification.token != '') {
              Get.to(() => DashboardPage(), transition: Transition.rightToLeft);
            } else {
              Get.off(() => const LoginPage());
            }
          } else {
            await CustomDialogs().dialogShowMessage(
                message: "ກະລຸນາອັບເດດເປັນເວີຊັ່ນລ້າສຸດກ່ອນ");
            exit(0);
          }
        } else {
          await CustomDialogs()
              .dialogShowMessage(message: "ບໍ່ສາມາດກວດສອບແອັບໄດ້");
          exit(0);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            width: size.width,
            height: (fixSize * 0.08) + changeSize,
            duration: const Duration(milliseconds: 300),
            child: Hero(
              tag: 'logo',
              child: CustomText(
                text: "BAUXITE",
                fontSize: fixSize * 0.02,
                color: appColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

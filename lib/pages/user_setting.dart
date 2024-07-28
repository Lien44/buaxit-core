import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/menu_widget.dart';
import 'package:bauxite_admin_app/pages/chauffer_page.dart';
import 'package:bauxite_admin_app/pages/user_detail_setting.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class USerSettingPage extends StatefulWidget {
  const USerSettingPage({super.key});

  @override
  State<USerSettingPage> createState() => _USerSettingPageState();
}

class _USerSettingPageState extends State<USerSettingPage> {
  final AppColors appColors = AppColors();
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.mainColor,
        title: CustomText(
          text: "ຂໍ້ມູນຜູ້ໃຊ້ລະບົບ",
          fontSize: fixSize * 0.022,
          color: appColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuWidget(
                onTap: () async {
                  Get.to(() => const UserDetailSettingPage(
                      roleId: '1', title: "ຜູ້ດູແລລະບົບ"));
                },
                icon: Icons.people,
                name: "ຜູ້ດູແລລະບົບ",
              ),
              MenuWidget(
                onTap: () async {
                  Get.to(() => const UserDetailSettingPage(
                      roleId: '2', title: "ຜູ້ບໍລິຫານ"));
                },
                icon: Icons.people,
                name: "ຜູ້ບໍລິຫານ",
              ),
            ],
          ),
          SizedBox(
            height: fixSize * 0.008,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuWidget(
                onTap: () async {
                  Get.to(() => const UserDetailSettingPage(
                      roleId: '3', title: "ພະນັກງານ"));
                },
                icon: Icons.people,
                name: "ພະນັກງານ",
              ),
              MenuWidget(
                onTap: () async {
                  Get.to(() => const ChaufferPage(roleId: '4', title: "ໂຊເຟີ"));
                },
                icon: Icons.people,
                name: "ໂຊເຟີ",
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

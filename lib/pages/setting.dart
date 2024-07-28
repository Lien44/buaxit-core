import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/menu_widget.dart';
import 'package:bauxite_admin_app/pages/car_page.dart';
import 'package:bauxite_admin_app/pages/company_page.dart';
import 'package:bauxite_admin_app/pages/user_setting.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
          text: "setting",
          fontSize: fixSize * 0.022,
          color: appColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: orientation == Orientation.portrait
            ? Column(children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MenuWidget(
                      onTap: () async {
                        Get.to(() => const CompanyPage(title: "ຂໍ້ມູນບໍລິສັດ"));
                      },
                      icon: Icons.location_city,
                      name: "ຂໍ້ມູນບໍລິສັດ",
                    ),
                    MenuWidget(
                      onTap: () async {
                        Get.to(() => const CarsPage(title: "ຂໍ້ມູນລົດ"));
                      },
                      icon: Icons.local_shipping,
                      name: "ຂໍ້ມູນລົດ",
                    ),
                  ],
                ),
                SizedBox(
                  height: fixSize * 0.008,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: fixSize * 0.0115),
                    MenuWidget(
                      onTap: () {
                        Get.to(() => const USerSettingPage());
                      },
                      icon: Icons.people,
                      name: "ຂໍ້ມູນຜູ້ໃຊ້ລະບົບ",
                    ),
                    // MenuWidget(
                    //   onTap: () {
                    //     Get.to(() => const LandSettingPage());

                    //     // CustomDialogs().showToast(
                    //     //   context: context,
                    //     //   text: "ກຳລັງພັດທະນາ",
                    //     //   backgroundColor: appColors.mainColor.withOpacity(0.75),
                    //     //   fontSize: fixSize * 0.0135,
                    //     //   bottom: size.height * 0.1,
                    //     // );
                    //   },
                    //   icon: Icons.home,
                    //   name: "ຂໍ້ມູນທີ່ຢູ່",
                    // ),
                  ],
                ),
              ])
            : Column(children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MenuWidget(
                      onTap: () async {
                        Get.to(() => const CompanyPage(title: "ຂໍ້ມູນບໍລິສັດ"));
                      },
                      icon: Icons.location_city,
                      name: "ຂໍ້ມູນບໍລິສັດ",
                    ),
                    MenuWidget(
                      onTap: () async {
                        Get.to(() => const CarsPage(title: "ຂໍ້ມູນລົດ"));
                      },
                      icon: Icons.local_shipping,
                      name: "ຂໍ້ມູນລົດ",
                    ),
                    MenuWidget(
                      onTap: () {
                        Get.to(() => const USerSettingPage());
                      },
                      icon: Icons.people,
                      name: "ຂໍ້ມູນຜູ້ໃຊ້ລະບົບ",
                    ),
                    // MenuWidget(
                    //   onTap: () {
                    //     Get.to(() => const LandSettingPage());

                    //     // CustomDialogs().showToast(
                    //     //   context: context,
                    //     //   text: "ກຳລັງພັດທະນາ",
                    //     //   backgroundColor: appColors.mainColor.withOpacity(0.75),
                    //     //   fontSize: fixSize * 0.0135,
                    //     //   bottom: size.height * 0.1,
                    //     // );
                    //   },
                    //   icon: Icons.home,
                    //   name: "ຂໍ້ມູນທີ່ຢູ່",
                    // ),
                  ],
                ),
              ]),
      ),
    );
  }
}

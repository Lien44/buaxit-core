import 'package:bauxite_admin_app/customs/custom_app_bar.dart';
import 'package:bauxite_admin_app/customs/menu_widget.dart';
import 'package:bauxite_admin_app/pages/all_scan_in_out_page.dart';

import 'package:bauxite_admin_app/pages/scan_in_history.dart';
import 'package:bauxite_admin_app/services/app_color.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanHistory extends StatelessWidget {
  ScanHistory({super.key});
  final AppColors appColors = AppColors();

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fsize = size.width + size.height;
    return Scaffold(
      appBar: CustomAppBar(
        orientation: orientation,
        height: size.height,
        title: "ປະຫວັດສະແກນເຂົ້າ-ອອກ",
        titleSize: fsize * 0.018,
      ),
      body: Padding(
        padding: EdgeInsets.all(fsize * 0.008),
        child: orientation == Orientation.portrait
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MenuWidget(
                        onTap: () {
                          Get.to(
                            () => const ScanInHistory(),
                            transition: Transition.rightToLeft,
                          );
                        },
                        name: "ປະຫວັດສະແກນເຂົ້າ",
                        icon: Icons.history,
                      ),
                      // MenuWidget(
                      //   onTap: () {
                      //     Get.to(
                      //       () => const ScanOutHistory(),
                      //       transition: Transition.rightToLeft,
                      //     );
                      //   },
                      //   name: "ປະຫວັດສະແກນອອກ",
                      //   icon: Icons.history,
                      // ),
                      Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MenuWidget(
                        onTap: () {
                          Get.to(
                            () => const AllScanInOutPage(),
                            transition: Transition.rightToLeft,
                          );
                        },
                        name: "ປະຫວັດການເຄື່ອນໄຫວ",
                        icon: Icons.history,
                      ),
                    ],
                  ),
                    ],
                  ),
                  // SizedBox(
                  //   height: fsize * 0.008,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     MenuWidget(
                  //       onTap: () {
                  //         Get.to(
                  //           () => const AllScanInOutPage(),
                  //           transition: Transition.rightToLeft,
                  //         );
                  //       },
                  //       name: "ທຸລະກຳທັງໝົດ",
                  //       icon: Icons.history,
                  //     ),
                  //   ],
                  // ),
                ],
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MenuWidget(
                        onTap: () {
                          Get.to(
                            () => const ScanInHistory(),
                            transition: Transition.rightToLeft,
                          );
                        },
                        name: "ປະຫວັດສະແກນເຂົ້າ",
                        icon: Icons.history,
                      ),
                      // MenuWidget(
                      //   onTap: () {
                      //     Get.to(
                      //       () => const ScanOutHistory(),
                      //       transition: Transition.rightToLeft,
                      //     );
                      //   },
                      //   name: "ປະຫວັດສະແກນອອກ",
                      //   icon: Icons.history,
                      // ),
                      MenuWidget(
                        onTap: () {
                          Get.to(
                            () => const AllScanInOutPage(),
                            transition: Transition.rightToLeft,
                          );
                        },
                        name: "ປະຫວັດການເຄື່ອນໄຫວ",
                        icon: Icons.history,
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}

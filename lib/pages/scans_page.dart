import 'package:bauxite_admin_app/customs/custom_app_bar.dart';
import 'package:bauxite_admin_app/customs/menu_widget.dart';
import 'package:bauxite_admin_app/pages/scan_history.dart';
import 'package:bauxite_admin_app/pages/select_scan_down_warehouse.dart';
import 'package:bauxite_admin_app/pages/select_scan_in.dart';
import 'package:bauxite_admin_app/pages/select_scan_out.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/camera_scan_page_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanPage extends StatelessWidget {
  ScanPage({super.key});
  final AppColors appColors = AppColors();
  final CameraScanPageState cameraScanPageState =
      Get.put(CameraScanPageState());
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fsize = size.width + size.height;
    return Scaffold(
      appBar: CustomAppBar(
        orientation: orientation,
        height: size.height,
        title: "ເລືອກສະເເກນ",
        actions: [
          IconButton(
            splashColor: appColors.white.withOpacity(0.5),
            splashRadius: fsize * 0.02,
            onPressed: () {
              Get.to(
                () => ScanHistory(),
                transition: Transition.rightToLeft,
              );
            },
            icon: Icon(
              Icons.history,
              color: appColors.white,
              size: fsize * 0.025,
            ),
          ),
          SizedBox(
            width: fsize * 0.01,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(fsize * 0.008),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 1,
            crossAxisSpacing: fsize * 0.01, // Adjust as needed
            mainAxisSpacing: fsize * 0.01, // Adjust as needed
          ),
          itemCount: 3, // Number of MenuWidgets
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return MenuWidget(
                  onTap: () {
                    Get.to(
                      () => const SelectScanIn(title: 'ສະແກນເຂົ້າ'),
                      transition: Transition.rightToLeft,
                    );
                  },
                  name: "ສະແກນເຂົ້າ",
                  svg: "assets/images/scan_in_icon.svg",
                );
              case 1:
                return MenuWidget(
                  onTap: () {
                    Get.to(
                      () => const SelectScanOut(title: 'ສະແກນອອກ'),
                      transition: Transition.rightToLeft,
                    );
                  },
                  name: "ສະແກນອອກ",
                  svg: "assets/images/scan_out_icon.svg",
                );
              case 2:
                return MenuWidget(
                  onTap: () {
                    Get.to(
                      () => const SelectscanDownWarehouse(title: 'ສະເເກນລົງສາງ'),
                      transition: Transition.rightToLeft,
                    );
                  },
                  name: "ສະເເກນລົງສາງ",
                  svg: "assets/images/scan_in_ware_house_icon.svg",
                );
              default:
                return const SizedBox();
            }
          },
        ),
        // child: Row(
        //   mainAxisAlignment: orientation == Orientation.portrait
        //       ? MainAxisAlignment.spaceBetween
        //       : MainAxisAlignment.start,
        //   children: [
        //     MenuWidget(
        //       onTap: () {
        //         Get.to(
        //           () => const SelectScanIn(title: 'ສະແກນເຂົ້າ'),
        //           transition: Transition.rightToLeft,
        //         );
        //         // Get.to(
        //         //   () => CameraScanPage(
        //         //     type: CameraType.scanIn,
        //         //   ),
        //         //   transition: Transition.rightToLeft,
        //         // );
        //       },
        //       name: "ສະແກນເຂົ້າ",
        //       svg: "assets/images/scan_in_icon.svg",
        //     ),
        //     orientation == Orientation.portrait
        //         ? const SizedBox()
        //         : SizedBox(
        //             width: fsize * 0.01,
        //           ),
        //     MenuWidget(
        //       onTap: () {
        //         // Get.to(
        //         //   () => const ScanOutPage(),
        //         //   transition: Transition.rightToLeft,
        //         // );
        //         Get.to(
        //           () => const SelectScanOut(title: 'ສະແກນອອກ'),
        //           transition: Transition.rightToLeft,
        //         );
        //       },
        //       name: "ສະແກນອອກ",
        //       svg: "assets/images/scan_out_icon.svg",
        //     ),
        //     orientation == Orientation.portrait
        //         ? const SizedBox()
        //         : SizedBox(
        //             width: fsize * 0.01,
        //           ),
        //     MenuWidget(
        //       onTap: () {
        //         // Get.to(
        //         //   () => const ScanOutPage(),
        //         //   transition: Transition.rightToLeft,
        //         // );
        //         Get.to(
        //           () => const SelectScanOut(title: 'ສະເເກນລົງສາງ'),
        //           transition: Transition.rightToLeft,
        //         );
        //       },
        //       name: "ສະເເກນລົງສາງ",
        //       svg: "assets/images/scan_out_icon.svg",
        //     )
        //   ],
        // ),
      ),
    );
  }
}

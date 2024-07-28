import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/menu_widget.dart';
import 'package:bauxite_admin_app/pages/land_detail.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandSettingPage extends StatefulWidget {
  const LandSettingPage({super.key});

  @override
  State<LandSettingPage> createState() => _LandSettingPageState();
}

class _LandSettingPageState extends State<LandSettingPage> {
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
          text: "ຂໍ້ມູນທີ່ຢູ່",
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
          GridView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            children: [
              MenuWidget(
                onTap: () async {
                  Get.to(
                      () => const LandDetailPage(title: 'ແຂວງ', value: 'pro'));
                },
                icon: Icons.home,
                name: "ແຂວງ",
              ),
              MenuWidget(
                onTap: () async {
                  Get.to(
                      () => const LandDetailPage(title: 'ເມືອງ', value: 'dis'));
                },
                icon: Icons.home,
                name: "ເມືອງ",
              ),
              MenuWidget(
                onTap: () async {
                  Get.to(
                      () => const LandDetailPage(title: 'ບ້ານ', value: 'vil'));
                },
                icon: Icons.home,
                name: "ບ້ານ",
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

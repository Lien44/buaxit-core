import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/mineral_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMineral extends StatefulWidget {
  const AddMineral(
      {super.key});
  @override
  State<AddMineral> createState() => _AddMineralState();
}

class _AddMineralState extends State<AddMineral> {
  final AppColors appColors = AppColors();
  TextEditingController nameT = TextEditingController();
  TextEditingController addressT = TextEditingController();
  MineralState mineralState = Get.put(MineralState());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.mainColor,
        title: CustomText(
          text: 'ເພີ່ມຂໍ້ມູນບໍ່',
          fontSize: fixSize * 0.022,
          color: appColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: fixSize * 0.01),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'ຊື່ບໍ່',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: nameT,
                  hintText: 'ຊື່ບໍ່',
                ),
              ],
            ),
            SizedBox(
              height: fixSize * 0.01,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'ທີ່ຢູ່',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: addressT,
                  hintText: 'ທີ່ຢູ່',
                ),
              ],
            ),
            SizedBox(
              height: fixSize * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5, backgroundColor: appColors.grey),
                    onPressed: () async {
                      Get.back();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: fixSize * 0.01),
                      child: CustomText(
                        text: 'ຍົກເລີກ',
                        color: appColors.white,
                        fontSize: fixSize * 0.015,
                      ),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5, backgroundColor: appColors.mainColor),
                    onPressed: () async {
                      validate();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: fixSize * 0.01),
                      child: CustomText(
                        text: 'ເພີ່ມໃໝ່',
                        color: appColors.white,
                        fontSize: fixSize * 0.015,
                      ),
                    )),
              ],
            )
          ]),
        ),
      ),
    );
  }

  validate() {
    if (nameT.text.trim().isEmpty) {
      CustomDialogs().showToast(
          context: context,
          text: 'please_enter_all_fiels',
          backgroundColor: appColors.mainColor.withOpacity(0.6));
      return;
    }
    mineralState.addMineral(
        context: context,
        name: nameT.text.trim(),
        address: addressT.text.trim());
  }
}

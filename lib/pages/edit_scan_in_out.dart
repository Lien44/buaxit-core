import 'package:bauxite_admin_app/customs/custom_input_format.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/camera_scan_page_state.dart';
import 'package:bauxite_admin_app/state/car_state.dart';
import 'package:bauxite_admin_app/state/company_state.dart';
import 'package:bauxite_admin_app/state/land_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../customs/custom_text_field_widget_with_title.dart';
import '../models/scan_in_out_model.dart';

class EditScanInOut extends StatefulWidget {
  const EditScanInOut({super.key, this.data});
  final ScanInOutModel? data;

  @override
  State<EditScanInOut> createState() => _EditScanInOutState();
}

class _EditScanInOutState extends State<EditScanInOut> {
  final AppColors appColors = AppColors();
  TextEditingController code = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController mineral = TextEditingController();
  TextEditingController carnumber = TextEditingController();
  TextEditingController tisnumber = TextEditingController();
  TextEditingController totalWeight = TextEditingController();
  TextEditingController carWeight = TextEditingController();
  TextEditingController metaWeight = TextEditingController();
  TextEditingController actualWeight = TextEditingController();
  LandState landState = Get.put(LandState());
  CompanyState companyState = Get.put(CompanyState());
  CameraScanPageState cameraScanPageState = Get.put(CameraScanPageState());
  CarState carState = Get.put(CarState());
  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    if (widget.data != null) {
      code.text = widget.data?.code ?? '';
      name.text = widget.data?.carModel?.name ?? '';
      carnumber.text = widget.data?.carModel?.carNumber ?? '';
      company.text = widget.data?.contractModel?.companyId?.name ?? '';
      mineral.text = widget.data?.mineralModel?.name ?? '';
      tisnumber.text = widget.data?.carModel?.tisNumber ?? '';
      totalWeight.text = widget.data?.totalWeight ?? '';
      carState.weightT.text = widget.data?.carWeight ?? '';
      // carState.metalweight.text = widget.data?.metalWeight ?? '';
      carState.actualweight.text = widget.data?.actualWeight ?? '';
    }
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
          text: 'ແກ້ໄຂຂໍ້ມູນການເຄື່ອນໄຫວ',
          fontSize: fixSize * 0.022,
          color: appColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: fixSize * 0.01),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: fixSize * 0.01,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'ລະຫັດທຸລະກໍາ',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  readOnly: true,
                  controller: code,
                  hintText: 'ລະຫັດທຸລະກໍາ',
                ),
              ],
            ),
            SizedBox(
              height: fixSize * 0.01,
            ),
            Column(
              children: [
                Row(
                  children: [
                    CustomText(
                      text: 'ບໍລິສັດ',
                      fontSize: fixSize * 0.0145,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  readOnly: true,
                  controller: company,
                  hintText: 'ບໍລິສັດ',
                ),
              ],
            ),
            SizedBox(
              height: fixSize * 0.01,
            ),
            SizedBox(
              height: fixSize * 0.01,
            ),
            Column(
              children: [
                Row(
                  children: [
                    CustomText(
                      text: 'ຂໍ້ມູນບໍ່',
                      fontSize: fixSize * 0.0145,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  readOnly: true,
                  controller: mineral,
                  hintText: 'ຂໍ້ມູນບໍ່',
                ),
              ],
            ),
            SizedBox(
              height: fixSize * 0.01,
            ),
            Column(
              children: [
                Row(
                  children: [
                    CustomText(
                      text: 'ຊື່ລົດ',
                      fontSize: fixSize * 0.0145,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  readOnly: true,
                  controller: name,
                  hintText: 'ຊື່ລົດ',
                ),
              ],
            ),
            SizedBox(
              height: fixSize * 0.01,
            ),
            Column(
              children: [
                Row(
                  children: [
                    CustomText(
                      text: 'ເລກທະບຽນ',
                      fontSize: fixSize * 0.0145,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  readOnly: true,
                  controller: carnumber,
                  hintText: 'ເລກທະບຽນ',
                ),
              ],
            ),
            SizedBox(
              height: fixSize * 0.01,
            ),
            Column(
              children: [
                Row(
                  children: [
                    CustomText(
                      text: 'ເລກໝ໋ອກ',
                      fontSize: fixSize * 0.0145,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  readOnly: true,
                  controller: tisnumber,
                  hintText: 'ເລກໝ໋ອກ',
                ),
              ],
            ),
            SizedBox(
              height: fixSize * 0.01,
            ),
            Column(
              children: [
                CustomTextFieldWithTitle(
                  onFieldSubmitted: (p0) {
                    carState.update();
                  },
                  onChange: (p1) {
                    carState.caculateMetalWeight(double.parse(p1.toString()));
                  },
                  keyBoardType: TextInputType.text,
                  controller: totalWeight,
                  inputFormatter: [
                    CustomNumberFormatter(),
                  ],
                  titleSize: fixSize * 0.0145,
                  title: "ນ້ຳໜັກລົດລວມແຮ່ທາດ",
                  hint: "ນ້ຳໜັກລົດລວມແຮ່ທາດ",
                  trailingText: "ໂຕນ",
                ),
              ],
            ),
            SizedBox(
              height: fixSize * 0.01,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldWithTitle(
                        keyBoardType: TextInputType.text,
                        controller: carState.weightT,
                        inputFormatter: [
                          CustomNumberFormatter(),
                        ],
                        onChange: (p1) {
                          carState.caculateMetalWeight(
                              double.parse(totalWeight.text.toString()));
                        },
                        titleSize: fixSize * 0.0145,
                        title: "ນ້ຳໜັກລົດເປົ່າ",
                        hint: "ນ້ຳໜັກລົດເປົ່າ",
                        trailingText: "ໂຕນ",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: fixSize * 0.01,
            ),
            GetBuilder<CarState>(builder: (getmetotal) {
              return Column(
                children: [
                  Row(
                    children: [
                      CustomText(
                        text: 'ນໍ້າໜັກແຮ່ລົງສາງ',
                        fontSize: fixSize * 0.0145,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFieldWidget(
                    controller: carState.actualweight,
                    hintText: 'ນໍ້າໜັກແຮ່ລົງສາງ',
                  ),
                ],
              );
            }),
            SizedBox(
              height: fixSize * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5, backgroundColor: appColors.mainColor),
                    onPressed: () async {
                      validate();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: fixSize * 0.01),
                      child: CustomText(
                        text: 'ແກ້ໄຂ',
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
    cameraScanPageState.editScanInOut(
        context,
        widget.data?.id.toString() ?? '0',
        totalWeight.text.trim(),
        carState.weightT.text.toString(),
        carState.metalweight.text,
        carState.actualweight.text);
  }
}

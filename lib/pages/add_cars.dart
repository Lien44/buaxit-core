import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/drop_down_widget.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';
import 'package:bauxite_admin_app/models/cars_model.dart';
import 'package:bauxite_admin_app/models/company_model.dart';
import 'package:bauxite_admin_app/pages/add_company.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/car_state.dart';
import 'package:bauxite_admin_app/state/company_state.dart';
import 'package:bauxite_admin_app/state/land_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart' as qr;

class AddCarsPage extends StatefulWidget {
  const AddCarsPage({super.key, this.carsModel});

  final CarsModel? carsModel;

  @override
  State<AddCarsPage> createState() => _AddCarsPageState();
}

class _AddCarsPageState extends State<AddCarsPage> {
  final AppColors appColors = AppColors();
  TextEditingController nameT = TextEditingController();
  TextEditingController carNumberT = TextEditingController();
  TextEditingController tisNumberT = TextEditingController();
  TextEditingController noteT = TextEditingController();

  LandState landState = Get.put(LandState());
  CompanyState companyState = Get.put(CompanyState());
  CarState carState = Get.put(CarState());
  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    if (widget.carsModel != null) {
      nameT.text = widget.carsModel?.name ?? '';
      carNumberT.text = widget.carsModel?.carNumber ?? '';
      tisNumberT.text = widget.carsModel?.tisNumber ?? '';
      noteT.text = widget.carsModel?.note ?? '';
      companyState.setInitCompany(
          companyModel: CompanyModel(id: widget.carsModel?.companyId?.id));
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
          text: widget.carsModel != null ? 'ແກ້ໄຂຂໍ້ມູນລົດ' : 'ເພິ່ມຂໍ້ມູນລົດ',
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
                  text: 'car_name',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: nameT,
                  hintText: 'car_name',
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
                  text: 'car_number',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: carNumberT,
                  hintText: 'car_number',
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
                  text: 'ເລກໝ໋ອກ',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: tisNumberT,
                  hintText: 'ເລກໝ໋ອກ',
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
                  text: 'company',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GetBuilder<CompanyState>(builder: (company) {
                        return DropDownWidget(
                            fixSize: fixSize,
                            value: companyState.selectedCompany,
                            hint: "company",
                            listMenuItems: companyState.companyList
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: CustomText(
                                      text: e.name ?? "",
                                    )))
                                .toList(),
                            onChange: (value) {
                              company.selectCompany(value);
                            });
                      }),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        var res = await Get.to(() => const AddEditCompanyPage(),
                            transition: Transition.rightToLeft);
                        if (res == true) {
                          companyState.getCompany();
                        }
                      },
                      child: Container(
                        color: appColors.mainColor,
                        width: fixSize * 0.05,
                        height: fixSize * 0.035,
                        child: Icon(
                          Icons.add,
                          color: appColors.white,
                          size: fixSize * 0.02,
                        ),
                      ),
                    )
                  ],
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
                  text: 'note',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: noteT,
                  hintText: 'note',
                ),
              ],
            ),
            SizedBox(
              height: fixSize * 0.02,
            ),
            widget.carsModel?.code != null
                ? Container(
                    height: fixSize * 0.3,
                    padding: EdgeInsets.symmetric(horizontal: fixSize * 0.01),
                    decoration: BoxDecoration(
                        color: appColors.white,
                        boxShadow: [
                          BoxShadow(blurRadius: 2, color: appColors.grey)
                        ]),
                    child: Center(
                      child: qr.QrImageView(
                        data: widget.carsModel?.code ?? '',
                        version: qr.QrVersions.min,
                        size: size.width,
                      ),
                    ),
                  )
                : const SizedBox(),
            widget.carsModel != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 5, backgroundColor: appColors.grey),
                          onPressed: () async {
                            delete(fixSize);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: fixSize * 0.01),
                            child: CustomText(
                              text: 'ລົບຂໍ້ມູນລົດ',
                              color: appColors.white,
                              fontSize: fixSize * 0.015,
                            ),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: appColors.mainColor),
                          onPressed: () async {
                            validate();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: fixSize * 0.01),
                            child: CustomText(
                              text: 'ແກ້ໄຂຂໍ້ມູນລົດ',
                              color: appColors.white,
                              fontSize: fixSize * 0.015,
                            ),
                          )),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: appColors.mainColor),
                          onPressed: () async {
                            validate();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: fixSize * 0.01),
                            child: CustomText(
                              text: 'ເພິ່ມຂໍ້ມູນລົດ',
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

  delete(double fixSize) async {
    var res = await CustomDialogs().yesAndNoDialogWithText(
        context, fixSize, 'ທ່ານຕ້ອງການລົບຂໍ້ມູນນີ້ແທ້ ຫຼື ບໍ່?');

    if (res == true) {
      if (mounted) {
        await carState.deleteCar(context, widget.carsModel!);
      }
    }
  }

  validate() {
    if (carNumberT.text.trim().isEmpty ||
        tisNumberT.text.trim().isEmpty ||
        companyState.selectedCompany == null) {
      CustomDialogs().showToast(
          context: context,
          text: 'please_enter_all_fiels',
          backgroundColor: appColors.mainColor.withOpacity(0.6));
      return;
    }
    if (widget.carsModel != null) {
      carState.editCars(
          context,
          CarsModel(
              id: widget.carsModel!.id,
              name: nameT.text.trim(),
              carNumber: carNumberT.text.trim(),
              note: noteT.text.trim(),
              tisNumber: tisNumberT.text.trim(),
              companyId: CompanyId(id: companyState.selectedCompany?.id)));
      return;
    }
    carState.addCars(
        context,
        CarsModel(
            name: nameT.text.trim(),
            carNumber: carNumberT.text.trim(),
            note: noteT.text.trim(),
            tisNumber: tisNumberT.text.trim(),
            companyId: CompanyId(id: companyState.selectedCompany?.id)));
  }
}

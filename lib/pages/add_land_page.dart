import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/drop_down_widget.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';
import 'package:bauxite_admin_app/models/land_model.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/land_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddLandPage extends StatefulWidget {
  const AddLandPage(
      {super.key,
      this.provinceModel,
      this.districtsModel,
      this.villagesModel,
      required this.value});
  final String value;
  final ProvinceModel? provinceModel;
  final DistrictsModel? districtsModel;
  final VillagesModel? villagesModel;

  @override
  State<AddLandPage> createState() => _AddLandPageState();
}

class _AddLandPageState extends State<AddLandPage> {
  final AppColors appColors = AppColors();
  TextEditingController nameT = TextEditingController();
  TextEditingController carNumberT = TextEditingController();
  TextEditingController noteT = TextEditingController();

  LandState landState = Get.put(LandState());

  @override
  void initState() {
    setData();
    super.initState();
  }

  String title() {
    if (widget.value == 'pro') {
      return 'ແຂວງ';
    }
    if (widget.value == 'dis') {
      return 'ເມືອງ';
    }
    if (widget.value == 'vil') {
      return 'ບ້ານ';
    }
    return '';
  }

  setData() async {
    await Future.delayed(Duration.zero);
    if (widget.value == 'dis' || widget.value == 'vil') {
      if (widget.districtsModel == null && widget.villagesModel == null) {
        landState.getAllLand();
      }
    }
    if (widget.provinceModel != null) {
      nameT.text = widget.provinceModel?.name ?? '';
    }
    if (widget.districtsModel != null) {
      nameT.text = widget.districtsModel?.name ?? '';
      landState.setValueProDisVil(
          provinceModel: ProvinceModel(id: widget.districtsModel?.proId));
    }
    if (widget.villagesModel != null) {
      nameT.text = widget.villagesModel?.name ?? '';
      landState.setValueProDisVil(
        provinceModel: ProvinceModel(id: widget.villagesModel?.proId),
        districtsModel: DistrictsModel(id: widget.villagesModel?.disId),
      );
    }
  }

  @override
  void dispose() {
    landState.clearData(false);
    super.dispose();
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
          text: (widget.provinceModel != null ||
                  widget.districtsModel != null ||
                  widget.villagesModel != null)
              ? 'ແກ້ໄຂຂໍ້ມູນ${title()}'
              : 'ເພິ່ມ${title()}',
          fontSize: fixSize * 0.022,
          color: appColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: GetBuilder<LandState>(builder: (get) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: fixSize * 0.01),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: fixSize * 0.01,
              ),
              Column(
                children: [
                  if (widget.value == 'dis' || widget.value == 'vil')
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      text: 'province',
                                      fontSize: fixSize * 0.0145,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                DropDownWidget<ProvinceModel>(
                                    fixSize: fixSize,
                                    value: get.provinceSelect,
                                    hint: 'province',
                                    listMenuItems: get.allProvinces.map((e) {
                                      return DropdownMenuItem<ProvinceModel>(
                                          value: e,
                                          child: CustomText(
                                            text: e.name.toString(),
                                            fontSize: fixSize * 0.015,
                                          ));
                                    }).toList(),
                                    onChange: (v) {
                                      get.updateDropDownProvince(v);
                                    }),
                              ],
                            )),
                          ],
                        ),
                        SizedBox(
                          height: fixSize * 0.01,
                        ),
                      ],
                    ),
                  if (widget.value == 'vil')
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      text: 'district',
                                      fontSize: fixSize * 0.0145,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                DropDownWidget<DistrictsModel>(
                                    fixSize: fixSize,
                                    value: get.districtSelect,
                                    hint: 'district',
                                    listMenuItems: get.allDistricts.map((e) {
                                      return DropdownMenuItem<DistrictsModel>(
                                          value: e,
                                          child: CustomText(
                                            text: e.name.toString(),
                                            fontSize: fixSize * 0.015,
                                          ));
                                    }).toList(),
                                    onChange: (v) {
                                      get.updateDropDownDistrict(v);
                                    }),
                              ],
                            )),
                          ],
                        ),
                        SizedBox(
                          height: fixSize * 0.01,
                        ),
                      ],
                    )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'ຊື່'.tr + title(),
                    fontSize: fixSize * 0.0145,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFieldWidget(
                    controller: nameT,
                    hintText: 'ຊື່'.tr + title(),
                  ),
                ],
              ),
              SizedBox(
                height: fixSize * 0.02,
              ),
              widget.provinceModel != null ||
                      widget.districtsModel != null ||
                      widget.villagesModel != null
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
                                text: 'ລົບຂໍ້ມູນ${title()}',
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
                                text: 'ແກ້ໄຂຂໍ້ມູນ${title()}',
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
                                text: 'ເພິ່ມຂໍ້ມູນ${title()}',
                                color: appColors.white,
                                fontSize: fixSize * 0.015,
                              ),
                            )),
                      ],
                    )
            ]),
          ),
        );
      }),
    );
  }

  delete(double fixSize) async {
    var res = await CustomDialogs().yesAndNoDialogWithText(
        context, fixSize, 'ທ່ານຕ້ອງການລົບຂໍ້ມູນນີ້ແທ້ ຫຼື ບໍ່?');

    if (res == true) {
      if (mounted) {
        if (widget.value == 'pro') {
          landState.deleteProvince(context, widget.provinceModel!);
        }
        if (widget.value == 'dis') {
          landState.deleteDistrict(context, widget.districtsModel!);
        }
        if (widget.value == 'vil') {
          landState.deleteVillage(context, widget.villagesModel!);
        }
      }
    }
  }

  validate() async {
    if (nameT.text.trim().isEmpty) {
      CustomDialogs().showToast(
          context: context,
          text: 'please_enter_all_fiels',
          backgroundColor: appColors.mainColor.withOpacity(0.6));
      return;
    }
    if (widget.value == 'pro') {
      if (widget.provinceModel != null) {
        await landState.editProvince(ProvinceModel(
            id: widget.provinceModel!.id, name: nameT.text.trim()));
        return;
      }
      await landState.addProvince(nameT.text);
      return;
    }
    if (widget.value == 'dis') {
      if (landState.provinceSelect == null) {
        CustomDialogs().showToast(
            context: context,
            text: 'ກະລຸນາເລືອກ ແຂວງ',
            backgroundColor: appColors.mainColor.withOpacity(0.6));
        return;
      }
      if (widget.districtsModel != null) {
        await landState.editDistrict(DistrictsModel(
            id: widget.districtsModel!.id,
            name: nameT.text.trim(),
            proId: landState.provinceSelect?.id));
        return;
      }
      landState.addDistrict(DistrictsModel(
          name: nameT.text, proId: landState.provinceSelect?.id));
      return;
    }
    if (widget.value == 'vil') {
      if (landState.provinceSelect == null ||
          landState.districtSelect == null) {
        CustomDialogs().showToast(
            context: context,
            text: 'ກະລຸນາເລືອກ ແຂວງ ແລະ ເມືອງ',
            backgroundColor: appColors.mainColor.withOpacity(0.6));
        return;
      }
      if (widget.villagesModel != null) {
        await landState.editVillage(VillagesModel(
            id: widget.villagesModel!.id,
            name: nameT.text.trim(),
            proId: landState.provinceSelect?.id,
            disId: landState.districtSelect?.id));
        return;
      }
      landState.addVillage(VillagesModel(
          name: nameT.text,
          proId: landState.provinceSelect?.id,
          disId: landState.districtSelect?.id));
      return;
    }
  }
}

import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';
import 'package:bauxite_admin_app/models/company_model.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/company_state.dart';
import 'package:bauxite_admin_app/state/land_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditCompanyPage extends StatefulWidget {
  const AddEditCompanyPage({super.key, this.companyModel});
  final CompanyModel? companyModel;

  @override
  State<AddEditCompanyPage> createState() => _AddEditCompanyPageState();
}

class _AddEditCompanyPageState extends State<AddEditCompanyPage> {
  final AppColors appColors = AppColors();
  TextEditingController nameT = TextEditingController();
  TextEditingController noteT = TextEditingController();

  TextEditingController countryT = TextEditingController();
  TextEditingController proT = TextEditingController();
  TextEditingController disT = TextEditingController();
  TextEditingController vilT = TextEditingController();

  LandState landState = Get.put(LandState());
  CompanyState companyState = Get.put(CompanyState());
  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    if (widget.companyModel != null) {
      nameT.text = widget.companyModel?.name ?? '';
      noteT.text = widget.companyModel?.note ?? '';
      countryT.text = widget.companyModel?.countryName ?? '';
      proT.text = widget.companyModel?.proName ?? '';
      disT.text = widget.companyModel?.disName ?? '';
      vilT.text = widget.companyModel?.vilName ?? '';
      // await landState.setValueProDisVil(
      //   provinceModel: widget.companyModel?.proId,
      //   districtsModel: widget.companyModel?.disId,
      //   villagesModel: widget.companyModel?.vilId,
      // );
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
          text: widget.companyModel != null ? 'ແກ້ໄຂບໍລິສັດ' : 'ເພິ່ມບໍລິສັດ',
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
                  text: 'company_name',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: nameT,
                  hintText: 'company_name',
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
                      text: 'ປະເທດ',
                      fontSize: fixSize * 0.0145,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: countryT,
                  hintText: 'ປະເທດ',
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
                      text: 'province',
                      fontSize: fixSize * 0.0145,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: proT,
                  hintText: 'province',
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
                      text: 'district',
                      fontSize: fixSize * 0.0145,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: disT,
                  hintText: 'district',
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
                      text: 'village',
                      fontSize: fixSize * 0.0145,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: vilT,
                  hintText: 'village',
                ),
              ],
            ),

            // GetBuilder<LandState>(builder: (get) {
            //   if (widget.companyModel != null) {
            //     if (!get.checkDataAllLand) {
            //       return CircularProgressIndicator(
            //         color: appColors.mainColor,
            //       );
            //     }
            //   }
            //   return Column(
            //     children: [
            //       Row(
            //         children: [
            //           Expanded(
            //               child: Column(
            //             children: [
            //               Row(
            //                 children: [
            //                   CustomText(
            //                     text: 'province',
            //                     fontSize: fixSize * 0.0145,
            //                     fontWeight: FontWeight.w600,
            //                   ),
            //                 ],
            //               ),
            //               const SizedBox(
            //                 height: 5,
            //               ),
            //               DropDownWidget<ProvinceModel>(
            //                   fixSize: fixSize,
            //                   value: get.provinceSelect,
            //                   hint: 'province',
            //                   listMenuItems: get.allProvinces.map((e) {
            //                     return DropdownMenuItem<ProvinceModel>(
            //                         value: e,
            //                         child: CustomText(
            //                           text: e.name.toString(),
            //                           fontSize: fixSize * 0.015,
            //                         ));
            //                   }).toList(),
            //                   onChange: (v) {
            //                     get.updateDropDownProvince(v);
            //                   }),
            //             ],
            //           )),
            //         ],
            //       ),
            //       SizedBox(
            //         height: fixSize * 0.01,
            //       ),
            //       Row(
            //         children: [
            //           Expanded(
            //               child: Column(
            //             children: [
            //               Row(
            //                 children: [
            //                   CustomText(
            //                     text: 'district',
            //                     fontSize: fixSize * 0.0145,
            //                     fontWeight: FontWeight.w600,
            //                   ),
            //                 ],
            //               ),
            //               const SizedBox(
            //                 height: 5,
            //               ),
            //               DropDownWidget<DistrictsModel>(
            //                   fixSize: fixSize,
            //                   value: get.districtSelect,
            //                   hint: 'district',
            //                   listMenuItems: get.allDistricts.map((e) {
            //                     return DropdownMenuItem<DistrictsModel>(
            //                         value: e,
            //                         child: CustomText(
            //                           text: e.name.toString(),
            //                           fontSize: fixSize * 0.015,
            //                         ));
            //                   }).toList(),
            //                   onChange: (v) {
            //                     get.updateDropDownDistrict(v);
            //                   }),
            //             ],
            //           )),
            //         ],
            //       ),
            //       SizedBox(
            //         height: fixSize * 0.01,
            //       ),
            //       Row(
            //         children: [
            //           Expanded(
            //               child: Column(
            //             children: [
            //               Row(
            //                 children: [
            //                   CustomText(
            //                     text: 'village',
            //                     fontSize: fixSize * 0.0145,
            //                     fontWeight: FontWeight.w600,
            //                   ),
            //                 ],
            //               ),
            //               const SizedBox(
            //                 height: 5,
            //               ),
            //               DropDownWidget<VillagesModel>(
            //                   fixSize: fixSize,
            //                   value: get.villageSelect,
            //                   hint: 'village',
            //                   listMenuItems: get.allVillages.map((e) {
            //                     return DropdownMenuItem<VillagesModel>(
            //                         value: e,
            //                         child: CustomText(
            //                           text: e.name.toString(),
            //                           fontSize: fixSize * 0.015,
            //                         ));
            //                   }).toList(),
            //                   onChange: (v) {
            //                     get.updateDropDownVillage(v);
            //                   }),
            //             ],
            //           )),
            //         ],
            //       ),
            //     ],
            //   );
            // }),

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
            widget.companyModel != null
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
                              text: 'ລົບຂໍ້ມູນບໍລິສັດ',
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
                              text: 'ແກ້ໄຂຂໍ້ມູນບໍລິສັດ',
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
                              text: 'ເພິ່ມຂໍ້ມູນບໍລິສັດ',
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
        await companyState.deleteCompany(context, widget.companyModel!);
      }
    }
  }

  validate() {
    if (nameT.text.trim().isEmpty ||
        // noteT.text.trim().isEmpty ||
        countryT.text.trim().isEmpty ||
        proT.text.trim().isEmpty ||
        disT.text.trim().isEmpty ||
        vilT.text.trim().isEmpty) {
      CustomDialogs().showToast(
          context: context,
          text: 'please_enter_all_fiels',
          backgroundColor: appColors.mainColor.withOpacity(0.6));
      return;
    }
    if (widget.companyModel != null) {
      companyState.editCompany(
          context,
          CompanyModel(
              id: widget.companyModel!.id,
              name: nameT.text.trim(),
              countryName: countryT.text.trim(),
              proName: proT.text.trim(),
              disName: disT.text.trim(),
              vilName: vilT.text.trim(),
              note: noteT.text.trim()));
      return;
    }
    companyState.addCompany(
        context,
        CompanyModel(
            name: nameT.text.trim(),
            countryName: countryT.text.trim(),
            proName: proT.text.trim(),
            disName: disT.text.trim(),
            vilName: vilT.text.trim(),
            note: noteT.text.trim()));
  }
}

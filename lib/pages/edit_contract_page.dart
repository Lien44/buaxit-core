import 'dart:convert';

import 'package:bauxite_admin_app/customs/custom_app_bar.dart';
import 'package:bauxite_admin_app/customs/custom_date_picker.dart';
import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/customs/custom_input_format.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/custom_text_field_widget_with_title.dart';
import 'package:bauxite_admin_app/customs/drop_down_widget.dart';
import 'package:bauxite_admin_app/models/contract_model.dart';
import 'package:bauxite_admin_app/pages/add_company.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/company_state.dart';
import 'package:bauxite_admin_app/state/contract_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditContarctPage extends StatefulWidget {
  const EditContarctPage({super.key, required this.contractModel});
  final ContractModel contractModel;

  @override
  State<EditContarctPage> createState() => _EditContarctPageState();
}

class _EditContarctPageState extends State<EditContarctPage> {
  final AppColors appColors = AppColors();

  final ContractState contractState = Get.put(ContractState());

  final CompanyState companyState = Get.put(CompanyState());

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await companyState.getCompany();
    contractState.initData(widget.contractModel);
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        orientation: orientation,
        height: size.height,
        title: "edit_contracts",
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          8.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: GetBuilder<CompanyState>(builder: (company) {
                      return GetBuilder<ContractState>(builder: (contract) {
                        return DropDownWidget(
                            fixSize: fixSize,
                            value: companyState.selectedCompany,
                            hint: "ບໍລິສັດ",
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
                      });
                    }),
                  ),
                  SizedBox(
                    width: fixSize * 0.01,
                  ),
                  InkWell(
                    onTap: () async {
                      var result = await Get.to(
                        () => const AddEditCompanyPage(),
                      );
                      if (result == true) {
                        companyState.getCompany();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: appColors.mainColor,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: appColors.white,
                          size: fixSize * 0.035,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: fixSize * 0.005,
              ),
              CustomTextFieldWithTitle(
                keyBoardType: TextInputType.number,
                inputFormatter: [
                  CustomNumberFormatter(),
                ],
                controller: contractState.totalWeight,
                title: "ນ້ຳໜັກແຮ່ທາດລວມ",
                hint: "ນ້ຳໜັກແຮ່ທາດລວມ",
                trailingText: "ໂຕນ",
              ),
              SizedBox(
                height: fixSize * 0.005,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFieldWithTitle(
                      keyBoardType: TextInputType.number,
                      inputFormatter: [
                        CustomNumberFormatter(),
                      ],
                      controller: contractState.shippingPrice,
                      title: "ຄ່າຂົນສົ່ງ",
                      hint: "ຄ່າຂົນສົ່ງ",
                      trailingText: "  \$",
                      trailingSize: fixSize * 0.012,
                    ),
                  ),
                  SizedBox(
                    width: fixSize * 0.008,
                  ),
                  Expanded(
                    child: CustomTextFieldWithTitle(
                      keyBoardType: TextInputType.number,
                      controller: contractState.weightCal,
                      inputFormatter: [
                        CustomNumberFormatter(),
                      ],
                      title: "ນ້ຳໜັກຄິດໄລ່",
                      hint: "ນ້ຳໜັກຄິດໄລ່",
                      trailingText: "ໂຕນ",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: fixSize * 0.005,
              ),
              Row(
                children: [
                  CustomDatePicker(
                    type: SelectDateType.startDate,
                    title: "ວັນທີເພິ່ມສັນຍາ",
                  ),
                  SizedBox(
                    width: fixSize * 0.008,
                  ),
                  CustomDatePicker(
                    type: SelectDateType.endDate,
                    title: "ວັນທີຄົບກຳນົດສັນຍາ",
                  ),
                ],
              ),
              SizedBox(
                height: fixSize * 0.005,
              ),
              CustomTextFieldWithTitle(
                controller: contractState.note,
                title: "ໝາຍເຫດ",
                hint: "ໝາຍເຫດ",
              ),
              SizedBox(
                height: fixSize * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColors.grey.withOpacity(0.75),
                    ),
                    onPressed: () async {
                      contractState.initData(widget.contractModel);
                    },
                    child: Center(
                      child: CustomText(
                        text: "ກັບຄືນ",
                        color: appColors.white,
                        fontSize: fixSize * 0.013,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColors.mainColor,
                    ),
                    onPressed: () async {
                      CustomDialogs().dialogLoading();
                      try {
                        await contractState
                            .editContract(
                                contractId: widget.contractModel.id.toString())
                            .then((value) {
                          Get.back();
                          CustomDialogs().showToast(
                            context: context,
                            text: "${jsonDecode(value.body)['message']}",
                            backgroundColor:
                                appColors.mainColor.withOpacity(0.75),
                          );
                          if (mounted) {
                            Get.back();
                          }
                          Get.back();
                        });
                      } catch (e) {
                        Get.back();
                        if (e.toString() == "fill_info_error") {
                          return CustomDialogs().showToast(
                            context: context,
                            text: "ກະລຸນາປ້ອນຂໍ້ມູນໃຫ້ຄົບ",
                            backgroundColor:
                                appColors.mainColor.withOpacity(0.75),
                          );
                        }
                        if (e.toString() == "company_select_error") {
                          return CustomDialogs().showToast(
                            context: context,
                            text: "ກະລຸນາເລືອກບໍລິສັດ",
                            backgroundColor:
                                appColors.mainColor.withOpacity(0.75),
                          );
                        }
                        if (e.toString() == "date_error") {
                          return CustomDialogs().showToast(
                            context: context,
                            text: "ວັນທີບໍ່ຖືກຕ້ອງ",
                            backgroundColor:
                                appColors.mainColor.withOpacity(0.75),
                          );
                        }
                        return CustomDialogs().showToast(
                          context: context,
                          text: "ມີບາງຢ່າງຜິດພາດ",
                          backgroundColor:
                              appColors.mainColor.withOpacity(0.75),
                        );
                      }
                    },
                    child: Center(
                      child: CustomText(
                        text: "ບັນທຶກ",
                        color: appColors.white,
                        fontSize: fixSize * 0.013,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: fixSize * 0.025,
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColors.grey.withOpacity(0.75),
                    ),
                    onPressed: () async {
                      var res = await CustomDialogs().yesAndNoDialogWithText(
                          context,
                          fixSize,
                          'ທ່ານຕ້ອງການຍົກເລີກສັນຍານີ້ແທ້ ຫຼື ບໍ່?');
                      if (res == true) {
                        Get.back(result: "cancel_contract");
                      }
                    },
                    child: Center(
                      child: CustomText(
                        text: "ຍົກເລິກສັນຍາ",
                        color: appColors.white,
                        fontSize: fixSize * 0.013,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

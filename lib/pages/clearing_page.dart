import 'package:bauxite_admin_app/customs/custom_app_bar.dart';
import 'package:bauxite_admin_app/customs/custom_date_picker.dart';
import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/customs/custom_input_format.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/dashboard_info_widget.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';
import 'package:bauxite_admin_app/functions/format_date_time2.dart';
import 'package:bauxite_admin_app/functions/format_price.dart';
import 'package:bauxite_admin_app/pages/clearing_detail.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/clearing_state.dart';
import 'package:bauxite_admin_app/state/custom_date_picker_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClearingPage extends StatefulWidget {
  const ClearingPage({
    super.key,
    required this.contractId,
  });
  final String contractId;
  @override
  State<ClearingPage> createState() => _ClearingPageState();
}

class _ClearingPageState extends State<ClearingPage> {
  final AppColors appColors = AppColors();

  CustomDatePickerState customDatePickerState = CustomDatePickerState();
  ClearingState clearingState = Get.put(ClearingState());
  @override
  void dispose() {
    clearingState.servicePriceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    customDatePickerState.initData();
    clearingState.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return Scaffold(
      appBar: CustomAppBar(
        orientation: orientation,
        height: size.height,
        title: "ຊຳລະເງິນ",
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: fixSize * 0.005,
                  ),
                  DashboardInfo(
                    title: "ມູນຄ່າຂົນສົ່ງ",
                    value: "18\$ / 10,000",
                    unit: "ໂຕນ",
                    color: appColors.mainColor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: fixSize * 0.008,
                    ),
                    child: Row(
                      children: [
                        CustomText(
                          text: "ເລືອກວັນທີ ຫາ ວັນທີ",
                          color: appColors.black,
                          fontSize: fixSize * 0.0145,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: fixSize * 0.008,
                    ),
                    child: Row(
                      children: [
                        CustomDatePicker(
                          title: "ວັນທີເລິ່ມຕົ້ນ",
                          type: SelectDateType.startDate,
                          afterSelect: () async {
                            await clearingState.getData();
                          },
                        ),
                        SizedBox(
                          width: fixSize * 0.008,
                        ),
                        CustomDatePicker(
                          title: "ວັນທີສິ້ນສຸດ",
                          type: SelectDateType.endDate,
                          afterSelect: () async {
                            await clearingState.getData();
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: fixSize * 0.008,
                    ),
                    child: Divider(
                      color: appColors.grey.withOpacity(
                        0.5,
                      ),
                    ),
                  ),
                  GetBuilder<ClearingState>(builder: (clearing) {
                    if (!clearing.check) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: appColors.mainColor,
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              activeColor: appColors.mainColor,
                              value: clearing.selectAll,
                              onChanged: (value) {
                                clearing.setAllSelect(
                                  value!,
                                );
                              },
                            ),
                            CustomText(
                              text:
                                  "ທັງໝົດ ${clearing.clearingList.length} ລາຍການ",
                              color: appColors.black,
                              fontSize: fixSize * 0.012,
                            ),
                          ],
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: clearing.clearingList.length,
                          itemBuilder: (
                            context,
                            index,
                          ) {
                            return Row(
                              children: [
                                Checkbox(
                                  activeColor: appColors.mainColor,
                                  value: clearing.clearingList[index].select,
                                  onChanged: (value) {
                                    clearing.setSelect(
                                      index,
                                      value!,
                                    );
                                  },
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: fixSize * 0.008,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text:
                                                  "ລະຫັດ ${clearing.clearingList[index].scanDetail.code}",
                                              color: appColors.black,
                                              fontSize: fixSize * 0.012,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            CustomText(
                                              text:
                                                  "ວັນທີ ${FormatDateTime2(dateTime: clearing.clearingList[index].scanDetail.createdAt.toString()).toString()}",
                                              color: appColors.black,
                                              fontSize: fixSize * 0.01,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text:
                                                  "${clearing.clearingList[index].scanDetail.carModel?.name}",
                                              color: appColors.black,
                                              fontSize: fixSize * 0.012,
                                            ),
                                            CustomText(
                                              text:
                                                  "+${FormatPrice(price: num.parse(clearing.clearingList[index].scanDetail.actualWeight.toString()))} ໂຕນ",
                                              color: appColors.mainColor,
                                              fontSize: fixSize * 0.012,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (
                            context,
                            index,
                          ) =>
                              const Divider(),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(
              fixSize * 0.008,
            ),
            decoration: BoxDecoration(
              color: appColors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "ນ້ຳໜັກແຮ່ທາດ",
                      color: appColors.black,
                      fontSize: fixSize * 0.0135,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: "ເປັນເງິນ",
                      color: appColors.black,
                      fontSize: fixSize * 0.0135,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                SizedBox(
                  height: fixSize * 0.005,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<ClearingState>(
                      builder: (clearing) {
                        return CustomText(
                          text: "${FormatPrice(
                            price: clearing.clearingList
                                .where((element) => element.select)
                                .fold(
                                  num.parse("0.0"),
                                  (value, element) => (value +
                                      num.parse(
                                        element.scanDetail.actualWeight
                                            .toString(),
                                      )),
                                ),
                          )} ໂຕນ",
                          color: appColors.mainColor,
                          fontSize: fixSize * 0.0135,
                          fontWeight: FontWeight.bold,
                        );
                      },
                    ),
                    GetBuilder<ClearingState>(
                      builder: (clearing) {
                        return CustomText(
                          text: "${FormatPrice(
                            price: clearing.clearingList
                                .where((element) => element.select)
                                .fold(
                                  num.parse("0.0"),
                                  (value, element) => (value +
                                      (num.parse(
                                            element.scanDetail.actualWeight
                                                .toString(),
                                          ) *
                                          num.parse(
                                            element.scanDetail.contractModel!
                                                .shippingPriceCal
                                                .toString(),
                                          ) /
                                          num.parse(
                                            element.scanDetail.contractModel!
                                                .weightPriceCal
                                                .toString(),
                                          ))),
                                ),
                          )}\$",
                          color: appColors.mainColor,
                          fontSize: fixSize * 0.0135,
                          fontWeight: FontWeight.bold,
                        );
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: fixSize * 0.005,
                ),
                TextFieldWidget(
                  keyboardType: TextInputType.number,
                  controller: clearingState.servicePriceController,
                  inputFormatters: [
                    CustomNumberFormatter(),
                  ],
                  hintText: "ມູນຄ່າເພິ່ມເຕີມ",
                  suffixIcon: Icon(
                    Icons.attach_money,
                    color: appColors.mainColor,
                    size: fixSize * 0.018,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              if (clearingState.clearingList
                  .where((element) => element.select)
                  .isEmpty) {
                return CustomDialogs().showToast(
                  context: context,
                  text: "ກະລຸນາເລືອກທຸລະກຳອ້າງອີງ",
                );
              }
              var result = await Get.to(
                  () => ClearingDetail(contractId: widget.contractId));
              if (result != null) {
                if (result) {
                  if (mounted) {
                    CustomDialogs()
                        .showToast(context: context, text: "ທຸລະກຳສຳເລັດ");
                    Get.until((route) => Get.currentRoute == "/ContractDetail");
                  }
                }
              }
            },
            child: Container(
              height: size.height * 0.075,
              decoration: BoxDecoration(
                color: appColors.mainColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: fixSize * 0.005,
                    color: appColors.black.withOpacity(
                      0.5,
                    ),
                  ),
                ],
              ),
              child: Center(
                child: CustomText(
                  text: "ຊຳລະເງິນ",
                  color: appColors.white,
                  fontSize: fixSize * 0.02,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

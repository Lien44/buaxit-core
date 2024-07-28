import 'package:bauxite_admin_app/customs/custom_app_bar.dart';
import 'package:bauxite_admin_app/customs/custom_date_picker.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/dashboard_info_widget.dart';
import 'package:bauxite_admin_app/functions/format_price.dart';
import 'package:bauxite_admin_app/pages/clearing_history_detail_page.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/clearing_history_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClearingHistory extends StatefulWidget {
  const ClearingHistory({super.key});

  @override
  State<ClearingHistory> createState() => _ClearingHistoryState();
}

class _ClearingHistoryState extends State<ClearingHistory> {
  final AppColors appColors = AppColors();

  final ClearingHistoryState clearingHistoryState =
      Get.put(ClearingHistoryState());

  @override
  void initState() {
    clearingHistoryState.customDatePickerState.initData();
    clearingHistoryState.getData();
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
          title: "ປະຫວັດການຊຳລະ",
        ),
        body: Column(
          children: [
            SizedBox(
              height: fixSize * 0.01,
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
                      await clearingHistoryState.getData();
                    },
                  ),
                  SizedBox(
                    width: fixSize * 0.008,
                  ),
                  CustomDatePicker(
                    title: "ວັນທີສິ້ນສຸດ",
                    type: SelectDateType.endDate,
                    afterSelect: () async {
                      await clearingHistoryState.getData();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: fixSize * 0.008,
            ),
            GetBuilder<ClearingHistoryState>(builder: (get) {
              if (!get.check) {
                return DashboardInfo(
                  title: "ນ້ຳໜັກແຮ່ທາດ",
                  value: "...",
                  unit: "ໂຕນ",
                );
              }
              return DashboardInfo(
                title: "ນ້ຳໜັກແຮ່ທາດ",
                value:
                    "${FormatPrice(price: num.parse(get.clearingHistoryModel?.metalWeight.toString() ?? "0"))}",
                unit: "ໂຕນ",
              );
            }),
            GetBuilder<ClearingHistoryState>(builder: (get) {
              if (!get.check) {
                return DashboardInfo(
                  title: "ເປັນເງິນ",
                  value: "...",
                  unit: "\$",
                );
              }
              return DashboardInfo(
                title: "ເປັນເງິນ",
                value:
                    "${FormatPrice(price: num.parse(get.clearingHistoryModel?.totalPrice.toString() ?? "0"))}",
                unit: "\$",
              );
            }),
            Expanded(
              child: GetBuilder<ClearingHistoryState>(
                builder: (get) {
                  if (!get.check) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: appColors.mainColor,
                      ),
                    );
                  }
                  if (get.clearingHistoryModel == null) {
                    return Center(
                      child: CustomText(
                        text: "ກະລຸນາເລືອກວັນທີ",
                        color: appColors.black,
                        fontSize: fixSize * 0.012,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: get.clearingHistoryModel!.data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          Get.to(
                            () => ClearingHistoryDetail(listIndex: index),
                            transition: Transition.rightToLeft,
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: fixSize * 0.008,
                            right: fixSize * 0.008,
                            left: fixSize * 0.008,
                          ),
                          padding: EdgeInsets.all(
                            fixSize * 0.008,
                          ),
                          decoration: BoxDecoration(
                            color: appColors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: fixSize * 0.0025,
                                color: appColors.black.withOpacity(
                                  0.5,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(
                              fixSize * 0.0025,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: get.clearingHistoryModel?.data?[index]
                                            .contractId?.companyId?.name ??
                                        "",
                                    color: appColors.mainColor,
                                    fontSize: fixSize * 0.0135,
                                  ),
                                  CustomText(
                                    text: get.clearingHistoryModel?.data?[index]
                                            .createdAt ??
                                        "",
                                    color: appColors.black,
                                    fontSize: fixSize * 0.011,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "ລະຫັດທຸລະກຳ",
                                    color: appColors.black,
                                    fontSize: fixSize * 0.011,
                                  ),
                                  CustomText(
                                    text: get.clearingHistoryModel?.data?[index]
                                            .code ??
                                        "",
                                    color: appColors.black,
                                    fontSize: fixSize * 0.011,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "ນ້ຳໜັກແຮ່ທາດ",
                                    color: appColors.black,
                                    fontSize: fixSize * 0.011,
                                  ),
                                  CustomText(
                                    text: FormatPrice(
                                      price: num.parse(get.clearingHistoryModel
                                              ?.data?[index].totalMetalWeight ??
                                          "0"),
                                    ).toString(),
                                    color: appColors.black,
                                    fontSize: fixSize * 0.011,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "ເປັນເງິນ",
                                    color: appColors.black,
                                    fontSize: fixSize * 0.011,
                                  ),
                                  CustomText(
                                    text: "${FormatPrice(
                                      price: num.parse(get.clearingHistoryModel
                                              ?.data?[index].totalPrice ??
                                          "0"),
                                    )} \$",
                                    color: appColors.mainColor,
                                    fontSize: fixSize * 0.011,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: "ສູດຄິດໄລ່",
                                    color: appColors.black,
                                    fontSize: fixSize * 0.011,
                                  ),
                                  CustomText(
                                    text: "${FormatPrice(
                                      price: num.parse(get.clearingHistoryModel
                                              ?.data?[index].calPrice ??
                                          "0"),
                                    )}\$/${FormatPrice(
                                      price: num.parse(get.clearingHistoryModel
                                              ?.data?[index].calWeight ??
                                          "0"),
                                    )} ໂຕນ",
                                    color: appColors.mainColor,
                                    fontSize: fixSize * 0.011,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}

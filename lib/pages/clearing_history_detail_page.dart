import 'package:bauxite_admin_app/customs/custom_app_bar.dart';

import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/functions/format_date_time2.dart';

import 'package:bauxite_admin_app/functions/format_price.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/clearing_history_state.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ClearingHistoryDetail extends StatelessWidget {
  ClearingHistoryDetail({
    super.key,
    required this.listIndex,
  });
  final AppColors appColors = AppColors();
  final ClearingHistoryState clearingHistoryState =
      Get.put(ClearingHistoryState());
  final int listIndex;
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return Scaffold(
      appBar: CustomAppBar(
        orientation: orientation,
        height: size.height,
        title: "ລາຍລະອຽດການຊຳລະເງິນ",
      ),
      body: GetBuilder<ClearingHistoryState>(builder: (detail) {
        if (!detail.check) {
          return Center(
            child: CircularProgressIndicator(
              color: appColors.mainColor,
            ),
          );
        }
        return Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
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
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "ຊື່ບໍລິສັດ",
                            color: appColors.black,
                            fontSize: fixSize * 0.012,
                          ),
                          CustomText(
                            text:
                                "${detail.clearingHistoryModel!.data![listIndex].scanDetail[0].contractModel!.companyId?.name}",
                            color: appColors.black,
                            fontSize: fixSize * 0.016,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: fixSize * 0.005,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "ຈຳນວນທຸລະກຳ",
                            color: appColors.black,
                            fontSize: fixSize * 0.012,
                          ),
                          CustomText(
                            text:
                                "${detail.clearingHistoryModel!.data![listIndex].scanDetail.length} ລາຍການ",
                            color: appColors.black,
                            fontSize: fixSize * 0.012,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: fixSize * 0.005,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "ສູດຄິດໄລ່",
                            color: appColors.black,
                            fontSize: fixSize * 0.011,
                          ),
                          CustomText(
                            text: "${FormatPrice(
                              price: num.parse(detail.clearingHistoryModel!
                                      .data![listIndex].calPrice ??
                                  "0"),
                            )}\$/${FormatPrice(
                              price: num.parse(detail.clearingHistoryModel!
                                      .data![listIndex].calWeight ??
                                  "0"),
                            )} ໂຕນ",
                            color: appColors.mainColor,
                            fontSize: fixSize * 0.011,fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: fixSize * 0.005,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "ນ້ຳໜັກແຮ່ທາດ",
                            color: appColors.black,
                            fontSize: fixSize * 0.012,
                          ),
                          CustomText(
                            text:
                                "${FormatPrice(price: num.parse(detail.clearingHistoryModel!.data![listIndex].totalMetalWeight ?? "0"))} ໂຕນ",
                            color: appColors.mainColor,
                            fontSize: fixSize * 0.012,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: fixSize * 0.005,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "ຄ່າຂົນສົ່ງ",
                            color: appColors.black,
                            fontSize: fixSize * 0.012,
                          ),
                          CustomText(
                            text:
                                "${FormatPrice(price: num.parse(detail.clearingHistoryModel!.data![listIndex].metalPrice ?? "0"))}\$",
                            color: appColors.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: fixSize * 0.012,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: fixSize * 0.005,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "ມູນຄ່າເພິ່ມເຕີມ",
                            color: appColors.black,
                            fontSize: fixSize * 0.012,
                          ),
                          CustomText(
                            text:
                                "${FormatPrice(price: num.parse(detail.clearingHistoryModel!.data![listIndex].servicePrice ?? "0"))} \$",
                            color: appColors.mainColor,
                            fontSize: fixSize * 0.012,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: fixSize * 0.005,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "ລວມເປັນເງິນ",
                            color: appColors.black,
                            fontSize: fixSize * 0.012,
                          ),
                          CustomText(
                            text:
                                "${FormatPrice(price: num.parse(detail.clearingHistoryModel!.data![listIndex].totalPrice ?? "0"))} \$",
                            color: appColors.mainColor,
                            fontSize: fixSize * 0.012,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(
                  fixSize * 0.008,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: fixSize * 0.0025,
                      ),
                      child: CustomText(
                        text: "ລາຍລະອຽດ",
                        color: appColors.black,
                        fontSize: fixSize * 0.01,
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: detail.clearingHistoryModel!.data![listIndex]
                            .scanDetail.length,
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          var data = detail.clearingHistoryModel!
                              .data![listIndex].scanDetail;
                          return Padding(
                            padding: EdgeInsets.only(
                              right: fixSize * 0.008,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "ລະຫັດ ${data[index].code}",
                                      color: appColors.black,
                                      fontSize: fixSize * 0.012,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      text:
                                          "ວັນທີ ${FormatDateTime2(dateTime: data[index].createdAt.toString()).toString()}",
                                      color: appColors.black,
                                      fontSize: fixSize * 0.01,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text:
                                          "${data[index].carModel?.name}",
                                      color: appColors.black,
                                      fontSize: fixSize * 0.012,
                                    ),
                                    CustomText(
                                      text:
                                          "+${FormatPrice(price: num.parse(data[index].metalWeight.toString()))} ໂຕນ",
                                      color: appColors.mainColor,
                                      fontSize: fixSize * 0.012,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (
                          context,
                          index,
                        ) =>
                            const Divider(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

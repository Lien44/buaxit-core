import 'package:bauxite_admin_app/customs/custom_app_bar.dart';
import 'package:bauxite_admin_app/customs/custom_dialog.dart';

import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/functions/format_date_time2.dart';

import 'package:bauxite_admin_app/functions/format_price.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/clearing_state.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ClearingDetail extends StatelessWidget {
  ClearingDetail({
    super.key,
    required this.contractId,
  });
  final AppColors appColors = AppColors();
  final ClearingState clearingState = Get.put(ClearingState());
  final String contractId;
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
      body: GetBuilder<ClearingState>(builder: (detail) {
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
                                "${detail.clearingList[0].scanDetail.contractModel?.companyId?.name}",
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
                                "${detail.clearingList.where((element) => element.select).length} ລາຍການ",
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
                            text: "ນ້ຳໜັກແຮ່ທາດ",
                            color: appColors.black,
                            fontSize: fixSize * 0.012,
                          ),
                          CustomText(
                            text: "${FormatPrice(
                              price: detail.clearingList
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
                            text: "${FormatPrice(
                              price: detail.clearingList
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
                            text: "${FormatPrice(
                              price: detail.servicePriceController.text.isEmpty
                                  ? 0.0
                                  : num.parse(
                                      detail.servicePriceController.text),
                            )} \$",
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
                            text: "${FormatPrice(
                              price: (detail.servicePriceController.text.isEmpty
                                  ? detail.clearingList
                                      .where((element) => element.select)
                                      .fold(
                                        num.parse("0.0"),
                                        (value, element) => (value +
                                            (num.parse(
                                                  element
                                                      .scanDetail.actualWeight
                                                      .toString(),
                                                ) *
                                                num.parse(
                                                  element
                                                      .scanDetail
                                                      .contractModel!
                                                      .shippingPriceCal
                                                      .toString(),
                                                ) /
                                                num.parse(
                                                  element
                                                      .scanDetail
                                                      .contractModel!
                                                      .weightPriceCal
                                                      .toString(),
                                                ))),
                                      )
                                  : num.parse(
                                          detail.servicePriceController.text) +
                                      detail.clearingList
                                          .where((element) => element.select)
                                          .fold(
                                            num.parse("0.0"),
                                            (value, element) => (value +
                                                (num.parse(
                                                      element.scanDetail
                                                          .actualWeight
                                                          .toString(),
                                                    ) *
                                                    num.parse(
                                                      element
                                                          .scanDetail
                                                          .contractModel!
                                                          .shippingPriceCal
                                                          .toString(),
                                                    ) /
                                                    num.parse(
                                                      element
                                                          .scanDetail
                                                          .contractModel!
                                                          .weightPriceCal
                                                          .toString(),
                                                    ))),
                                          )),
                            )} \$",
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
                        itemCount: detail.clearingList
                            .where((element) => element.select)
                            .length,
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          var data = detail.clearingList
                              .where((element) => element.select)
                              .toList();
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
                                      text:
                                          "ລະຫັດ ${data[index].scanDetail.code}",
                                      color: appColors.black,
                                      fontSize: fixSize * 0.012,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      text:
                                          "ວັນທີ ${FormatDateTime2(dateTime: data[index].scanDetail.createdAt.toString()).toString()}",
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
                                          "${data[index].scanDetail.carModel?.name}",
                                      color: appColors.black,
                                      fontSize: fixSize * 0.012,
                                    ),
                                    CustomText(
                                      text:
                                          "+${FormatPrice(price: num.parse(data[index].scanDetail.actualWeight.toString()))} ໂຕນ",
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
            InkWell(
              onTap: () async {
                await CustomDialogs()
                    .yesAndNoDialogWithText(
                        context, fixSize, "ຕ້ອງການຢືນຢັນການຊຳລະ ຫຼື ບໍ່?")
                    .then((value) async {
                  if (value) {
                    CustomDialogs().loadingDialog(context, fixSize);
                    try {
                      var res = await clearingState.addClearing(
                          contractId: contractId);
                      Get.back();
                      if (res.statusCode == 200) {
                        Get.back(result: true);
                      } else {
                        throw res.body;
                      }
                    } catch (e) {
                      Get.back();
                      CustomDialogs().showToast(
                        context: context,
                        text: "ມີບາງຢ່າງຜິດພາດ",
                      );
                    }
                  }
                });
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
                    text: "ຢືນຢັນການຊຳລະເງິນ",
                    color: appColors.white,
                    fontSize: fixSize * 0.02,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

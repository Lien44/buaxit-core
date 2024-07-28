// ignore_for_file: use_build_context_synchronously

import 'package:bauxite_admin_app/customs/custom_app_bar.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/functions/format_date.dart';
import 'package:bauxite_admin_app/functions/format_price.dart';
import 'package:bauxite_admin_app/models/contract_model.dart';
import 'package:bauxite_admin_app/pages/clearing_history.dart';
import 'package:bauxite_admin_app/pages/clearing_page.dart';
import 'package:bauxite_admin_app/pages/edit_contract_page.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/contract_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContractDetail extends StatelessWidget {
  ContractDetail({super.key, required this.contractModel});
  final AppColors appColors = AppColors();
  final ContractModel contractModel;
  final ContractDetailState contractDetailState = Get.put(
    ContractDetailState(),
  );
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return Scaffold(
      appBar: CustomAppBar(
        orientation: orientation,
        height: size.height,
        title: "ລາຍລະອຽດສັນຍາ",
        actions: [
          IconButton(
            tooltip: 'ແກ້ໄຂສັນຍາ',
            onPressed: () async {
              var result = await Get.to(
                () => EditContarctPage(contractModel: contractModel),
                transition: Transition.rightToLeft,
              );
              if (result != null) {
                if (result == "cancel_contract") {
                  contractDetailState.cancelContract(
                      context: context,
                      contractId: contractModel.id.toString());
                }
              }
            },
            icon: Icon(
              Icons.edit,
              color: appColors.white,
              size: fixSize * 0.025,
            ),
          ),
          IconButton(
            onPressed: () async {
              Get.to(
                () => const ClearingHistory(),
                transition: Transition.rightToLeft,
              );
            },
            icon: Icon(
              Icons.history,
              color: appColors.white,
              size: fixSize * 0.025,
            ),
          ),
        ],
      ),
      body: GetBuilder<ContractDetailState>(builder: (detail) {
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
                            text:
                                "${detail.contractDetailModel?.contract?.companyId?.name}",
                            color: appColors.mainColor,
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
                            text: "ລະຫັດສັນຍາ",
                            color: appColors.black,
                            fontSize: fixSize * 0.012,
                          ),
                          CustomText(
                            text:
                                "${detail.contractDetailModel?.contract?.code}",
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
                            text: "ມູນຄ່າຂົນສົ່ງ",
                            color: appColors.black,
                            fontSize: fixSize * 0.012,
                          ),
                          CustomText(
                            text: "${FormatPrice(
                              price: num.parse(detail.contractDetailModel
                                      ?.contract?.shippingPriceCal ??
                                  "0"),
                            )}\$ / ${FormatPrice(
                              price: num.parse(detail.contractDetailModel
                                      ?.contract?.weightPriceCal ??
                                  "0"),
                            )} ໂຕນ",
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
                            text: "ວັນທີເພິ່ມສັນຍາ",
                            color: appColors.black,
                            fontSize: fixSize * 0.012,
                          ),
                          CustomText(
                            text: FormatDate(
                              dateTime: detail
                                  .contractDetailModel?.contract?.startDate,
                            ).toString(),
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
                            text: "ວັນທີຄົບກຳນົດສັນຍາ",
                            color: appColors.black,
                            fontSize: fixSize * 0.012,
                          ),
                          CustomText(
                            text: FormatDate(
                              dateTime:
                                  detail.contractDetailModel?.contract?.endDate,
                            ).toString(),
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
                            text: "ສະຖານະສັນຍາ",
                            color: appColors.black,
                            fontSize: fixSize * 0.012,
                          ),
                          Builder(builder: (context) {
                            if (detail.contractDetailModel!.contract!.status ==
                                1) {
                              return CustomText(
                                text: "ກຳລັງດຳເນີນການ",
                                color: appColors.black,
                                fontSize: fixSize * 0.012,
                              );
                            }
                            if (detail.contractDetailModel!.contract!.status ==
                                2) {
                              return CustomText(
                                text: "ສຳເລັດ",
                                color: appColors.mainColor,
                                fontSize: fixSize * 0.012,
                              );
                            }
                            return const SizedBox();
                          }),
                        ],
                      ),
                      SizedBox(
                        height: fixSize * 0.01,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "ຂົນສົ່ງໄດ້ ${FormatPrice(
                              price: num.parse(detail.contractDetailModel
                                      ?.contract?.actualWeight ??
                                  "0"),
                            )} ໂຕນ",
                            color: appColors.mainColor,
                            fontSize: fixSize * 0.013,
                          ),
                          CustomText(
                            text: "ທັງໝົດ ${FormatPrice(
                              price: num.parse(detail.contractDetailModel
                                      ?.contract?.totalWeight ??
                                  "0"),
                            )} ໂຕນ",
                            color: appColors.black,
                            fontSize: fixSize * 0.013,
                          ),
                        ],
                      ),
                      LinearProgressIndicator(
                        minHeight: fixSize * 0.0065,
                        value: ((double.parse(detail.contractDetailModel
                                    ?.contract?.actualWeight ??
                                "0")) /
                            double.parse(detail.contractDetailModel?.contract
                                    ?.totalWeight ??
                                "0")),
                        color: appColors.mainColor,
                        backgroundColor: appColors.grey,
                      )
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
                        text: "ການເຄື່ອນໄຫວ",
                        color: appColors.black,
                        fontSize: fixSize * 0.01,
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: detail.contractDetailModel!.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text:
                                        "ລະຫັດ ${detail.contractDetailModel!.data![index].code}",
                                    color: appColors.black,
                                    fontSize: fixSize * 0.012,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomText(
                                    text:
                                        "ວັນທີ ${detail.contractDetailModel!.data![index].createdAt}",
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
                                        "${detail.contractDetailModel!.data![index].carModel?.name}",
                                    color: appColors.black,
                                    fontSize: fixSize * 0.012,
                                  ),
                                  CustomText(
                                    text:
                                        "+${detail.contractDetailModel!.data![index].actualWeight} ໂຕນ",
                                    color: appColors.mainColor,
                                    fontSize: fixSize * 0.012,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(
                  () => ClearingPage(
                    contractId: contractModel.id.toString(),
                  ),
                  transition: Transition.rightToLeft,
                );
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
        );
      }),
    );
  }
}

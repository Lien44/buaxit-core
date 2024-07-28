import 'package:bauxite_admin_app/customs/custom_app_bar.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/functions/format_date.dart';
import 'package:bauxite_admin_app/functions/format_price.dart';
import 'package:bauxite_admin_app/models/scan_in_out_model.dart';
import 'package:bauxite_admin_app/pages/confirm_scan_in.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/camera_scan_page_state.dart';
import 'package:bauxite_admin_app/state/car_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanInSelectContract extends StatelessWidget {
  ScanInSelectContract({super.key, this.carModel});
  final AppColors appColors = AppColors();
  final CarModel? carModel;
  final CameraScanPageState cameraScanPageState =
      Get.put(CameraScanPageState());
  final CarState carState = Get.put(CarState());
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return Scaffold(
      appBar: CustomAppBar(
        orientation: orientation,
        height: size.height,
        title: "ເລືອກສັນຍາ",
      ),
      body: GetBuilder<CameraScanPageState>(
        builder: (get) {
          return ListView.builder(
            padding: EdgeInsets.only(
              top: fixSize * 0.008,
            ),
            itemCount: get.listContracts.length,
            itemBuilder: (context, index) {
              return GetBuilder<CarState>(builder: (getCar) {
                return InkWell(
                  onTap: () async {
                    Get.to(
                      () => ConfirmScanInPage(
                        contractModel: get.listContracts[index],
                        carModel: carModel,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(
                      fixSize * 0.008,
                    ),
                    margin: EdgeInsets.only(
                      bottom: fixSize * 0.008,
                      right: fixSize * 0.008,
                      left: fixSize * 0.008,
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
                      borderRadius: BorderRadius.circular(
                        fixSize * 0.005,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: get.listContracts[index].companyId?.name ??
                                  "",
                              color: appColors.mainColor,
                              fontSize: fixSize * 0.016,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomText(
                              text: get.listContracts[index].code ?? "",
                              color: appColors.black,
                              fontSize: fixSize * 0.012,
                            ),
                          ],
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
                              text:
                                  "${FormatPrice(price: num.parse(get.listContracts[index].shippingPriceCal ?? "0"))}\$ / ${FormatPrice(price: num.parse(get.listContracts[index].weightPriceCal ?? "0"))} ໂຕນ",
                              color: appColors.black,
                              fontSize: fixSize * 0.012,
                            ),
                          ],
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
                                dateTime: get.listContracts[index].startDate,
                              ).toString(),
                              color: appColors.black,
                              fontSize: fixSize * 0.012,
                            ),
                          ],
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
                                dateTime: get.listContracts[index].endDate,
                              ).toString(),
                              color: appColors.black,
                              fontSize: fixSize * 0.012,
                            ),
                          ],
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
                              if (get.listContracts[index].status == 1) {
                                return CustomText(
                                  text: "ກຳລັງດຳເນີນການ",
                                  color: appColors.black,
                                  fontSize: fixSize * 0.012,
                                );
                              }
                              if (get.listContracts[index].status == 2) {
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
                          height: fixSize * 0.005,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text:
                                  "ຂົນສົ່ງໄດ້ ${FormatPrice(price: num.parse(get.listContracts[index].currentWeight ?? "0"))} ໂຕນ",
                              color: appColors.mainColor,
                              fontSize: fixSize * 0.013,
                            ),
                            CustomText(
                              text:
                                  "ທັງໝົດ ${FormatPrice(price: num.parse(get.listContracts[index].totalWeight ?? "0"))} ໂຕນ",
                              color: appColors.black,
                              fontSize: fixSize * 0.013,
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          minHeight: fixSize * 0.0065,
                          value: ((double.parse(
                                  get.listContracts[index].currentWeight ??
                                      "0")) /
                              double.parse(
                                  get.listContracts[index].totalWeight ?? "0")),
                          color: appColors.mainColor,
                          backgroundColor: appColors.grey,
                        )
                      ],
                    ),
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }
}

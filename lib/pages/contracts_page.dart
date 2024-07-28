import 'package:bauxite_admin_app/customs/custom_app_bar.dart';
import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/dashboard_info_widget.dart';
import 'package:bauxite_admin_app/customs/refresh_widget.dart';
import 'package:bauxite_admin_app/functions/format_date.dart';
import 'package:bauxite_admin_app/functions/format_price.dart';
import 'package:bauxite_admin_app/pages/add_contract_page.dart';
import 'package:bauxite_admin_app/pages/contract_detail.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/contract_detail_state.dart';
import 'package:bauxite_admin_app/state/contract_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContractsPage extends StatelessWidget {
  ContractsPage({super.key});
  final AppColors appColors = AppColors();
  final ContractState contractState = Get.put(ContractState());
  final ContractDetailState contractDetailState =
      Get.put(ContractDetailState());
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return Scaffold(
      appBar: CustomAppBar(
        orientation: orientation,
        height: size.height,
        title: "contracts",
        actions: [
          IconButton(
            splashRadius: fixSize * 0.015,
            splashColor: appColors.white,
            icon: const Icon(Icons.add),
            iconSize: fixSize * 0.025,
            color: appColors.white,
            onPressed: () async {
              Get.to(
                () => const AddContractPage(),
                transition: Transition.rightToLeft,
              );
            },
          ),
        ],
      ),
      body: GetBuilder<ContractState>(builder: (get) {
        if (!get.check) {
          return Center(
              child: CircularProgressIndicator(
            color: appColors.mainColor,
          ));
        }
        return RefreshWidget(
          onRefresh: () {
            get.getContracts();
          },
          child: Column(
            children: [
              DashboardInfo(
                  title: "ສັນຍາທັງໝົດ",
                  value: "${get.listContracts.length}",
                  unit: "ລາຍການ"),
              Expanded(
                child: ListView.builder(
                  itemCount: get.listContracts.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        CustomDialogs().dialogLoading();
                        await contractDetailState.setContractIdAndInitData(
                          contractId: get.listContracts[index].id.toString(),
                        );
                        Get.back();
                        await Get.to(
                          () => ContractDetail(
                            contractModel: get.listContracts[index],
                          ),
                          transition: Transition.rightToLeft,
                        );
                        get.getContracts();
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
                                  text: get.listContracts[index].companyId
                                          ?.name ??
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
                                    dateTime:
                                        get.listContracts[index].startDate,
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
                                // CustomText(
                                //   text:
                                //       "ຂົນສົ່ງໄດ້ ${FormatPrice(price: num.parse(get.listContracts[index].currentWeight ?? "0"))} ໂຕນ",
                                //   color: appColors.mainColor,
                                //   fontSize: fixSize * 0.013,
                                // ),
                                   CustomText(
                                  text:
                                      "ຂົນສົ່ງໄດ້ ${FormatPrice(price: num.parse(get.listContracts[index].actualWeight ?? "0"))} ໂຕນ",
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
                                      get.listContracts[index].actualWeight ??
                                          "0")) /
                                  double.parse(
                                      get.listContracts[index].totalWeight ??
                                          "0")),
                              color: appColors.mainColor,
                              backgroundColor: appColors.grey,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

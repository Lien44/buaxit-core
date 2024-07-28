import 'package:bauxite_admin_app/customs/custom_app_bar.dart';
import 'package:bauxite_admin_app/customs/custom_date_picker.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/drop_down_widget.dart';
import 'package:bauxite_admin_app/functions/format_price.dart';
import 'package:bauxite_admin_app/pages/export_excel.dart';
import 'package:bauxite_admin_app/pages/history_export_excel.dart';

import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/company_state.dart';
import 'package:bauxite_admin_app/state/custom_date_picker_state.dart';

import 'package:bauxite_admin_app/state/report_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportPage extends StatelessWidget {
  ReportPage({super.key});
  final AppColors appColors = AppColors();
  final ReportState reportState = Get.put(ReportState());
  final CompanyState companyState = Get.put(CompanyState());
  final CustomDatePickerState customDatePickerState =
      Get.put(CustomDatePickerState());

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
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const HistoryExportExcelPage());
            },
            icon: Icon(
              Icons.history,
              color: appColors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(
              fixSize * 0.012,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GetBuilder<CompanyState>(builder: (company) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'company',
                              fontSize: fixSize * 0.0145,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: DropDownWidget(
                                      fixSize: fixSize,
                                      value: companyState.selectedCompany,
                                      hint: "company",
                                      listMenuItems: companyState.companyList
                                          .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: CustomText(
                                                text: e.name ?? "",
                                              )))
                                          .toList(),
                                      onChange: (value) async {
                                        await company.selectCompany(value);
                                        reportState.getData();
                                      }),
                                ),
                                companyState.selectedCompany != null
                                    ? IconButton(
                                        onPressed: () {
                                          companyState.selectedCompany = null;
                                          companyState.update();
                                          reportState.getData();
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: appColors.mainColor,
                                          size: fixSize * 0.025,
                                        ))
                                    : const SizedBox()
                              ],
                            ),
                          ],
                        );
                      }),
                    ),
                    orientation == Orientation.landscape
                        ? SizedBox(
                            width: fixSize * 0.025,
                          )
                        : const SizedBox(),
                    orientation == Orientation.landscape
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomDatePicker(
                                title: "ວັນທີເລິ່ມຕົ້ນ",
                                type: SelectDateType.startDate,
                                afterSelect: () async {
                                  await reportState.getData();
                                },
                              ),
                              SizedBox(
                                width: fixSize * 0.008,
                              ),
                              CustomDatePicker(
                                title: "ວັນທີສິ້ນສຸດ",
                                type: SelectDateType.endDate,
                                afterSelect: () async {
                                  await reportState.getData();
                                },
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
          orientation == Orientation.portrait
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDatePicker(
                      title: "ວັນທີເລິ່ມຕົ້ນ",
                      type: SelectDateType.startDate,
                      afterSelect: () async {
                        await reportState.getData();
                      },
                    ),
                    SizedBox(
                      width: fixSize * 0.008,
                    ),
                    CustomDatePicker(
                      title: "ວັນທີສິ້ນສຸດ",
                      type: SelectDateType.endDate,
                      afterSelect: () async {
                        await reportState.getData();
                      },
                    ),
                  ],
                )
              : const SizedBox(),
          SizedBox(
            height: fixSize * 0.008,
          ),
          Row(
            children: [
              SizedBox(
                width: fixSize * 0.008,
              ),
              GetBuilder<ReportState>(builder: (report) {
                if (!report.check) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: appColors.mainColor,
                    ),
                  );
                }
                return CustomText(
                  text:
                      'ທັງໝົດ ${report.reportModel?.data?.length ?? 0} ລາຍການ',
                  fontSize: fixSize * 0.0125,
                );
              }),
            ],
          ),
          Expanded(
            child: GetBuilder<ReportState>(
              builder: (report) {
                if (!report.check) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: appColors.mainColor,
                    ),
                  );
                }
                if (report.reportModel == null) {
                  return Center(
                    child: CustomText(
                      text: "ກະລຸນາເລືອກວັນທີ",
                      color: appColors.black,
                      fontSize: fixSize * 0.012,
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.all(
                    fixSize * 0.008,
                  ),
                  itemCount: report.reportModel!.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                        top: fixSize * 0.008,
                      ),
                      padding: EdgeInsets.all(fixSize * 0.008),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text:
                                    '${report.reportModel!.data![index].contractId?.companyId?.name}',
                                fontSize: fixSize * 0.013,
                              ),
                              CustomText(
                                text:
                                    '${report.reportModel!.data![index].contractId?.code}',
                                fontSize: fixSize * 0.013,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: fixSize * 0.005,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'ທັງໝົດ',
                                fontSize: fixSize * 0.013,
                              ),
                              CustomText(
                                text:
                                    '${FormatPrice(price: num.parse(report.reportModel!.data![index].contractId?.totalWeight ?? "0"))} ໂຕນ',
                                fontSize: fixSize * 0.013,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: fixSize * 0.005,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'ຂົນສົ່ງໄດ້',
                                fontSize: fixSize * 0.013,
                              ),
                              CustomText(
                                text:
                                    '${FormatPrice(price: num.parse(report.reportModel!.data![index].contractId?.currentWeight ?? "0"))} ໂຕນ',
                                fontSize: fixSize * 0.013,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: fixSize * 0.005,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'ມູນຄ່າຂົນສົ່ງ',
                                fontSize: fixSize * 0.013,
                              ),
                              CustomText(
                                text:
                                    '${FormatPrice(price: num.parse(report.reportModel!.data![index].totalPrice ?? "0"))} \$',
                                fontSize: fixSize * 0.013,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          GetBuilder<ReportState>(builder: (report) {
            if (!report.check) {
              return Center(
                child: CircularProgressIndicator(
                  color: appColors.mainColor,
                ),
              );
            }
            if (report.reportModel == null) {
              return const SizedBox();
            }
            return Container(
              padding: EdgeInsets.all(fixSize * 0.008),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: appColors.black.withOpacity(
                      0.5,
                    ),
                    blurRadius: fixSize * 0.005,
                  ),
                ],
                color: appColors.white,
              ),
              child: orientation == Orientation.portrait
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'ນ້ຳໜັກລວມ',
                              fontSize: fixSize * 0.0145,
                            ),
                            CustomText(
                              text:
                                  '${FormatPrice(price: report.reportModel!.totalWeightAll ?? 0.0)} ໂຕນ',
                              fontSize: fixSize * 0.0145,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: fixSize * 0.005,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'ນ້ຳໜັກສົ່ງສຳເລັດລວມ',
                              fontSize: fixSize * 0.0145,
                            ),
                            CustomText(
                              text:
                                  '${FormatPrice(price: report.reportModel!.totalWeightSuccess ?? 0.0)} ໂຕນ',
                              fontSize: fixSize * 0.0145,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: fixSize * 0.005,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'ຄ່າຂຳນສົ່ງລວມ',
                              fontSize: fixSize * 0.0145,
                            ),
                            CustomText(
                              text:
                                  '${FormatPrice(price: report.reportModel!.metalPriceAll ?? 0.0)} \$',
                              fontSize: fixSize * 0.0145,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: fixSize * 0.005,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'ມູນຄ່າເພິ່ມເຕີມລວມ',
                              fontSize: fixSize * 0.0145,
                            ),
                            CustomText(
                              text:
                                  '${FormatPrice(price: report.reportModel!.servicePriceAll ?? 0.0)} \$',
                              fontSize: fixSize * 0.0145,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: fixSize * 0.005,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'ລວມເປັນເງິນທັງໝົດ',
                              fontSize: fixSize * 0.0145,
                            ),
                            CustomText(
                              text:
                                  '${FormatPrice(price: report.reportModel!.totalPriceAll ?? 0.0)} \$',
                              fontSize: fixSize * 0.0145,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'ນ້ຳໜັກລວມ:',
                              fontSize: fixSize * 0.0145,
                            ),
                            CustomText(
                              text:
                                  '${FormatPrice(price: report.reportModel!.totalWeightAll ?? 0.0)} ໂຕນ',
                              fontSize: fixSize * 0.0145,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: fixSize * 0.005,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'ນ້ຳໜັກສົ່ງສຳເລັດລວມ:',
                              fontSize: fixSize * 0.0145,
                            ),
                            CustomText(
                              text:
                                  '${FormatPrice(price: report.reportModel!.totalWeightSuccess ?? 0.0)} ໂຕນ',
                              fontSize: fixSize * 0.0145,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: fixSize * 0.005,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'ຄ່າຂຳນສົ່ງລວມ:',
                              fontSize: fixSize * 0.0145,
                            ),
                            CustomText(
                              text:
                                  '${FormatPrice(price: report.reportModel!.metalPriceAll ?? 0.0)} \$',
                              fontSize: fixSize * 0.0145,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: fixSize * 0.005,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'ມູນຄ່າເພິ່ມເຕີມລວມ:',
                              fontSize: fixSize * 0.0145,
                            ),
                            CustomText(
                              text:
                                  '${FormatPrice(price: report.reportModel!.servicePriceAll ?? 0.0)} \$',
                              fontSize: fixSize * 0.0145,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: fixSize * 0.005,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'ລວມເປັນເງິນທັງໝົດ:',
                              fontSize: fixSize * 0.0145,
                            ),
                            CustomText(
                              text:
                                  '${FormatPrice(price: report.reportModel!.totalPriceAll ?? 0.0)} \$',
                              fontSize: fixSize * 0.0145,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),
            );
          }),
          GetBuilder<ReportState>(builder: (report) {
            return InkWell(
              onTap: () async {
                if (report.reportModel != null) {
                  if ((report.reportModel?.data?.length ?? 0) > 0) {
                    Get.to(() => ExportExcelPage(
                          reportModel: reportState.reportModel!,
                          startTime: customDatePickerState.startDate,
                          endTime: customDatePickerState.endDate,
                        ));
                  }
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: fixSize * 0.008,
                ),
                decoration: BoxDecoration(
                  color: report.reportModel != null
                      ? (report.reportModel?.data?.length ?? 0) > 0
                          ? appColors.mainColor
                          : appColors.grey
                      : appColors.grey,
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
                    text: "ສັງລວມ",
                    color: appColors.white,
                    fontSize: fixSize * 0.02,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

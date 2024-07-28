import 'package:bauxite_admin_app/customs/cars_widget.dart';
import 'package:bauxite_admin_app/customs/custom_app_bar.dart';
import 'package:bauxite_admin_app/customs/custom_date_picker.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';
import 'package:bauxite_admin_app/functions/format_datetime.dart';

import 'package:bauxite_admin_app/functions/format_price.dart';
import 'package:bauxite_admin_app/pages/edit_scan_in_out.dart';
import 'package:bauxite_admin_app/pages/waiting_scan_out.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/custom_date_picker_state.dart';

import 'package:bauxite_admin_app/state/scan_history_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllScanInOutPage extends StatefulWidget {
  const AllScanInOutPage({super.key});

  @override
  State<AllScanInOutPage> createState() => _AllScanInOutPageState();
}

class _AllScanInOutPageState extends State<AllScanInOutPage> {
  ScanHistoryState scanHistoryState = Get.put(ScanHistoryState());
  AppColors appColors = AppColors();
  TextEditingController searchT = TextEditingController();
  CustomDatePickerState customDatePickerState =
      Get.put(CustomDatePickerState());
  @override
  void initState() {
    customDatePickerState.setStartDate();
    scanHistoryState.getScanInOut();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fsize = size.width + size.height;
    return Scaffold(
      appBar: CustomAppBar(
        orientation: orientation,
        height: size.height,
        title: "ປະຫວັດການເຄື່ອນໄຫວ",
      ),
      body: GetBuilder<ScanHistoryState>(builder: (scan) {
        if (!scan.check) {
          return Center(
            child: CircularProgressIndicator(
              color: appColors.mainColor,
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.all(fsize * 0.008),
          child: Column(
            children: [
              GetBuilder<CustomDatePickerState>(builder: (context) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDatePicker(
                      title: "ວັນທີເລິ່ມຕົ້ນ",
                      type: SelectDateType.startDate,
                      afterSelect: () async {
                        await scanHistoryState.getScanInOut();
                      },
                    ),
                    SizedBox(
                      width: fsize * 0.008,
                    ),
                    CustomDatePicker(
                      title: "ວັນທີສິ້ນສຸດ",
                      type: SelectDateType.endDate,
                      afterSelect: () async {
                        await scanHistoryState.getScanInOut();
                      },
                    ),
                  ],
                );
              }),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller: searchT,
                      hintText: 'ຄົ້ນຫາ',
                      onChange: (_) {
                        if (_.isEmpty) {
                          scanHistoryState.searchAllScan =
                              scanHistoryState.listAllScan;
                          return;
                        }
                        scanHistoryState.searchAllScan = scanHistoryState
                            .listAllScan
                            .where((element) =>
                                element.code
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchT.text.toLowerCase()) ||
                                (element.creatorModel?.name ?? '')
                                    .toLowerCase()
                                    .contains(searchT.text.toLowerCase()) ||
                                (element.chaufferModel?.userId?.name ?? '')
                                    .toLowerCase()
                                    .contains(searchT.text.toLowerCase()) ||
                                (element.contractModel?.companyId?.name ?? "")
                                    .toLowerCase()
                                    .contains(searchT.text.toLowerCase()) ||
                                (element.carModel?.name ?? '')
                                    .toLowerCase()
                                    .contains(searchT.text.toLowerCase()) ||
                                (element.carModel?.carNumber ?? '')
                                    .toLowerCase()
                                    .contains(searchT.text.toLowerCase()) ||
                                (element.carModel?.tisNumber ?? '')
                                    .toLowerCase()
                                    .contains(searchT.text.toLowerCase()))
                            .toList();
                        scanHistoryState.update();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      if (searchT.text.isEmpty) {
                        scanHistoryState.searchAllScan =
                            scanHistoryState.listAllScan;
                        return;
                      }
                      scanHistoryState.searchAllScan = scanHistoryState
                          .listAllScan
                          .where((element) =>
                              element.code
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchT.text.toLowerCase()) ||
                              (element.creatorModel?.name ?? '')
                                  .toLowerCase()
                                  .contains(searchT.text.toLowerCase()) ||
                              (element.chaufferModel?.userId?.name ?? '')
                                  .toLowerCase()
                                  .contains(searchT.text.toLowerCase()) ||
                              (element.contractModel?.companyId?.name ?? "")
                                  .toLowerCase()
                                  .contains(searchT.text.toLowerCase()) ||
                              (element.carModel?.name ?? '')
                                  .toLowerCase()
                                  .contains(searchT.text.toLowerCase()) ||
                              (element.carModel?.carNumber ?? '')
                                  .toLowerCase()
                                  .contains(searchT.text.toLowerCase()) ||
                              (element.carModel?.tisNumber ?? '')
                                  .toLowerCase()
                                  .contains(searchT.text.toLowerCase()))
                          .toList();
                      scanHistoryState.update();
                    },
                    child: Container(
                      color: appColors.mainColor,
                      width: fsize * 0.05,
                      height: fsize * 0.035,
                      child: Icon(
                        Icons.search,
                        color: appColors.white,
                        size: fsize * 0.02,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  CustomText(
                    text: ' ລວມທັງໝົດ ${scan.searchAllScan.length} ລາຍການ',
                    fontSize: fsize * 0.015,
                  ),
                ],
              ),
              SizedBox(
                height: fsize * 0.01,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: scan.searchAllScan.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: fsize * 0.01),
                          padding: EdgeInsets.symmetric(
                              horizontal: fsize * 0.005,
                              vertical: fsize * 0.0075),
                          decoration: BoxDecoration(
                              color: appColors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(color: appColors.grey, blurRadius: 2)
                              ]),
                          child: InkWell(
                            onTap: () {
                              if (scan.searchAllScan[index].status == 1) {
                                Get.to(
                                  () => EditScanInOut(
                                    data: scan.searchAllScan[index],
                                  ),
                                );
                              } else {
                                Get.to(showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: appColors.white,
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            onTap: () => {Get.back()},
                                            child: CircleAvatar(
                                                backgroundColor:
                                                    appColors.mainColor,
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          child: Icon(
                                            Icons.question_mark,
                                            size: fsize * 0.04,
                                            color: appColors.mainColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: fsize * 0.008,
                                        ),
                                        Center(
                                            child: Text(
                                          'ກະລຸນາເລືອກ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: appColors.mainColor,
                                            fontSize: fsize * 0.0175,
                                          ),
                                        )),
                                      ],
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith((states) =>
                                                            Colors.blue
                                                                .shade400)),
                                            onPressed: () {
                                              Get.back();
                                              if (scan.searchAllScan[index]
                                                          .status ==
                                                      2 ||
                                                  scan.searchAllScan[index]
                                                          .status ==
                                                      3 ||
                                                  scan.searchAllScan[index]
                                                          .status ==
                                                      4) {
                                                Get.to(
                                                  () => WaitingScanOutPage(
                                                    code: scan
                                                        .searchAllScan[index]
                                                        .code,
                                                  ),
                                                );
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.print,
                                                  color: appColors.white,
                                                ),
                                                Text(
                                                  "ປຣິ່ນ",
                                                  style: TextStyle(
                                                    color: appColors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: fsize * 0.0145,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          TextButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith((states) =>
                                                            appColors
                                                                .mainColor)),
                                            onPressed: () {
                                              Get.back();
                                              Get.to(
                                                () => EditScanInOut(
                                                  data:
                                                      scan.searchAllScan[index],
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  color: appColors.white,
                                                ),
                                                Text(
                                                  "ແກ້ໄຂ",
                                                  style: TextStyle(
                                                    color: appColors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: fsize * 0.0145,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                              }
                            },
                            child: Column(children: [
                              RangeTextWidget(
                                fsize: fsize,
                                title1: 'ໄອດີທຸລະກຳ :',
                                title2: scan.searchAllScan[index].code ?? '',
                              ),
                              const SizedBox(
                                height: 2.5,
                              ),
                              RangeTextWidget(
                                fsize: fsize,
                                title1: 'ຊື່ຜູ້ສ້າງທຸລະກຳ :',
                                title2: scan.searchAllScan[index].creatorModel
                                        ?.name ??
                                    '',
                              ),
                              const SizedBox(
                                height: 2.5,
                              ),
                              RangeTextWidget(
                                fsize: fsize,
                                title1: 'ຂໍ້ມູນບໍ່ :',
                                title2: scan.searchAllScan[index].mineralModel
                                        ?.name ??
                                    '',
                              ),
                              const SizedBox(
                                height: 2.5,
                              ),
                              RangeTextWidget(
                                fsize: fsize,
                                title1: 'ບໍລິສັດ :',
                                title2: scan.searchAllScan[index].contractModel
                                        ?.companyId?.name ??
                                    '',
                              ),
                              const SizedBox(
                                height: 2.5,
                              ),
                              RangeTextWidget(
                                fsize: fsize,
                                title1: 'ລົດ :',
                                title2:
                                    scan.searchAllScan[index].carModel?.name ??
                                        '',
                              ),
                              const SizedBox(
                                height: 2.5,
                              ),
                              RangeTextWidget(
                                fsize: fsize,
                                title1: 'ທະບຽນລົດ :',
                                title2: scan.searchAllScan[index].carModel
                                        ?.carNumber ??
                                    '',
                              ),
                              const SizedBox(
                                height: 2.5,
                              ),
                              RangeTextWidget(
                                fsize: fsize,
                                title1: 'ເລກໝ໋ອກ :',
                                title2: scan.searchAllScan[index].carModel
                                        ?.tisNumber ??
                                    '',
                              ),
                              const SizedBox(
                                height: 2.5,
                              ),
                              RangeTextWidget(
                                fsize: fsize,
                                title1: 'ນ້ຳໜັກເຕັມ :',
                                title2: FormatPrice(
                                            price: num.parse(scan
                                                    .searchAllScan[index]
                                                    .totalWeight ??
                                                '0'))
                                        .toString() +
                                    " ໂຕນ".toString(),
                              ),
                              const SizedBox(
                                height: 2.5,
                              ),
                              RangeTextWidget(
                                fsize: fsize,
                                title1: 'ນ້ຳໜັກລົດເປົ່າ :',
                                title2: FormatPrice(
                                            price: num.parse(scan
                                                    .searchAllScan[index]
                                                    .carWeight ??
                                                '0'))
                                        .toString() +
                                    " ໂຕນ".toString(),
                              ),
                              const SizedBox(
                                height: 2.5,
                              ),
                              RangeTextWidget(
                                fsize: fsize,
                                title1: 'ນ້ຳໜັກແຮ່ທາດ :',
                                title2: FormatPrice(
                                            price: num.parse(scan
                                                    .searchAllScan[index]
                                                    .metalWeight ??
                                                '0'))
                                        .toString() +
                                    " ໂຕນ".toString(),
                              ),
                              const SizedBox(
                                height: 2.5,
                              ),
                              RangeTextWidget(
                                fsize: fsize,
                                title1: 'ນ້ຳໜັກລົງສາງ :',
                                title2: FormatPrice(
                                            price: num.parse(scan
                                                    .searchAllScan[index]
                                                    .actualWeight ??
                                                '0'))
                                        .toString() +
                                    " ໂຕນ".toString(),
                              ),
                              const SizedBox(
                                height: 2.5,
                              ),
                              RangeTextWidget(
                                fsize: fsize,
                                title1: 'ວັນທີສະແກນ :',
                                title2: FormatDateTime(
                                        dateTime:
                                            scan.searchAllScan[index].updatedAt)
                                    .toString(),
                              ),
                              const SizedBox(
                                height: 2.5,
                              ),
                              RangeTextWidget(
                                fsize: fsize,
                                title1: 'ສະຖານະ :',
                                title2: scan.searchAllScan[index].status == 0
                                    ? "ຍົກເລິກ"
                                    : scan.searchAllScan[index].status == 1
                                        ? "ສະແກນເຂົ້າ"
                                        : scan.searchAllScan[index].status == 2
                                            ? "ສະແກນອອກ"
                                            : scan.searchAllScan[index]
                                                        .status ==
                                                    3
                                                ? "ສຳເລັດແລ້ວ"
                                                : "ໄລ່ລຽງສຳເລັດ",
                              ),
                            ]),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: fsize * 0.03,
                              height: fsize * 0.0185,
                              decoration: BoxDecoration(
                                color: appColors.mainColor,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(4)),
                              ),
                              child: Center(
                                child: CustomText(
                                  text: (index + 1).toString(),
                                  color: appColors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
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

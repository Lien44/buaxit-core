import 'package:bauxite_admin_app/customs/cars_widget.dart';
import 'package:bauxite_admin_app/customs/custom_app_bar.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';

import 'package:bauxite_admin_app/functions/format_price.dart';
import 'package:bauxite_admin_app/services/app_color.dart';

import 'package:bauxite_admin_app/state/scan_history_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanOutHistory extends StatefulWidget {
  const ScanOutHistory({super.key});

  @override
  State<ScanOutHistory> createState() => _ScanOutHistoryState();
}

class _ScanOutHistoryState extends State<ScanOutHistory> {
  ScanHistoryState scanHistoryState = Get.put(ScanHistoryState());
  AppColors appColors = AppColors();
  TextEditingController searchT = TextEditingController();
  @override
  void initState() {
    scanHistoryState.getDataScanOut();
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
        title: "ປະຫວັດສະແກນອອກ",
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
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller: searchT,
                      hintText: 'search',
                      onChange: (_) {
                        if (_.isEmpty) {
                          scanHistoryState.searchList =
                              scanHistoryState.listScan;
                          return;
                        }
                        scanHistoryState.searchList = scanHistoryState.listScan
                            .where((element) => element.scanInOutId!.code
                                .toString()
                                .contains(_))
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
                        scanHistoryState.searchList = scanHistoryState.listScan;
                        return;
                      }
                      scanHistoryState.searchList = scanHistoryState.listScan
                          .where((element) => element.scanInOutId!.code
                              .toString()
                              .contains(searchT.text))
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
              SizedBox(
                height: fsize * 0.01,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: scan.searchList.length,
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
                          child: Column(children: [
                            RangeTextWidget(
                              fsize: fsize,
                              title1: 'ໄອດີທຸລະກຳ :',
                              title2:
                                  scan.searchList[index].scanInOutId?.code ??
                                      '',
                            ),
                            const SizedBox(
                              height: 2.5,
                            ),
                            RangeTextWidget(
                              fsize: fsize,
                              title1: 'ຊື່ຜູ້ສະແກນ :',
                              title2: scan.searchList[index].scanInOutId
                                      ?.creatorModel?.name ??
                                  '',
                            ),
                            const SizedBox(
                              height: 2.5,
                            ),
                            RangeTextWidget(
                              fsize: fsize,
                              title1: 'ຊື່ໂຊເຟີ :',
                              title2: scan.searchList[index].scanInOutId
                                      ?.chaufferModel?.userId?.name ??
                                  '',
                            ),
                            const SizedBox(
                              height: 2.5,
                            ),
                            RangeTextWidget(
                              fsize: fsize,
                              title1: 'ບໍລິສັດ :',
                              title2: scan.searchList[index].scanInOutId
                                      ?.chaufferModel?.companyId?.name ??
                                  '',
                            ),
                            const SizedBox(
                              height: 2.5,
                            ),
                            RangeTextWidget(
                              fsize: fsize,
                              title1: 'ລົດ :',
                              title2: scan.searchList[index].scanInOutId
                                      ?.carModel?.name ??
                                  '',
                            ),
                            const SizedBox(
                              height: 2.5,
                            ),
                            RangeTextWidget(
                              fsize: fsize,
                              title1: 'ນ້ຳໜັກລົດເປົ່າ :',
                              title2: FormatPrice(
                                          price: num.parse(scan
                                                  .searchList[index]
                                                  .scanInOutId
                                                  ?.carWeight ??
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
                                                  .searchList[index]
                                                  .scanInOutId
                                                  ?.metalWeight ??
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
                              title2:
                                  scan.searchList[index].createdAt.toString(),
                            ),
                          ]),
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

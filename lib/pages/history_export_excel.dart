// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/history_excel_state.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';

class HistoryExportExcelPage extends StatefulWidget {
  const HistoryExportExcelPage({
    super.key,
  });

  @override
  State<HistoryExportExcelPage> createState() => _HistoryExportExcelPageState();
}

class _HistoryExportExcelPageState extends State<HistoryExportExcelPage> {
  final AppColors appColors = AppColors();
  HistoryExcelState historyExcelState = Get.put(HistoryExcelState());
  TextEditingController searchT = TextEditingController();
  @override
  void didChangeDependencies() {
    historyExcelState.getDataHistory();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.mainColor,
        title: CustomText(
          text: "ປະຫວັດສັງລວມ",
          fontSize: fixSize * 0.022,
          color: appColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextFieldWidget(
                    controller: searchT,
                    hintText: 'search',
                    onChange: (v) {
                      historyExcelState.update();
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  color: appColors.mainColor,
                  width: fixSize * 0.05,
                  height: fixSize * 0.035,
                  child: Icon(
                    Icons.search,
                    color: appColors.white,
                    size: fixSize * 0.02,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GetBuilder<HistoryExcelState>(builder: (get) {
              if (!get.check) {
                return Center(
                  child: CircularProgressIndicator(
                    color: appColors.mainColor,
                  ),
                );
              }
              var value = [];
              value = get.historyExcelAll
                  .where((element) => (path.basename(element.path))
                      .toString()
                      .toLowerCase()
                      .contains(searchT.text.toString().toLowerCase()))
                  .toList();
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        CustomText(
                          text: ' ລວມທັງໝົດ ${value.length} ລາຍການ',
                          fontSize: fixSize * 0.015,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: fixSize * 0.01,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: Image.asset(
                                  'assets/images/excel.png',
                                  width: fixSize * 0.035,
                                  height: fixSize * 0.035,
                                ),
                                title: CustomText(
                                  text: path.basename(value[index].path),
                                  color: appColors.black,
                                ),
                                trailing: PopupMenuButton(
                                  tooltip: '',
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                        onTap: () {
                                          openFile(value[index].path);
                                        },
                                        child: CustomText(
                                          text: 'Open',
                                          color: appColors.black,
                                          fontSize: fixSize * 0.0135,
                                        )),
                                    PopupMenuItem(
                                        onTap: () {
                                          shareFile(value[index].path);
                                        },
                                        child: CustomText(
                                          text: 'Share',
                                          color: appColors.black,
                                          fontSize: fixSize * 0.0135,
                                        )),
                                    PopupMenuItem(
                                        onTap: () async {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) async {
                                            var res = await CustomDialogs()
                                                .yesAndNoDialogWithText(
                                                    context,
                                                    fixSize,
                                                    'ທ່ານຕ້ອງການລົບໄຟລນີ້ ຫຼື ບໍ່?');
                                            if (res == true) {
                                              deleteFile(value[index].path);
                                            }
                                          });
                                        },
                                        child: CustomText(
                                          text: 'Delete',
                                          color: appColors.black,
                                          fontSize: fixSize * 0.0135,
                                        )),
                                  ],
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        }),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  void shareFile(String filePath) async {
    try {
      await Share.shareXFiles(
        [XFile(filePath)],
      );
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'ມີບາງຢ່າງຜິດພາດ!',
          backgroundColor: appColors.mainColor.withOpacity(0.7));
    }
  }

  void openFile(String filePath) async {
    try {
      await OpenFile.open(filePath);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'ມີບາງຢ່າງຜິດພາດ!',
          backgroundColor: appColors.mainColor.withOpacity(0.7));
    }
  }

  Future<void> deleteFile(String filePath) async {
    final file = File(filePath);
    await file.delete();
    historyExcelState.getDataHistory();
  }
}

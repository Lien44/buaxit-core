import 'dart:io';

import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/functions/format_date.dart';
import 'package:bauxite_admin_app/models/report_model.dart' as report;
import 'package:bauxite_admin_app/pages/history_export_excel.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:excel/excel.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class ExportExcelPage extends StatefulWidget {
  const ExportExcelPage(
      {super.key,
      required this.reportModel,
      required this.startTime,
      required this.endTime});
  final report.ReportModel reportModel;
  final DateTime? startTime;
  final DateTime? endTime;

  @override
  State<ExportExcelPage> createState() => _ExportExcelPageState();
}

class _ExportExcelPageState extends State<ExportExcelPage> {
  final AppColors appColors = AppColors();

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.mainColor,
        title: CustomText(
          text: "ສັງລວມ",
          fontSize: fixSize * 0.022,
          color: appColors.white,
          fontWeight: FontWeight.w500,
        ),
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
      body: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                exportToExel();
              },
              child: Container(
                width: fixSize * 0.1,
                height: fixSize * 0.1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: appColors.white,
                    boxShadow: [
                      BoxShadow(color: appColors.grey, blurRadius: 5)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/excel.png',
                      width: fixSize * 0.04,
                      height: fixSize * 0.04,
                    ),
                    CustomText(
                      text: 'Excel',
                      color: appColors.black,
                      fontSize: fixSize * 0.016,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }

  List<String> titleExcel = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  List<String> label = [
    'ລຳດັບ',
    'ລະຫັດສັນຍາ',
    'ຊື່ບໍລິສັດ',
    'ທັງໝົດ',
    'ຂົນສົ່ງໄດ້',
    'ມູນຄ່າຂົນສົ່ງ',
    'ມູນຄ່າເພີ່ມເຕີມ',
    'ລວມເປັນເງີນ'
  ];
  exportToExel() async {
    int startline = 3;
    var excel = Excel.createExcel();
    report.ReportModel reportModel = widget.reportModel;
    // // for (var table in excel.tables.keys) {
    // //   print(table);
    // //   print(excel.tables[table]!.maxCols);
    // //   print(excel.tables[table]!.maxRows);
    // //   for (var row in excel.tables[table]!.rows) {
    // //     print("${row.map((e) => e?.value)}");
    // //   }
    // // }
    CellStyle cellStyleTitle = CellStyle(
      fontSize: 14,
      bold: true,
      textWrapping: TextWrapping.WrapText,
      fontFamily: getFontFamily(FontFamily.Lao_MN),
      rotation: 0,
    );
    CellStyle cellStyle = CellStyle(
      textWrapping: TextWrapping.WrapText,
      fontFamily: getFontFamily(FontFamily.Lao_MN),
      rotation: 0,
    );
    CellStyle cellStyle2 = CellStyle(
        textWrapping: TextWrapping.WrapText,
        fontFamily: getFontFamily(FontFamily.Lao_MN),
        rotation: 0,
        horizontalAlign: HorizontalAlign.Right);

    CellStyle totalStyle = CellStyle(
        textWrapping: TextWrapping.WrapText,
        fontFamily: getFontFamily(FontFamily.Lao_MN),
        rotation: 0,
        horizontalAlign: HorizontalAlign.Right,
        bold: true);

    List<Data> listTitleCell = [];
    var sheet = excel['Sheet1'];

    sheet.merge(CellIndex.indexByString('A1'), CellIndex.indexByString('H1'),
        customValue:
            'ລາຍງານລວມແຕ່ວັນທີ ${FormatDate(dateTime: widget.startTime.toString())} ຫາ ${FormatDate(dateTime: widget.endTime.toString())}');
    for (int i = 0; i < 8; i++) {
      var setTitle = sheet.cell(CellIndex.indexByString('${titleExcel[i]}1'));
      setTitle.cellStyle = cellStyleTitle;
    }
    for (int i = 0; i < label.length; i++) {
      var setTitle =
          sheet.cell(CellIndex.indexByString('${titleExcel[i]}$startline'));
      setTitle.value = label[i];
      setTitle.cellStyle = cellStyle;
      listTitleCell.add(setTitle);
    }
    int no = 0;
    for (int index = startline;
        index < reportModel.data!.length + startline;
        index++) {
      var e = reportModel.data![index - startline];
      no++;
      var setValue =
          sheet.cell(CellIndex.indexByString('${titleExcel[0]}${index + 1}'));
      setValue.value = no;

      var setValue1 =
          sheet.cell(CellIndex.indexByString('${titleExcel[1]}${index + 1}'));
      setValue1.value = e.contractId?.code ?? '';
      setValue1.cellStyle = cellStyle;

      var setValue2 =
          sheet.cell(CellIndex.indexByString('${titleExcel[2]}${index + 1}'));
      setValue2.value = e.contractId?.companyId?.name ?? '';
      setValue2.cellStyle = cellStyle;
      var setValue3 =
          sheet.cell(CellIndex.indexByString('${titleExcel[3]}${index + 1}'));
      setValue3.value = e.contractId?.totalWeight ?? '';
      setValue3.cellStyle = cellStyle2;
      var setValue4 =
          sheet.cell(CellIndex.indexByString('${titleExcel[4]}${index + 1}'));
      setValue4.value = e.contractId?.currentWeight ?? '';
      setValue4.cellStyle = cellStyle2;
      var setValue5 =
          sheet.cell(CellIndex.indexByString('${titleExcel[5]}${index + 1}'));
      setValue5.value = e.metalPrice ?? '0.0';
      setValue5.cellStyle = cellStyle2;
      var setValue6 =
          sheet.cell(CellIndex.indexByString('${titleExcel[6]}${index + 1}'));
      setValue6.value = e.servicePrice ?? '0.0';
      setValue6.cellStyle = cellStyle2;
      var setValue7 =
          sheet.cell(CellIndex.indexByString('${titleExcel[7]}${index + 1}'));
      setValue7.value = e.totalPrice ?? '0.0';
      setValue7.cellStyle = cellStyle2;
    }
    no += 1;

    sheet.cell(CellIndex.indexByString('C${no + startline}'))
      ..value = 'ລວມ'
      ..cellStyle = totalStyle;

    sheet.cell(CellIndex.indexByString('D${no + startline}'))
      ..value = reportModel.totalWeightAll
      ..cellStyle = totalStyle;

    sheet.cell(CellIndex.indexByString('E${no + startline}'))
      ..value = reportModel.totalWeightSuccess
      ..cellStyle = totalStyle;

    sheet.cell(CellIndex.indexByString('F${no + startline}'))
      ..value = reportModel.metalPriceAll
      ..cellStyle = totalStyle;

    sheet.cell(CellIndex.indexByString('G${no + startline}'))
      ..value = reportModel.servicePriceAll
      ..cellStyle = totalStyle;

    sheet.cell(CellIndex.indexByString('H${no + startline}'))
      ..value = reportModel.totalPriceAll
      ..cellStyle = totalStyle;

    DateFormat f = DateFormat('yyyy-MM-dd HH_mm_ss');
    String outputFile = "BXreport_${f.format(DateTime.now())}.xlsx";

    //stopwatch.reset();
    List<int>? fileBytes = excel.encode();
    Directory? directory;
    String getPath = '';
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
      getPath = directory!.path;
    } else {
      directory = await getApplicationDocumentsDirectory();
      getPath = '${directory.path}/BxReport';
    }
    bool folderExists = await Directory(getPath).exists();
    if (!folderExists) {
      await Directory(getPath).create(recursive: true);
    }
    //print('saving executed in ${stopwatch.elapsed}');

    if (fileBytes != null) {
      try {
        final path = '$getPath/$outputFile';
        await File(path).writeAsBytes(fileBytes);
        Get.to(() => const HistoryExportExcelPage());
        Fluttertoast.showToast(
            msg: 'ບັນທືກສຳເລັດ',
            backgroundColor: appColors.mainColor.withOpacity(0.7));
      } catch (e) {
        Fluttertoast.showToast(
            msg: 'ມີບາງຢ່າງຜິດພາດ!',
            backgroundColor: appColors.mainColor.withOpacity(0.7));
      }
    }
  }
}

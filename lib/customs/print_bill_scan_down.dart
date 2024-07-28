// ignore_for_file: depend_on_referenced_packages

import 'package:bauxite_admin_app/functions/format_date_time2.dart';
import 'package:bauxite_admin_app/functions/format_price.dart';
import 'package:bauxite_admin_app/models/scan_out_model.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintBillScanDown extends StatelessWidget {
  PrintBillScanDown({super.key, required this.scanOutModel});
  final ScanOutModel scanOutModel;

  final AppColors appColor = AppColors();
  final doc = pw.Document();

  Future<Uint8List> _generatePdf(
    PdfPageFormat format,
    String title,
    ScanOutModel scanOutModel,
  ) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: false);
    final font = await fontFromAssetBundle('assets/fonts/saysettha_ot.ttf');
    // final image = await imageFromAssetBundle('assets/icon/logo.jpg');
    // var images = await flutterImageProvider(
    //     const NetworkImage('https://www.citgroup.la/images/logo.png'));

    double normalSize = 18;
    double largeSize = 24;

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 24),
        pageFormat: format,
        build: (context) {
          return pw.Center(
              child: pw.SizedBox(
                  width: 300,
                  // height: 200,
                  child: pw.Column(
                    children: [
                      pw.SizedBox(height: 30),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text(
                              "ບໍລິສັດ ພັດທະນາ ແຮ່ບົກຊິດ",
                              style: pw.TextStyle(
                                  font: font,
                                  fontSize: largeSize + 5,
                                  fontWeight: pw.FontWeight.bold),
                            )
                          ]),
                      pw.SizedBox(height: 20),
                      pw.Text(
                        title,
                        style: pw.TextStyle(
                            font: font,
                            fontSize: largeSize - 5,
                            decoration: pw.TextDecoration.underline),
                      ),
                      pw.SizedBox(height: 20),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "ເລກທີບີນ",
                                  style: pw.TextStyle(
                                      font: font, fontSize: normalSize),
                                ),
                                pw.SizedBox(height: 5),
                                pw.Text(
                                  scanOutModel.id.toString(),
                                  style: pw.TextStyle(
                                      font: font, fontSize: normalSize),
                                ),
                              ],
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Text(
                                  "ວັນທີສະແກນເຂົ້າ",
                                  style: pw.TextStyle(
                                      font: font, fontSize: normalSize),
                                ),
                                pw.SizedBox(height: 5),
                                pw.Text(
                                  FormatDateTime2(
                                          dateTime: scanOutModel.createdAt)
                                      .toString(),
                                  style: pw.TextStyle(
                                      font: font, fontSize: normalSize),
                                ),
                              ],
                            ),
                          ]),
                      pw.SizedBox(height: 10),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "ລະຫັດທຸລະກຳ",
                                  style: pw.TextStyle(
                                      font: font, fontSize: normalSize),
                                ),
                                pw.SizedBox(height: 5),
                                pw.Text(
                                  scanOutModel.code ?? '',
                                  style: pw.TextStyle(
                                      font: font, fontSize: normalSize),
                                ),
                              ],
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Text(
                                  "ວັນທີສະແກນລົງສາງ",
                                  style: pw.TextStyle(
                                      font: font, fontSize: normalSize),
                                ),
                                pw.SizedBox(height: 5),
                                pw.Text(
                                  FormatDateTime2(
                                          dateTime: scanOutModel.updatedAt)
                                      .toString(),
                                  style: pw.TextStyle(
                                      font: font, fontSize: normalSize),
                                ),
                              ],
                            ),
                          ]),
                      pw.SizedBox(height: 10),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    "ເລກທະບຽນລົດ",
                                    style: pw.TextStyle(
                                        font: font, fontSize: normalSize),
                                  ),
                                  pw.SizedBox(height: 5),
                                  pw.Text(
                                    scanOutModel.carModel?.carNumber ?? '',
                                    style: pw.TextStyle(
                                        font: font, fontSize: normalSize),
                                  ),
                                ]),
                            pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.end,
                                children: [
                                  pw.Text(
                                    "ເລກໝ໋ອກ",
                                    style: pw.TextStyle(
                                        font: font, fontSize: normalSize),
                                  ),
                                  pw.SizedBox(height: 5),
                                  pw.Text(
                                    scanOutModel.carModel?.tisNumber ?? '',
                                    style: pw.TextStyle(
                                        font: font, fontSize: normalSize),
                                  ),
                                ]),
                          ]),
                      pw.Divider(),
                      pw.SizedBox(height: 10),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "ລະຫັດສັນຍາ",
                              style: pw.TextStyle(
                                  font: font, fontSize: normalSize),
                            ),
                            pw.Text(
                              scanOutModel.contractModel?.code ?? '',
                              style: pw.TextStyle(
                                  font: font, fontSize: normalSize),
                            ),
                          ]),
                      pw.SizedBox(height: 6),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "ຜູ້ສະແກນ",
                              style: pw.TextStyle(
                                  font: font, fontSize: normalSize),
                            ),
                            pw.Text(
                              scanOutModel.creatorModel?.name ?? '',
                              style: pw.TextStyle(
                                  font: font, fontSize: normalSize),
                            ),
                          ]),
                      pw.SizedBox(height: 6),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "ຂໍ້ມູນບໍ່",
                              style: pw.TextStyle(
                                  font: font, fontSize: normalSize),
                            ),
                            pw.Text(
                              scanOutModel.mineralModel?.name ?? '',
                              style: pw.TextStyle(
                                  font: font, fontSize: normalSize),
                            ),
                          ]),
                      pw.SizedBox(height: 10),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "ບໍລິສັດ",
                              style: pw.TextStyle(
                                  font: font, fontSize: normalSize),
                            ),
                            pw.Text(
                              scanOutModel.contractModel?.companyId?.name ?? '',
                              style: pw.TextStyle(
                                  font: font, fontSize: normalSize),
                            ),
                          ]),
                      pw.SizedBox(height: 10),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "ນ້ຳໜັກລົດເຕັມ",
                              style: pw.TextStyle(
                                  font: font, fontSize: normalSize),
                            ),
                            pw.Text(
                              '${FormatPrice(price: num.parse(scanOutModel.totalWeight ?? '0'))} ໂຕນ',
                              style: pw.TextStyle(
                                  font: font, fontSize: normalSize),
                            ),
                          ]),
                      pw.SizedBox(height: 10),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "ນ້ຳໜັກເປົ່າ",
                              style: pw.TextStyle(
                                  font: font, fontSize: normalSize),
                            ),
                            pw.Text(
                              '${FormatPrice(price: num.parse(scanOutModel.carWeight ?? '0'))} ໂຕນ',
                              style: pw.TextStyle(
                                  font: font, fontSize: normalSize),
                            ),
                          ]),
                      pw.SizedBox(height: 10),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "ນ້ຳໜັກແຮ່ທາດ",
                              style: pw.TextStyle(
                                  font: font, fontSize: normalSize),
                            ),
                            pw.Text(
                              '${FormatPrice(price: num.parse(scanOutModel.metalWeight ?? '0'))} ໂຕນ',
                              style: pw.TextStyle(
                                  font: font, fontSize: normalSize),
                            ),
                          ]),
                           pw.SizedBox(height: 10),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "ນ້ຳໜັກແຮ່ລົງສາງ",
                              style: pw.TextStyle(
                                  font: font, fontSize: normalSize),
                            ),
                            pw.Text(
                              '${FormatPrice(price: num.parse(scanOutModel.actualWeight ?? '0'))} ໂຕນ',
                              style: pw.TextStyle(
                                  font: font, fontSize: normalSize),
                            ),
                          ]),
                      pw.SizedBox(height: 10),
                      pw.Divider(),
                      pw.SizedBox(height: 10),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "ລາຍເຊັນຜູ້ອອກບີນ",
                                  style: pw.TextStyle(
                                      font: font,
                                      fontSize: normalSize,
                                      decoration: pw.TextDecoration.underline),
                                ),
                              ],
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Text(
                                  "ລາຍເຊັນຄົນຂັບ",
                                  style: pw.TextStyle(
                                      font: font,
                                      fontSize: normalSize,
                                      decoration: pw.TextDecoration.underline),
                                ),
                              ],
                            ),
                          ]),
                      pw.SizedBox(height: 60),
                      pw.Divider(),
                    ],
                  )));
        },
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return PdfPreview(
      canDebug: false,
      allowSharing: false,
      allowPrinting: true,
      canChangePageFormat: false,
      padding: EdgeInsets.zero,
      previewPageMargin: EdgeInsets.zero,
      pdfPreviewPageDecoration: BoxDecoration(
        color: appColor.white,
      ),
      build: (format) => _generatePdf(format, "ໃບບິນສະແກນລົງສາງ", scanOutModel),
    );
  }
}

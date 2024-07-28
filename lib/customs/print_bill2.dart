// ignore_for_file: depend_on_referenced_packages

import 'package:bauxite_admin_app/functions/format_date_time2.dart';
import 'package:bauxite_admin_app/functions/format_price.dart';
import 'package:bauxite_admin_app/models/scan_out_model.dart';
import 'package:bauxite_admin_app/services/app_color.dart';

import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintBill2 {
  final AppColors appColor = AppColors();
  final doc = pw.Document();

  Future<Uint8List> generatePdf(
    // PdfPageFormat format,
    String title,
    ScanOutModel scanOutModel,
  ) async {
    final pdf = pw.Document();
    final font =
        await fontFromAssetBundle('assets/fonts/NotoSansLao-Regular.ttf');
    pdf.addPage(
      pw.Page(
        // margin: const pw.EdgeInsets.symmetric(horizontal: 25, vertical: 85),
        //pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Text(
                  "ບໍລິສັດ ພັດທະນາ ແຮ່ບົກຊິດ",
                  style: pw.TextStyle(
                      font: font,
                      fontSize: 20 * 2,
                      fontWeight: pw.FontWeight.bold),
                )
              ]),
              pw.SizedBox(height: 20),
              pw.Text(
                title,
                style: pw.TextStyle(
                    font: font,
                    fontSize: 18 * 2,
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
                          "ລະຫັດທຸລະກຳ: ",
                          style: pw.TextStyle(font: font, fontSize: 10 * 2),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          scanOutModel.code ?? '',
                          style: pw.TextStyle(font: font, fontSize: 14 * 2),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          "ວັນທີສະແກນອອກ: ",
                          style: pw.TextStyle(font: font, fontSize: 10 * 2),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          FormatDateTime2(dateTime: scanOutModel.updatedAt)
                              .toString(),
                          style: pw.TextStyle(font: font, fontSize: 14 * 2),
                        ),
                      ],
                    ),
                  ]),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "ລະຫັດສັນຍາ",
                      style: pw.TextStyle(font: font, fontSize: 12 * 2),
                    ),
                    pw.Text(
                      scanOutModel.contractModel?.code ?? '',
                      style: pw.TextStyle(font: font, fontSize: 12 * 2),
                    ),
                  ]),
              pw.SizedBox(height: 6),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "ຜູ້ສະແກນ",
                      style: pw.TextStyle(font: font, fontSize: 12 * 2),
                    ),
                    pw.Text(
                      scanOutModel.creatorModel?.name ?? '',
                      style: pw.TextStyle(font: font, fontSize: 12 * 2),
                    ),
                  ]),
              pw.SizedBox(height: 6),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "ໂຊເຟີ",
                      style: pw.TextStyle(font: font, fontSize: 12 * 2),
                    ),
                    pw.Text(
                      scanOutModel.chaufferModel?.userId?.name ?? '',
                      style: pw.TextStyle(font: font, fontSize: 12 * 2),
                    ),
                  ]),
              pw.SizedBox(height: 10),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "ບໍລິສັດ",
                      style: pw.TextStyle(font: font, fontSize: 12 * 2),
                    ),
                    pw.Text(
                      scanOutModel.chaufferModel?.companyId?.name ?? '',
                      style: pw.TextStyle(font: font, fontSize: 12 * 2),
                    ),
                  ]),
              pw.SizedBox(height: 10),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "ປະເພດລົດ",
                      style: pw.TextStyle(font: font, fontSize: 12 * 2),
                    ),
                    pw.Text(
                      scanOutModel.carModel?.name ?? '',
                      style: pw.TextStyle(font: font, fontSize: 12 * 2),
                    ),
                  ]),
              pw.SizedBox(height: 10),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "ນ້ຳໜັກແຮ່ທາດ",
                      style: pw.TextStyle(font: font, fontSize: 12 * 2),
                    ),
                    pw.Text(
                      '${FormatPrice(price: num.parse(scanOutModel.metalWeight ?? '0'))} ໂຕນ',
                      style: pw.TextStyle(
                          font: font,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12 * 2),
                    ),
                  ]),
              pw.SizedBox(height: 10),
            ],
          );
        },
      ),
    );
    await Printing.layoutPdf(onLayout: (f) {
      return pdf.save();
    });
    return pdf.save();
  }

  // @override
  // Widget build(BuildContext context) {Orientation orientation = MediaQuery.of(context).orientation;
  //   return PdfPreview(
  //     canDebug: false,
  //     allowSharing: false,
  //     canChangePageFormat: false,
  //     padding: EdgeInsets.zero,
  //     build: (format) => _generatePdf(format, "ໃບບິນສະແກນອອກ", scanOutModel),
  //   );
  // }
}

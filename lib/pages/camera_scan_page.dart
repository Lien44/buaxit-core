import 'dart:convert';

import 'package:bauxite_admin_app/customs/custom_app_bar.dart';
import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/models/scan_in_out_model.dart';
import 'package:bauxite_admin_app/pages/sacn_in_select_contract.dart';
import 'package:bauxite_admin_app/pages/scan_down_warehouse.dart';
import 'package:bauxite_admin_app/pages/scan_out.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/camera_scan_page_state.dart';
import 'package:bauxite_admin_app/state/car_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CameraScanPage extends StatelessWidget {
  CameraScanPage({
    super.key,
    required this.type,
  });
  final CameraType type;
  final AppColors appColors = AppColors();
  final CameraScanPageState cameraScanPageState =
      Get.put(CameraScanPageState());
  final CarState carState = Get.put(CarState());

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.height + size.width;
    return Scaffold(
      appBar: CustomAppBar(
        orientation: orientation,
        height: size.height,
        title: type == CameraType.scanIn
            ? "ສະແກນເຂົ້າ"
            : (type == CameraType.scanOut ? "ສະແກນອອກ" : "ສະແກນລົງສາງ"),
      ),
      body: GetBuilder<CameraScanPageState>(builder: (camera) {
        return QRView(
          key: camera.qrKey,
          overlay: QrScannerOverlayShape(
              borderColor: appColors.mainColor,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: fixSize * 0.2),
          onQRViewCreated: (controller) {
            camera.controller = controller;
            controller.scannedDataStream.listen((scanData) async {
              camera.controller!.pauseCamera();
              CustomDialogs().dialogLoading();
              camera.updateBarCode(scanData).then((value) async {
                if (type == CameraType.scanIn) {
                  try {
                    var res = await camera.getCarByCode();
                    Get.back();
                    if (res.statusCode == 200) {
                      controller.dispose();
                      cameraScanPageState.controller!.dispose();
                      carState.clearcarModel();
                      Get.off(
                        () => ScanInSelectContract(
                            carModel: CarModel.fromJson(
                                jsonDecode(res.body)['data'])),
                      );
                    } else if (res.statusCode == 405) {
                      // ignore: use_build_context_synchronously
                      CustomDialogs().showToast(
                        bottom: 400,
                        context: context,
                        text: "${jsonDecode(res.body)['message']}",
                        backgroundColor: appColors.mainColor.withOpacity(
                          0.75,
                        ),
                      );
                    } else {
                      throw res.statusCode;
                    }
                  } catch (e) {
                    Get.back();
                    CustomDialogs().showToast(
                      context: context,
                      text: "ລະຫັດລົດບໍ່ຖືກຕ້ອງ",
                      backgroundColor: appColors.mainColor.withOpacity(
                        0.75,
                      ),
                    );
                  }
                } else if (type == CameraType.scanOut) {
                  try {
                    var res = await camera.getChaufferByCodeForScanOut();
                    Get.back();
                    if (res.statusCode == 200) {
                      controller.dispose();
                      cameraScanPageState.controller!.dispose();
                      Get.off(() => const ScanOutPage());
                    } else if (res.statusCode == 405) {
                      // ignore: use_build_context_synchronously
                      CustomDialogs().showToast(
                        context: context,
                        text: "${jsonDecode(res.body)['message']}",
                        backgroundColor: appColors.mainColor.withOpacity(
                          0.75,
                        ),
                      );
                    } else {
                      throw res.statusCode;
                    }

                    //scan out
                  } catch (e) {
                    Get.back();
                    CustomDialogs().showToast(
                      context: context,
                      text: "ລະຫັດລົດບໍ່ຖືກຕ້ອງ",
                      backgroundColor: appColors.mainColor.withOpacity(
                        0.75,
                      ),
                    );
                  }
                } else if (type == CameraType.scanDownWarehouse) {
                  try {
                    var res =
                        await camera.getChaufferByCodeForScanDownWareHouse();
                    Get.back();
                    if (res.statusCode == 200) {
                      controller.dispose();
                      cameraScanPageState.controller!.dispose();
                      Get.off(() => const ScanDownWarehousePage());
                    } else if (res.statusCode == 405) {
                      // ignore: use_build_context_synchronously
                      CustomDialogs().showToast(
                        context: context,
                        text: "${jsonDecode(res.body)['message']}",
                        backgroundColor: appColors.mainColor.withOpacity(
                          0.75,
                        ),
                      );
                    } else {
                      throw res.statusCode;
                    }

                    //scan out
                  } catch (e) {
                    // print('999999999999999999999999999999999999999999 ${e.toString()}');
                    Get.back();
                    CustomDialogs().showToast(
                      context: context,
                      text: "ລະຫັດລົດບໍ່ຖືກຕ້ອງ",
                      backgroundColor: appColors.mainColor.withOpacity(
                        0.75,
                      ),
                    );
                  }
                }
                await Future.delayed(const Duration(seconds: 2)).then((value) {
                  camera.controller!.resumeCamera();
                });
              });
            });
          },
        );
      }),
    );
  }
}

enum CameraType { scanIn, scanOut, scanDownWarehouse }

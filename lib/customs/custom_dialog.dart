import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CustomDialogs {
  AppColors appColors = AppColors();
  loadingDialog(BuildContext context, double fixSize) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => SizedBox(
              height: fixSize * 0.04,
              width: fixSize * 0.04,
              child: Center(
                child: CircularProgressIndicator(
                  color: appColors.mainColor,
                ),
              ),
            ));
  }

  textDialog(BuildContext context, double fixSize,
      {String? text, IconData? icon}) async {
    await Future.delayed(Duration.zero).then((_) async {
      return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: appColors.white,
          content: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(fixSize * 0.016),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      child: Icon(
                        icon ?? Icons.warning,
                        size: fixSize * 0.04,
                        color: appColors.mainColor,
                      ),
                    ),
                    SizedBox(
                      height: fixSize * 0.008,
                    ),
                    Center(
                        child: Text(
                      text ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: appColors.mainColor,
                        fontSize: fixSize * 0.0175,
                      ),
                    )),
                  ],
                ),
              ),
              Positioned(
                top: fixSize * 0.005,
                right: fixSize * 0.005,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.all(fixSize * 0.0025),
                          decoration: BoxDecoration(
                              color: appColors.mainColor,
                              borderRadius: BorderRadius.circular(fixSize)),
                          child: Icon(
                            Icons.close_rounded,
                            size: fixSize * 0.025,
                            color: appColors.white,
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Future<bool> yesAndNoDialogWithText(
      BuildContext context, double fixSize, String? text,
      {double? fontSize, String? cancelText, String? confirmText}) async {
    var result = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: appColors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              child: Icon(
                Icons.question_mark,
                size: fixSize * 0.04,
                color: appColors.mainColor,
              ),
            ),
            SizedBox(
              height: fixSize * 0.008,
            ),
            Center(
                child: Text(
              text ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appColors.mainColor,
                fontSize: fontSize ?? fixSize * 0.0175,
              ),
            )),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.grey.shade400)),
                onPressed: () {
                  Get.back(result: false);
                },
                child: Text(
                  cancelText ?? "ຍົກເລິກ",
                  style: TextStyle(
                    color: appColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: fixSize * 0.0145,
                  ),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => appColors.mainColor)),
                onPressed: () {
                  Get.back(result: true);
                },
                child: Text(
                  confirmText ?? "ຢືນຢັນ",
                  style: TextStyle(
                    color: appColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: fixSize * 0.0145,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
    if (result != null) {
      return result;
    } else {
      return false;
    }
  }

  Future<bool> dialogWithInputText(
      BuildContext context, TextEditingController controller) async {
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    var value = await showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: Icon(
                Icons.info,
                color: appColors.mainColor,
                size: fixSize * 0.05,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    textAlign: TextAlign.center,
                    text: "ກະລຸນາໃສ່ເຫດຜົນໃນການແຈ້ງເຫດຂອງທ່ານ",
                    color: appColors.mainColor,
                    fontSize: fixSize * 0.0185,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: fixSize * 0.008, vertical: fixSize * 0.001),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: appColors.mainColor,
                          width: fixSize * 0.002,
                        )),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: appColors.mainColor,
                          width: fixSize * 0.002,
                        )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: appColors.mainColor,
                          width: fixSize * 0.002,
                        )),
                        hintText: 'ເຫດຜົນ',
                      ),
                    ),
                  ),
                ],
              ),
              actionsPadding: EdgeInsets.symmetric(horizontal: fixSize * 0.015),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => appColors.grey)),
                        onPressed: () {
                          Get.back(result: false);
                        },
                        child: CustomText(
                          text: 'ຍົກເລິກ',
                          color: appColors.white,
                          fontSize: fixSize * 0.0185,
                        )),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => appColors.mainColor)),
                        onPressed: () {
                          Get.back(result: true);
                        },
                        child: CustomText(
                          text: 'ຢືນຢັນ',
                          color: appColors.white,
                          fontSize: fixSize * 0.0185,
                        ))
                  ],
                )
              ],
            )));
    if (value != null) {
      if (value == true) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  dialogLoading() async {
    await Get.dialog(
      Builder(builder: (context) {
        Size size = MediaQuery.of(context).size;
        double fixSize = size.width + size.height;
        return SizedBox(
          height: fixSize * 0.04,
          width: fixSize * 0.04,
          child: Center(
            child: CircularProgressIndicator(
              color: appColors.mainColor,
            ),
          ),
        );
      }),
      barrierDismissible: false,
    );
  }

  showToast({
    required BuildContext context,
    String? text,
    double? fontSize,
    Color? backgroundColor,
    double? bottom,
    double? top,
    double? right,
    double? left,
  }) async {
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    var toast = FToast().init(context);
    toast.removeCustomToast();
    toast.showToast(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: fixSize * 0.025, vertical: fixSize * 0.005),
        decoration: BoxDecoration(
            color: backgroundColor ?? appColors.mainColor.withOpacity(0.75),
            borderRadius: BorderRadius.circular(99999)),
        child: CustomText(
          text: text ?? '',
          fontSize: fontSize,
          color: appColors.white,
        ),
      ),
      positionedToastBuilder: (context, child) {
        return Positioned(
          bottom: bottom ?? fixSize * 0.05,
          left: left ?? 0,
          right: right ?? 0,
          top: top,
          child: child,
        );
      },
    );
  }

  dialogShowMessage({
    required String message,
    IconData? icon,
    Color? colorsIcon,
    Color? colorButton,
  }) async {
    await Get.dialog(Builder(builder: (context) {
      Size size = MediaQuery.of(context).size;
      double fixSize = size.width + size.height;
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Icons.warning,
              color: colorsIcon ?? appColors.mainColor,
              size: fixSize * 0.045,
            ),
            SizedBox(
              height: fixSize * 0.01,
            ),
            CustomText(
              text: message,
              color: Colors.black,
              fontSize: fixSize * 0.0185,
            )
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => colorButton ?? appColors.mainColor)),
                    onPressed: () {
                      Get.back();
                    },
                    child: CustomText(
                      text: 'ok',
                      fontSize: fixSize * 0.0185,
                      color: Colors.white,
                    )),
              ),
            ],
          )
        ],
      );
    }));
  }
}

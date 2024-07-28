import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleState extends GetxController {}

class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.color,
      this.textAlign,
      this.fontWeight,
      this.shadows})
      : super(key: key);
  final String text;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final List<Shadow>? shadows;
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return GetBuilder<LocaleState>(builder: (localeUpdate) {
      return Text(
        text.tr,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: orientation == Orientation.portrait
              ? (Platform.isAndroid ? fontSize : ((fontSize ?? 12) * 0.8))
              : (((Platform.isAndroid ? fontSize : ((fontSize ?? 12) * 0.8)) ??
                      12) *
                  0.8),
          color: color,
          shadows: shadows,
          fontFamily: "NotoSan",
          fontWeight: fontWeight,
        ),
      );
    });
  }
}

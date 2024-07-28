import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckLang {
  CheckLang({required this.nameLa, this.nameCn, this.nameEn});
  final String nameLa;
  final String? nameEn;
  final String? nameCn;

  @override
  String toString() {
    if (Get.locale == const Locale('la', 'LA')) {
      return nameLa;
    } else if (Get.locale == const Locale('en', 'US')) {
        return nameEn ?? nameLa;
    }else if (Get.locale == const Locale('cn', 'CN')) {
        return nameCn ?? nameLa;
    }
    return '';
  }
}

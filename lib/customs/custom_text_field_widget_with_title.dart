import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWithTitle extends StatelessWidget {
  CustomTextFieldWithTitle(
      {super.key,
      required this.controller,
      required this.title,
      this.hint,
      this.trailingText,
      this.trailingSize,
      this.titleSize,
      this.keyBoardType,
      this.inputFormatter,
      this.onFieldSubmitted,
      this.onChange});
  final TextEditingController controller;
  final AppColors appColors = AppColors();
  final String title;
  final String? hint;
  final String? trailingText;
  final double? trailingSize;
  final double? titleSize;
  final TextInputType? keyBoardType;
  final List<TextInputFormatter>? inputFormatter;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          color: appColors.black,
          fontSize: titleSize ?? fixSize * 0.012,
          fontWeight: FontWeight.bold,
        ),
        TextFieldWidget(
          controller: controller,
          hintText: hint ?? "",
          contentPadding: EdgeInsets.symmetric(horizontal: fixSize * 0.007),
          keyboardType: keyBoardType,
          inputFormatters: inputFormatter,
          onFieldSubmitted: onFieldSubmitted,
          onChange: onChange,
          suffixIcon: CustomText(
            text: trailingText ?? "",
            color: appColors.mainColor,
            fontSize: trailingSize ?? fixSize * 0.01,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

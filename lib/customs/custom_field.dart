import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFieldText extends StatefulWidget {
  const CustomFieldText(
      {Key? key,
      required this.controller,
      required this.appColor,
      required this.hintText,
      this.contentPadding,
      this.validator,
      this.onFieldSubmitted,
      this.modeValidate,
      this.onChange,
      this.readOnly,
      this.focusNode,
      this.maxLength,
      this.label,
      this.lines,
      this.keyboardType,
      this.prefixIcon,
      this.suffixIcon,
      this.obsureText = false})
      : super(key: key);

  final TextEditingController controller;
  final AppColors appColor;
  final String hintText;

  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String)? onFieldSubmitted;
  final AutovalidateMode? modeValidate;
  final void Function(String)? onChange;
  final bool? readOnly;
  final FocusNode? focusNode;
  final int? maxLength;
  final Widget? label;
  final TextInputType? keyboardType;
  final int? lines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obsureText;

  @override
  State<CustomFieldText> createState() => _CustomFieldTextState();
}

class _CustomFieldTextState extends State<CustomFieldText> {
  bool obsureText = false;

  @override
  void initState() {
    obsureText = widget.obsureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return TextFormField(
      controller: widget.controller,
      obscureText: obsureText,
      validator: widget.validator,
      readOnly: widget.readOnly ?? false,
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      maxLines: widget.lines ?? 1,
      autovalidateMode: widget.validator != null
          ? widget.modeValidate ?? AutovalidateMode.always
          : null,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChange,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        label: widget.label,
        counterText: "",
        isDense: true,
        contentPadding:
            widget.contentPadding ?? const EdgeInsets.fromLTRB(10, 10, 10, 10),
        hintText: widget.hintText.tr,
        suffixIcon: widget.suffixIcon != null
            ? InkWell(
                onTap: () {
                  if (obsureText == true) {
                    obsureText = false;
                  } else {
                    obsureText = true;
                  }
                  setState(() {});
                },
                child: widget.suffixIcon,
              )
            : null,
        hintStyle: const TextStyle(fontFamily: 'NotoSan', fontSize: 12),
        focusColor: widget.appColor.mainColor,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(fixSize * 0.005),
            borderSide: BorderSide(
                width: 1, color: widget.appColor.grey.withOpacity(0.5))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(fixSize * 0.005),
            borderSide: BorderSide(width: 1, color: widget.appColor.mainColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(fixSize * 0.005),
            borderSide: BorderSide(width: 1, color: widget.appColor.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(fixSize * 0.005),
            borderSide: BorderSide(width: 1, color: widget.appColor.red)),
      ),
    );
  }
}

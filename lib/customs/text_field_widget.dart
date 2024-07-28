import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget(
      {Key? key,
      required this.controller,
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
      this.obsureText = false,
      this.inputFormatters,
      this.onTap})
      : super(key: key);

  final TextEditingController controller;
  final AppColors appColor = AppColors();
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
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onTap;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
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
    double fsize = size.width + size.height;
    return SizedBox(
      height: fsize * 0.035,
      child: Row(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  width: fsize * 0.007,
                  color: widget.appColor.mainColor,
                ),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              child: TextFormField(
                onTap: widget.onTap,
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
                inputFormatters: widget.inputFormatters,
                decoration: InputDecoration(
                  prefixIcon: widget.prefixIcon,
                  label: widget.label,
                  counterText: "",
                  isDense: false,
                  contentPadding: widget.contentPadding ??
                      EdgeInsets.fromLTRB(fsize * 0.008, fsize * 0.008,
                          fsize * 0.008, fsize * 0.008),
                  hintText: widget.hintText.tr,
                  suffixIcon: (widget.suffixIcon == null && widget.obsureText)
                      ? InkWell(
                          onTap: () {
                            if (obsureText == true) {
                              obsureText = false;
                            } else {
                              obsureText = true;
                            }
                            setState(() {});
                          },
                          child: Icon(
                            Icons.visibility,
                            color: widget.appColor.mainColor,
                            // size: fsize * 0.02,
                          ),
                        )
                      : widget.suffixIcon,
                  suffixIconConstraints: widget.suffixIcon != null
                      ? BoxConstraints.tightFor(
                          width: fsize * 0.025,
                          height: fsize * 0.015,
                        )
                      : null,
                  hintStyle:
                      TextStyle(fontFamily: 'NotoSan', fontSize: fsize * 0.01),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                          width: 1, color: widget.appColor.mainColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                          width: 1, color: widget.appColor.mainColor)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                          width: 2, color: widget.appColor.mainColor)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(
                          width: 1, color: widget.appColor.mainColor)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

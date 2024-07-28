import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/services/app_color.dart';

import 'package:flutter/material.dart';

class DropDownWidget<T> extends StatelessWidget {
  const DropDownWidget({
    Key? key,
    required this.fixSize,
    required this.value,
    required this.hint,
    required this.listMenuItems,
    required this.onChange,
    this.isExpanded = false,
    this.onTap,
    this.margin,
  }) : super(key: key);

  final double fixSize;
  static AppColors appColor = AppColors();
  final dynamic value;
  final String hint;
  final Function(dynamic) onChange;
  final List<DropdownMenuItem> listMenuItems;
  final EdgeInsetsGeometry? margin;
  final Function()? onTap;
  final bool isExpanded ;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fSize = size.width + size.height;
    return SizedBox(
      height: fSize * 0.035,
      child: Row(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  width: 8,
                  color: appColor.mainColor,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height: fSize * 0.035,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: appColor.mainColor),
                color: appColor.white,
              ),
              margin: margin,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: isExpanded,
                    onTap: onTap,
                    isDense: false,
                    value: value,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: appColor.mainColor,
                      size: fixSize * 0.0175,
                    ),
                    items: listMenuItems,
                    onChanged: onChange,
                    hint: CustomText(
                      text: hint,
                      fontSize: fixSize * 0.0125,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

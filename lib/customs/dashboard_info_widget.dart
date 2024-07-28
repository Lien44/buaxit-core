import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:flutter/material.dart';

class DashboardInfo extends StatelessWidget {
  DashboardInfo({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    this.fontWeight,
    this.color,
  });
  final AppColors appColors = AppColors();
  final String title;
  final String value;
  final String unit;
  final Color? color;
  final FontWeight ? fontWeight;
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return Padding(
      padding: EdgeInsets.only(
        left: fixSize * 0.008,
        right: fixSize * 0.008,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title,
                color: color ?? appColors.black,
                fontSize: fixSize * 0.011,
                fontWeight: fontWeight,
              ),
              CustomText(
                text: "$value $unit",
                color: color ?? appColors.black,
                fontSize: fixSize * 0.013,
                fontWeight: fontWeight,
              ),
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}

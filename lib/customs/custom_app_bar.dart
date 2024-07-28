import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    required this.height,
    this.leading,
    this.title,
    this.titleSize,
    this.actions,
    required this.orientation,
  });
  final double height;
  final AppColors appColors = AppColors();
  final Widget? leading;
  final String? title;
  final double? titleSize;
  final List<Widget>? actions;
  final Orientation? orientation;
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return AppBar(
      backgroundColor: appColors.mainColor,
      leading: leading ??
          BackButton(
            color: appColors.white,
          ),
      title: CustomText(
        text: title ?? "",
        fontSize: titleSize ??
            (orientation == Orientation.portrait
                ? fixSize * 0.022
                : fixSize * 0.0165),
        color: appColors.white,
        fontWeight: FontWeight.w500,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        height * (orientation == Orientation.portrait ? 0.075 : 0.1),
      );
}

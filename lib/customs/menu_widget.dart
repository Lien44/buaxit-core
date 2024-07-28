import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuWidget extends StatelessWidget {
  MenuWidget({
    super.key,
    this.onTap,
    this.svg,
    required this.name,
    this.icon,
  });
  final AppColors appColors = AppColors();
  final Function()? onTap;
  final String name;
  final IconData? icon;
  final String? svg;
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: fixSize * 0.145,
        width: orientation == Orientation.portrait
            ? size.width * 0.45
            : size.width * 0.2,
        decoration: BoxDecoration(
          color: appColors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: fixSize * 0.005,
              color: appColors.black.withOpacity(
                0.25,
              ),
            ),
          ],
          borderRadius: BorderRadius.circular(
            fixSize * 0.005,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svg != null
                ? SvgPicture.asset(
                    svg!,
                    placeholderBuilder: (BuildContext context) => Container(),
                    width: fixSize * 0.06,
                  )
                : Icon(
                    icon,
                    color: appColors.mainColor,
                    size: fixSize * 0.06,
                  ),
            CustomText(
              text: name,
              color: appColors.black,
              fontSize: fixSize * 0.0135,
            )
          ],
        ),
      ),
    );
  }
}

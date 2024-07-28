import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:flutter/material.dart';

class RefreshWidget extends StatelessWidget {
  const RefreshWidget(
      {super.key, required this.child, required this.onRefresh});
  final Widget child;
  final Function() onRefresh;
  static AppColors appColors = AppColors();
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return RefreshIndicator(
      color: appColors.white,
      backgroundColor: appColors.mainColor,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        onRefresh();
      },
      child: child,
    );
  }
}

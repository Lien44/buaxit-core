import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:flutter/cupertino.dart';

class LandWidget extends StatelessWidget {
  const LandWidget(
      {Key? key,
      required this.fsize,
      required this.appColors,
      required this.title,
      required this.index})
      : super(key: key);

  final double fsize;
  final AppColors appColors;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          margin: EdgeInsets.only(
            bottom: fsize * 0.01,
            left: fsize * 0.005,
            right: fsize * 0.005,
          ),
          padding: EdgeInsets.symmetric(
              horizontal: fsize * 0.01, vertical: fsize * 0.0075),
          decoration: BoxDecoration(
              color: appColors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [BoxShadow(color: appColors.grey, blurRadius: 2)]),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomText(text: title, fontSize: fsize * 0.0125),
          ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: fsize * 0.005,
              ),
              child: Container(
                width: fsize * 0.03,
                height: fsize * 0.0185,
                decoration: BoxDecoration(
                  color: appColors.mainColor,
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(4)),
                ),
                child: Center(
                  child: CustomText(
                    text: index.toString(),
                    color: appColors.white,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

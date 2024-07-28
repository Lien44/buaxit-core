import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/models/cars_model.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:flutter/cupertino.dart';

class CarsWidget extends StatelessWidget {
  const CarsWidget(
      {Key? key,
      required this.fsize,
      required this.appColors,
      required this.carsModel,
      required this.index})
      : super(key: key);

  final double fsize;
  final AppColors appColors;
  final CarsModel carsModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: fsize * 0.01),
          padding: EdgeInsets.symmetric(
              horizontal: fsize * 0.005, vertical: fsize * 0.0075),
          decoration: BoxDecoration(
              color: appColors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [BoxShadow(color: appColors.grey, blurRadius: 2)]),
          child: Column(children: [
            RangeTextWidget(
              fsize: fsize,
              title1: 'ໄອດີ :',
              title2: carsModel.code ?? '',
            ),
            const SizedBox(
              height: 2.5,
            ),
            RangeTextWidget(
              fsize: fsize,
              title1: 'ຊື່ລົດ :',
              title2: carsModel.name ?? '',
            ),
            const SizedBox(
              height: 2.5,
            ),
            RangeTextWidget(
              fsize: fsize,
              title1: 'ທະບຽນລົດ :',
              title2: carsModel.carNumber ?? '',
            ),
            const SizedBox(
              height: 2.5,
            ),
            RangeTextWidget(
              fsize: fsize,
              title1: 'ເລກໝ໋ອກ :',
              title2: carsModel.tisNumber ?? '',
            ),
            const SizedBox(
              height: 2.5,
            ),
            RangeTextWidget(
              fsize: fsize,
              title1: 'ບໍລິສັດ :',
              title2: carsModel.companyId?.name ?? '',
            ),
          ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
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
          ],
        )
      ],
    );
  }
}

class RangeTextWidget extends StatelessWidget {
  const RangeTextWidget({
    Key? key,
    required this.fsize,
    required this.title1,
    required this.title2,
  }) : super(key: key);

  final double fsize;
  final String title1;
  final String title2;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Row(
      children: [
        Expanded(
            flex: 4, child: CustomText(text: title1, fontSize: fsize * 0.0125)),
        Expanded(
          flex: 8,
          child: CustomText(text: title2, fontSize: fsize * 0.0125),
        ),
      ],
    );
  }
}

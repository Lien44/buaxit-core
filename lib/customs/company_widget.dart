import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/models/company_model.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CompanyWidget extends StatelessWidget {
  const CompanyWidget(
      {Key? key,
      required this.fsize,
      required this.appColors,
      required this.companyModel,
      required this.index})
      : super(key: key);

  final double fsize;
  final AppColors appColors;
  final CompanyModel companyModel;
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: 'ໄອດີ :', fontSize: fsize * 0.0125),
                    const SizedBox(
                      height: 2.5,
                    ),
                    CustomText(text: 'ບໍລິສັດ:', fontSize: fsize * 0.0125),
                    const SizedBox(
                      height: 2.5,
                    ),
                    CustomText(text: 'ທີ່ຢູ່ :', fontSize: fsize * 0.0125),
                  ],
                ),
                SizedBox(
                  width: fsize * 0.025,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: companyModel.code ?? '',
                          fontSize: fsize * 0.0125),
                      const SizedBox(
                        height: 2.5,
                      ),
                      CustomText(
                          text: companyModel.name ?? '',
                          fontSize: fsize * 0.0125),
                      const SizedBox(
                        height: 2.5,
                      ),
                      CustomText(
                          text:
                              '${'ປະເທດ'.tr} ${companyModel.countryName ?? ''}, ${'province'.tr} ${companyModel.proName ?? ''}, ${'district'.tr} ${companyModel.disName ?? ''}, ${'village'.tr} ${companyModel.vilName ?? ''}',
                          fontSize: fsize * 0.0125),
                    ],
                  ),
                ),
              ],
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

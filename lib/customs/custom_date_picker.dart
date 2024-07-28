import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/custom_date_picker_state.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustomDatePicker extends StatelessWidget {
  CustomDatePicker({
    super.key,
    required this.type,
    this.title,
    this.afterSelect,
    this.fontSize
  });
  final double ? fontSize;
  final SelectDateType type;
  final AppColors appColors = AppColors();
  final CustomDatePickerState customDatePickerState =
      Get.put(CustomDatePickerState());
  final String? title;
  final Function()? afterSelect;
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return InkWell(
      onTap: () async {
        if (type == SelectDateType.startDate) {
          await customDatePickerState.pickStartDate(context);
          try {
            afterSelect!();
          } catch (e) {
            return;
          }
          return;
        } else if (type == SelectDateType.endDate) {
          await customDatePickerState.pickEndDate(context);
          try {
            afterSelect!();
          } catch (e) {
            return;
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: fixSize * 0.005,
            ),
            child: CustomText(
              text: title ?? "",
              color: appColors.black,
              fontSize: fontSize ?? fixSize * 0.012,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: appColors.mainColor,
                size: fixSize * 0.045,
              ),
              GetBuilder<CustomDatePickerState>(builder: (date) {
                return Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "ວັນ",
                          color: appColors.grey.withOpacity(
                            0.75,
                          ),
                          fontSize: fixSize * 0.008,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: fixSize * 0.008,
                          ),
                          decoration: BoxDecoration(
                            color: appColors.white,
                            border: Border(
                              left: BorderSide(
                                color: appColors.mainColor,
                                width: 1,
                              ),
                              top: BorderSide(
                                color: appColors.mainColor,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: appColors.mainColor,
                                width: 1,
                              ),
                            ),
                          ),
                          child: type == SelectDateType.startDate
                              ? CustomText(
                                  text: date.startDate != null
                                      ? date.startDate!.day
                                          .toString()
                                          .padLeft(2, "0")
                                      : "- -",
                                  color: appColors.black,
                                  fontSize: fixSize * 0.012,
                                )
                              : CustomText(
                                  text: date.endDate != null
                                      ? date.endDate!.day
                                          .toString()
                                          .padLeft(2, "0")
                                      : "- -",
                                  color: appColors.black,
                                  fontSize: fixSize * 0.012,
                                ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "ເດືອນ",
                          color: appColors.grey.withOpacity(
                            0.75,
                          ),
                          fontSize: fixSize * 0.008,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: fixSize * 0.008,
                          ),
                          decoration: BoxDecoration(
                            color: appColors.white,
                            border: Border(
                              left: BorderSide(
                                color: appColors.mainColor,
                                width: 1,
                              ),
                              top: BorderSide(
                                color: appColors.mainColor,
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: appColors.mainColor,
                                width: 1,
                              ),
                            ),
                          ),
                          child: type == SelectDateType.startDate
                              ? CustomText(
                                  text: date.startDate != null
                                      ? date.startDate!.month
                                          .toString()
                                          .padLeft(2, "0")
                                      : "- -",
                                  color: appColors.black,
                                  fontSize: fixSize * 0.012,
                                )
                              : CustomText(
                                  text: date.endDate != null
                                      ? date.endDate!.month
                                          .toString()
                                          .padLeft(2, "0")
                                      : "- -",
                                  color: appColors.black,
                                  fontSize: fixSize * 0.012,
                                ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "ປີ",
                          color: appColors.grey.withOpacity(
                            0.75,
                          ),
                          fontSize: fixSize * 0.008,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: fixSize * 0.008,
                          ),
                          decoration: BoxDecoration(
                            color: appColors.white,
                            border: Border.all(
                              color: appColors.mainColor,
                              width: 1,
                            ),
                          ),
                          child: type == SelectDateType.startDate
                              ? CustomText(
                                  text: date.startDate != null
                                      ? date.startDate!.year.toString()
                                      : "- - - -",
                                  color: appColors.black,
                                  fontSize: fixSize * 0.012,
                                )
                              : CustomText(
                                  text: date.endDate != null
                                      ? date.endDate!.year.toString()
                                      : "- - - -",
                                  color: appColors.black,
                                  fontSize: fixSize * 0.012,
                                ),
                        )
                      ],
                    ),
                  ],
                );
              })
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              left: fixSize * 0.005,
            ),
            width: size.width * 0.135,
            decoration: BoxDecoration(
                color: appColors.mainColor,
                borderRadius: BorderRadius.circular(
                  fixSize * 0.005,
                )),
            child: Center(
              child: CustomText(
                text: "pick",
                color: appColors.white,
                fontSize: fixSize * 0.012,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum SelectDateType {
  startDate,
  endDate,
}

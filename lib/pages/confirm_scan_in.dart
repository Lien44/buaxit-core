import 'package:bauxite_admin_app/customs/custom_date_picker.dart';
import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/customs/custom_input_format.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/custom_text_field_widget_with_title.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';
import 'package:bauxite_admin_app/models/contract_model.dart';
import 'package:bauxite_admin_app/models/scan_in_out_model.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/camera_scan_page_state.dart';
import 'package:bauxite_admin_app/state/car_state.dart';
import 'package:bauxite_admin_app/state/company_state.dart';
import 'package:bauxite_admin_app/state/custom_date_picker_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmScanInPage extends StatefulWidget {
  const ConfirmScanInPage(
      {super.key, required this.contractModel, this.carModel});
  final ContractModel contractModel;
  final CarModel? carModel;
  @override
  State<ConfirmScanInPage> createState() => _ConfirmScanInPageState();
}

class _ConfirmScanInPageState extends State<ConfirmScanInPage> {
  final AppColors appColors = AppColors();
  CarState carState = Get.put(CarState());
  TextEditingController carNameT = TextEditingController();
  TextEditingController nameT = TextEditingController();
  TextEditingController carNumberT = TextEditingController();
  TextEditingController tisNumberT = TextEditingController();
  TextEditingController noteT = TextEditingController();
  CompanyState companyState = Get.put(CompanyState());
  final CameraScanPageState cameraScanPageState =
      Get.put(CameraScanPageState());
  final GlobalKey _autocompleteKey = GlobalKey();
  TextEditingValue textEditingValue = const TextEditingValue(text: '');
  CustomDatePickerState customDatePickerState =
      Get.put(CustomDatePickerState());

  @override
  void initState() {
    getData();
    customDatePickerState.setStartDate();
    super.initState();
  }

  getData() async {
    await Future.delayed(Duration.zero);
    carState.selectedCar = null;
    carState.weightT.clear();
    if (carState.carModel == null) {
      carState.selectcarModel(widget.carModel!);
    }
  }

  validate(BuildContext context) {
    if (tisNumberT.text.trim().isEmpty) {
      CustomDialogs().showToast(
          context: context,
          text: 'please_enter_all_fiels',
          backgroundColor: appColors.mainColor.withOpacity(0.6));
      return;
    }
    carState.edittipNumber(
        context: context,
        id: widget.carModel?.id.toString() ?? '0',
        tisNumber: tisNumberT.text,
        contractModel: widget.contractModel);
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.mainColor,
        title: CustomText(
          text: 'ສະແກນເຂົ້າ',
          fontSize: fixSize * 0.022,
          color: appColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Column(children: [
                SizedBox(
                  height: fixSize * 0.008,
                ),
                // ChaufferDetail(
                //   appColors: appColors,
                //   fixSize: fixSize,
                //   chaufferModel: cameraScanPageState.chaufferModel!,
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: fixSize * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<CustomDatePickerState>(builder: (get) {
                        return CustomDatePicker(
                          type: SelectDateType.startDate,
                          title: "ວັນທີສະແກນເຂົ້າ",
                          fontSize: fixSize * 0.016,
                        );
                      }),
                      RowBetweenWidget(
                          title: 'ຊື່ບໍລິສັດ',
                          fontSize: fixSize * 0.02,
                          color: appColors.mainColor,
                          data: '${widget.contractModel.companyId?.name}'),
                      RowBetweenWidget(
                          title: 'ລະຫັດສັນຍາ',
                          fontSize: fixSize * 0.016,
                          data: '${widget.contractModel.code}'),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.local_taxi,
                            size: fixSize * 0.02,
                            color: appColors.mainColor,
                          ),
                          GetBuilder<CarState>(builder: (getCar) {
                            return InkWell(
                              onTap: () => {
                                Get.to(showDialog(
                                    context: context,
                                    builder: (builder) {
                                      nameT.text =
                                          widget.carModel?.name.toString() ??
                                              '';
                                      carNumberT.text = widget
                                              .carModel?.carNumber
                                              .toString() ??
                                          '';
                                      noteT.text = widget.carModel?.note != null
                                          ? widget.carModel?.note.toString() ??
                                              ''
                                          : '';
                                      tisNumberT.text = carState
                                              .carModel?.tisNumber
                                              .toString() ??
                                          '';
                                      return AlertDialog(
                                        content: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: fixSize * 0.01),
                                          child: SingleChildScrollView(
                                            child: Column(children: [
                                              SizedBox(
                                                height: fixSize * 0.01,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    text: 'car_name',
                                                    fontSize: fixSize * 0.0145,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  TextFieldWidget(
                                                    controller: nameT,
                                                    hintText: 'car_name',
                                                    readOnly: true,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: fixSize * 0.01,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    text: 'car_number',
                                                    fontSize: fixSize * 0.0145,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  TextFieldWidget(
                                                    controller: carNumberT,
                                                    hintText: 'car_number',
                                                    readOnly: true,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: fixSize * 0.01,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    text: 'ເລກໝ໋ອກ',
                                                    fontSize: fixSize * 0.0145,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  TextFieldWidget(
                                                    controller: tisNumberT,
                                                    hintText: 'ເລກໝ໋ອກ',
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: fixSize * 0.01,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    text: 'note',
                                                    fontSize: fixSize * 0.0145,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  TextFieldWidget(
                                                    controller: noteT,
                                                    hintText: 'note',
                                                    readOnly: true,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: fixSize * 0.02,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              elevation: 5,
                                                              backgroundColor:
                                                                  appColors
                                                                      .grey),
                                                      onPressed: () async {
                                                        Get.back();
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    fixSize *
                                                                        0.01),
                                                        child: CustomText(
                                                          text: 'ຍົກເລີກ',
                                                          color:
                                                              appColors.white,
                                                          fontSize:
                                                              fixSize * 0.015,
                                                        ),
                                                      )),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              elevation: 5,
                                                              backgroundColor:
                                                                  appColors
                                                                      .mainColor),
                                                      onPressed: () async {
                                                        validate(context);
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    fixSize *
                                                                        0.01),
                                                        child: CustomText(
                                                          text: 'ແກ້ໄຂ',
                                                          color:
                                                              appColors.white,
                                                          fontSize:
                                                              fixSize * 0.015,
                                                        ),
                                                      )),
                                                ],
                                              )
                                            ]),
                                          ),
                                        ),
                                      );
                                    }))
                              },
                              child: Icon(
                                Icons.edit,
                                size: fixSize * 0.02,
                                color: appColors.mainColor,
                              ),
                            );
                          }),
                        ],
                      ),
                      GetBuilder<CarState>(builder: (getCar) {
                        return Column(
                          children: [
                            RowBetweenWidget(
                                fontSize: fixSize * 0.016,
                                title: 'ລະຫັດລົດ',
                                data: '${carState.carModel?.code}'),
                            RowBetweenWidget(
                                fontSize: fixSize * 0.016,
                                title: 'ຊື່ລົດ',
                                data: '${carState.carModel?.name}'),
                            RowBetweenWidget(
                                title: 'ເລກທະບຽນ',
                                fontSize: fixSize * 0.016,
                                color: appColors.black,
                                fontWeight: FontWeight.bold,
                                data: '${carState.carModel?.carNumber}'),
                            RowBetweenWidget(
                                title: 'ເລກມ໋ອກ',
                                fontSize: fixSize * 0.016,
                                color: appColors.mainColor,
                                fontWeight: FontWeight.bold,
                                data: '${carState.carModel?.tisNumber}'),
                          ],
                        );
                      }),
                      SizedBox(
                        height: fixSize * 0.005,
                      ),
                      // CustomText(
                      //   text: 'ເລືອກລົດ',
                      //   fontSize: fixSize * 0.0145,
                      //   fontWeight: FontWeight.w600,
                      // ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      // Row(
                      //   children: [
                      //     Expanded(child: GetBuilder<CarState>(builder: (get) {
                      //       return Autocomplete<CarsModel>(
                      //         key: _autocompleteKey,
                      //         optionsBuilder:
                      //             (TextEditingValue textEditingValue) {
                      //           // if (textEditingValue.text == '') {
                      //           //   return [];
                      //           // }

                      //           return get.carsListBycompany
                      //               .where((element) =>
                      //                   (element.name ?? '').toLowerCase().contains(textEditingValue.text.toLowerCase()) ||
                      //                   (element.carNumber ?? '')
                      //                       .toLowerCase()
                      //                       .contains(textEditingValue.text
                      //                           .toLowerCase()) ||
                      //                   (element.code ?? '')
                      //                       .toLowerCase()
                      //                       .contains(textEditingValue.text
                      //                           .toLowerCase()) ||
                      //                   (element.tisNumber ?? '')
                      //                       .toLowerCase()
                      //                       .contains(textEditingValue.text
                      //                           .toLowerCase()) ||
                      //                   ('${element.code ?? ''} - ${element.name ?? ''} ທະບຽນ: ${element.carNumber ?? ''} ໝ໋ອກ: ${element.tisNumber ?? ''}')
                      //                       .toLowerCase()
                      //                       .contains(textEditingValue.text
                      //                           .toLowerCase()))
                      //               .toList();
                      //         },
                      //         displayStringForOption: (CarsModel data) =>
                      //             '${data.code ?? ''} - ${data.name ?? ''} ທະບຽນ: ${data.carNumber ?? ''} ໝ໋ອກ: ${data.tisNumber ?? ''}',
                      //         fieldViewBuilder: (context, textEditingController,
                      //             focusNode, onFieldSubmitted) {
                      //           return GetBuilder<CarState>(
                      //               builder: (getNewCar) {
                      //             if (textEditingController.text.isEmpty) {
                      //               textEditingController.text = ' ';
                      //             }
                      //             return TextFieldWidget(
                      //               controller: carNameT,
                      //               hintText: 'ເລືອກລົດ',
                      //               focusNode: focusNode,
                      //               onChange: (v) {
                      //                 textEditingController.text = v;
                      //               },
                      //             );
                      //           });
                      //         },
                      //         optionsMaxHeight: fixSize * 0.15,
                      //         onSelected: (selection) {
                      //           get.selectCars(selection);
                      //           carNameT.text =
                      //               '${selection.code ?? ''} - ${selection.name ?? ''} ທະບຽນ: ${selection.carNumber ?? ''} ໝ໋ອກ: ${selection.tisNumber ?? ''}';

                      //           setState(() {});
                      //         },
                      //       );
                      //     })),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     InkWell(
                      //       onTap: () async {
                      //         var res = await Get.to(() => const AddCarsPage(),
                      //             transition: Transition.rightToLeft);
                      //         if (res == true) {
                      //           carState.getCarsByCompany(
                      //             cameraScanPageState
                      //                 .chaufferModel!.companyId!.id
                      //                 .toString(),
                      //           );
                      //         }
                      //       },
                      //       child: Container(
                      //         color: appColors.mainColor,
                      //         width: fixSize * 0.05,
                      //         height: fixSize * 0.035,
                      //         child: Icon(
                      //           Icons.add,
                      //           color: appColors.white,
                      //           size: fixSize * 0.018,
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: GetBuilder<CarState>(builder: (get) {
                      //         return DropDownWidget(
                      //             fixSize: fixSize,
                      //             value: carState.selectedCar,
                      //             hint: "ເລືອກລົດ",
                      //             listMenuItems: carState.carsListBycompany
                      //                 .map((e) => DropdownMenuItem(
                      //                     value: e,
                      //                     child: CustomText(
                      //                       text:
                      //                           '${e.name ?? ""} ${e.carNumber ?? ''}',
                      //                     )))
                      //                 .toList(),
                      //             onChange: (value) {
                      //               get.selectCars(value);
                      //             });
                      //       }),
                      //     ),
                      //   ],
                      // ),
                      Divider(
                        thickness: 0.5,
                        color: appColors.grey,
                      ),
                      SizedBox(
                        height: fixSize * 0.01,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              keyBoardType: TextInputType.text,
                              controller: carState.weightT,
                              inputFormatter: [
                                CustomNumberFormatter(),
                              ],
                              titleSize: fixSize * 0.0145,
                              title: "ນ້ຳໜັກລົດເປົ່າ",
                              hint: "ນ້ຳໜັກລົດເປົ່າ",
                              trailingText: "ໂຕນ",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: fixSize * 0.02,
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: size.height * 0.55,
                ),
              ]),
            ),
          ),
          GestureDetector(
            onTap: () async {
              // if (carState.selectedCar == null) {
              //   return CustomDialogs().showToast(
              //     context: context,
              //     text: "ກະລຸນາເລືອກລົດຂົນສົ່ງ",
              //   );
              // }
              if (carState.weightT.text.isEmpty) {
                return CustomDialogs().showToast(
                  context: context,
                  text: "ກະລຸນາປ້ອນນ້ຳໜັກລົດເປົ໋າ",
                );
              }

              var result = await CustomDialogs().yesAndNoDialogWithText(
                  context, fixSize, "ຕ້ອງການສະແກນເຂົ້າ ຫຼື ບໍ່");
              if (result) {
                CustomDialogs().dialogLoading();
                try {
                  await cameraScanPageState
                      .scanIn(
                          contractId: widget.contractModel.id.toString(),
                          carId: widget.carModel!.id.toString())
                      .then((res) async {
                    Get.back();
                    if (res.statusCode == 200) {
                      CustomDialogs().showToast(
                        context: context,
                        text: "ສະແກນເຂົ້າສຳເລັດ",
                      );
                      Get.until((route) => Get.currentRoute == "/ScanPage");
                    } else {
                      throw res.statusCode;
                    }
                  });
                } catch (e) {
                  Get.back();
                  // ignore: use_build_context_synchronously
                  CustomDialogs().showToast(
                    context: context,
                    text: "something_wrong",
                  );
                }
              }
            },
            child: Container(
              width: size.width,
              height: fixSize * 0.04,
              color: appColors.mainColor,
              child: Center(
                  child: CustomText(
                text: 'ຢືນຢັນ',
                color: appColors.white,
                fontSize: fixSize * 0.0145,
              )),
            ),
          )
        ],
      ),
    );
  }
}

// class ChaufferDetail extends StatelessWidget {
//   const ChaufferDetail({
//     Key? key,
//     required this.appColors,
//     required this.fixSize,
//     required this.chaufferModel,
//   }) : super(key: key);

//   final AppColors appColors;
//   final double fixSize;
//   // final ChaufferModel chaufferModel;

//   @override
//   Widget build(BuildContext context) {
//     Orientation orientation = MediaQuery.of(context).orientation;
//     return Container(
//       margin: EdgeInsets.only(bottom: fixSize * 0.01),
//       padding: EdgeInsets.all(fixSize * 0.01),
//       decoration: BoxDecoration(
//           color: appColors.white,
//           boxShadow: [BoxShadow(color: appColors.grey, blurRadius: 2)]),
//       child: Column(children: [
//         Row(
//           children: [
//             CustomText(
//               text: 'ຂໍ້ມູນໂຊເຟີ',
//               color: appColors.mainColor,
//               fontSize: fixSize * 0.0165,
//             ),
//           ],
//         ),
//         RowBetweenWidget(
//           title: 'ຊື່ບໍລິສັດ',
//           data: '${chaufferModel.companyId?.name}',
//         ),
//         RowBetweenWidget(
//           title: 'ລະຫັດໂຊເຟີ',
//           data: '${chaufferModel.code}',
//         ),
//         RowBetweenWidget(
//           title: 'username',
//           data: '${chaufferModel.userId?.name}',
//         ),
//         RowBetweenWidget(
//           title: 'ເລກທີ Passport',
//           data: '${chaufferModel.passport}',
//         ),
//         RowBetweenWidget(
//           title: 'ວັນໝົດກຳນົດ',
//           data: '${FormatMonthYear(dateTime: chaufferModel.dateExpired)}',
//         ),
//       ]),
//     );
//   }
// }

class RowBetweenWidget extends StatelessWidget {
  const RowBetweenWidget(
      {Key? key,
      required this.title,
      required this.data,
      this.fontSize,
      this.fontWeight,
      this.color})
      : super(key: key);

  final String title;
  final String data;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  static AppColors appColors = AppColors();

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              color: color ?? appColors.black,
              fontWeight: fontWeight,
              fontSize: fontSize ?? fixSize * 0.0135,
            ),
            CustomText(
              text: data,
              color: color ?? appColors.black,
              fontWeight: fontWeight,
              fontSize: fontSize ?? fixSize * 0.0135,
            )
          ],
        ),
      ],
    );
  }
}

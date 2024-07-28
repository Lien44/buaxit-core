import 'package:bauxite_admin_app/customs/custom_date_picker.dart';
import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/custom_text_field_widget_with_title.dart';
import 'package:bauxite_admin_app/functions/format_month_year.dart';
import 'package:bauxite_admin_app/functions/format_price.dart';
import 'package:bauxite_admin_app/models/chauffer_model.dart';
import 'package:bauxite_admin_app/pages/waiting_scan_down.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/camera_scan_page_state.dart';
import 'package:bauxite_admin_app/state/car_state.dart';
import 'package:bauxite_admin_app/state/custom_date_picker_state.dart';
import 'package:bauxite_admin_app/state/mineral_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanDownWarehousePage extends StatefulWidget {
  const ScanDownWarehousePage({super.key});

  @override
  State<ScanDownWarehousePage> createState() => _ScanDownWarehousePageState();
}

class _ScanDownWarehousePageState extends State<ScanDownWarehousePage> {
  final AppColors appColors = AppColors();
  CarState carState = Get.put(CarState());
  MineralState mineralState = Get.put(MineralState());
  final CameraScanPageState cameraScanPageState =
      Get.put(CameraScanPageState());
  CustomDatePickerState customDatePickerState =
      Get.put(CustomDatePickerState());
  @override
  void initState() {
    getData();
    mineralState.getData();
    customDatePickerState.setStartDate();
    super.initState();
  }

  getData() async {
    await Future.delayed(Duration.zero);
    carState.selectedCar = null;
    carState.weightT.clear();
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
          text: 'ສະແກນລົງສາງ',
          fontSize: fixSize * 0.022,
          color: appColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(children: [
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
                        fontSize: fixSize * 0.0145,
                        title: "ວັນທີສະແກນລົງສາງ",
                      );
                    }),
                    RowBetweenWidget(
                        title: 'ລະຫັດສັນຍາ',
                        data: cameraScanPageState
                                .scanOutModel?.contractModel?.code ??
                            ''),
                    RowBetweenWidget(
                        title: 'ລະຫັດທຸລະກໍາ',
                        data: cameraScanPageState.scanOutModel?.code ?? ''),
                    SizedBox(
                      height: fixSize * 0.005,
                    ),
                    RowBetweenWidget(
                        title: 'ຊື່ລົດ',
                        data:
                            cameraScanPageState.scanOutModel?.carModel?.name ??
                                ''),
                    SizedBox(
                      height: fixSize * 0.005,
                    ),
                    RowBetweenWidget(
                        title: 'ເລກທະບຽນ',
                        fontWeight: FontWeight.bold,
                        color: appColors.black,
                        data: cameraScanPageState
                                .scanOutModel?.carModel?.carNumber ??
                            ''),
                    SizedBox(
                      height: fixSize * 0.005,
                    ),
                    RowBetweenWidget(
                        title: 'ເລກໝ໋ອກ',
                        fontWeight: FontWeight.bold,
                        color: appColors.mainColor,
                        data: cameraScanPageState
                                .scanOutModel?.carModel?.tisNumber ??
                            ''),
                    SizedBox(
                      height: fixSize * 0.005,
                    ),
                    RowBetweenWidget(
                        title: 'ນ້ຳໜັກລົດເປົ່າ',
                        data:
                            '${cameraScanPageState.scanOutModel?.carWeight ?? ''} ໂຕນ'),
                    RowBetweenWidget(
                        title: 'ນ້ຳໜັກແຮ່ທາດ',
                        data:
                            '${cameraScanPageState.scanOutModel?.metalWeight ?? ''} ໂຕນ'),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     CustomText(
                    //       text: 'ເລືອກຂໍ້ມູນບໍ່',
                    //       fontSize: fixSize * 0.0145,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //     const SizedBox(
                    //       height: 5,
                    //     ),
                    //     Row(
                    //       children: [
                    //         Expanded(
                    //           child:
                    //               GetBuilder<MineralState>(builder: (company) {
                    //             return DropDownWidget(
                    //                 fixSize: fixSize,
                    //                 value: mineralState.selectMineral,
                    //                 hint: "ຂໍ້ມູນບໍ່",
                    //                 listMenuItems: mineralState.mineralList
                    //                     .map((e) => DropdownMenuItem(
                    //                         value: e,
                    //                         child: CustomText(
                    //                           text: e.name ?? "",
                    //                         )))
                    //                     .toList(),
                    //                 onChange: (value) {
                    //                   company.selectMineralData(value);
                    //                 });
                    //           }),
                    //         ),
                    //         const SizedBox(
                    //           width: 10,
                    //         ),
                    //         InkWell(
                    //           onTap: () async {
                    //             var res = await Get.to(() => const AddMineral(),
                    //                 transition: Transition.rightToLeft);
                    //             if (res == true) {
                    //               mineralState.getData();
                    //             }
                    //           },
                    //           child: Container(
                    //             color: appColors.mainColor,
                    //             width: fixSize * 0.05,
                    //             height: fixSize * 0.035,
                    //             child: Icon(
                    //               Icons.add,
                    //               color: appColors.white,
                    //               size: fixSize * 0.02,
                    //             ),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: fixSize * 0.01,
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFieldWithTitle(
                            onFieldSubmitted: (p0) {
                              carState.update();
                            },
                            onChange: (p1) {
                              carState.update();
                            },
                            keyBoardType: TextInputType.text,
                            controller: carState.weightT,
                            inputFormatter: const [
                              // CustomNumberFormatter(),
                            ],
                            titleSize: fixSize * 0.0145,
                            title: "ນ້ຳໜັກລົດລວມແຮ່ທາດລົງສາງຕົວຈິງ",
                            hint: "ນ້ຳໜັກລົດລວມແຮ່ທາດລົງສາງຕົວຈິງ",
                            trailingText: "ໂຕນ",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: fixSize * 0.01,
                    ),
                    GetBuilder<CarState>(builder: (get) {
                      double metal = 0;
                      if ((double.tryParse(
                                  get.weightT.text.replaceAll(',', '')) ??
                              0) !=
                          0) {
                        metal = (double.tryParse(get.weightT.text) ?? 0) -
                            double.parse(
                                cameraScanPageState.scanOutModel?.carWeight ??
                                    '0');
                      }
                      // print(double.tryParse(carState.weightT.text) ?? 0);
                      return RowBetweenWidget(
                          fontSize: fixSize * 0.02,
                          color: appColors.mainColor,
                          fontWeight: FontWeight.bold,
                          title: 'ນ້ຳໜັກແຮ່ທາດຕົວຈີງ',
                          data:
                              '${FormatPrice(price: num.parse(metal.toString()))} ໂຕນ');
                    }),
                  ],
                ),
              ),
            ]),
          ),
          GestureDetector(
            onTap: () async {
              if (mineralState.selectMineral == null) {
                return CustomDialogs().showToast(
                  context: context,
                  text: "ກະລຸນາເລືອກຂໍ້ມູນບໍ່ກ່ອນ",
                );
              }
              if (carState.weightT.text.isEmpty) {
                return CustomDialogs().showToast(
                  context: context,
                  text: "ກະລຸນາປ້ອນນ້ຳໜັກລົດລວມແຮ່ທາດ",
                );
              }

              var result = await CustomDialogs().yesAndNoDialogWithText(
                  context, fixSize, "ຕ້ອງການສະແກນລົງສາງ ຫຼື ບໍ່");
              if (result) {
                try {
                  await cameraScanPageState
                      .scanDownWarehouse(
                          code:
                              cameraScanPageState.scanOutModel!.code.toString(),
                          totalWeight: carState.weightT.text.trim(),
                          mineralId: mineralState.selectMineral!.id!.toString(),
                          actualWeight:
                              ((double.tryParse(carState.weightT.text) ?? 0) -
                                      double.parse(cameraScanPageState
                                              .scanOutModel?.carWeight ??
                                          '0'))
                                  .toString(),
                          metalWeight: '')
                      .then((res) {
                    print(
                        '8888888888888888888888888888888888888888888888888888');
                    print(res.body);
                    if (res.statusCode == 200) {
                      CustomDialogs().showToast(
                        context: context,
                        text: "ສະແກນລົງສາງສຳເລັດ",
                      );
                      Get.until((route) => Get.currentRoute == "/ScanPage");
                      Get.to(() => const WaitingScanDownPage());
                    } else {
                      throw res.body;
                    }
                  });
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  print(e.toString());
                  CustomDialogs()
                      .showToast(context: context, text: 'something_wrong');
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

class ChaufferDetail extends StatelessWidget {
  const ChaufferDetail({
    Key? key,
    required this.appColors,
    required this.fixSize,
    required this.chaufferModel,
  }) : super(key: key);

  final AppColors appColors;
  final double fixSize;
  final ChaufferModel chaufferModel;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      margin: EdgeInsets.only(bottom: fixSize * 0.01),
      padding: EdgeInsets.all(fixSize * 0.01),
      decoration: BoxDecoration(
          color: appColors.white,
          boxShadow: [BoxShadow(color: appColors.grey, blurRadius: 2)]),
      child: Column(children: [
        Row(
          children: [
            CustomText(
              text: 'ຂໍ້ມູນໂຊເຟີ',
              color: appColors.mainColor,
              fontSize: fixSize * 0.0165,
            ),
          ],
        ),
        RowBetweenWidget(
          title: 'ຊື່ບໍລິສັດ',
          data: '${chaufferModel.companyId?.name}',
        ),
        RowBetweenWidget(
          title: 'ລະຫັດໂຊເຟີ',
          data: '${chaufferModel.code}',
        ),
        RowBetweenWidget(
          title: 'username',
          data: '${chaufferModel.userId?.name}',
        ),
        RowBetweenWidget(
          title: 'ເລກທີ Passport',
          data: '${chaufferModel.passport}',
        ),
        RowBetweenWidget(
          title: 'ວັນໝົດກຳນົດ',
          data: '${FormatMonthYear(dateTime: chaufferModel.dateExpired)}',
        ),
      ]),
    );
  }
}

class RowBetweenWidget extends StatelessWidget {
  const RowBetweenWidget(
      {Key? key,
      required this.title,
      required this.data,
      this.fontSize,
      this.color,
      this.fontWeight})
      : super(key: key);

  final String title;
  final String data;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
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

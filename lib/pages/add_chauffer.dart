import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/drop_down_widget.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';
import 'package:bauxite_admin_app/models/chauffer_model.dart';
import 'package:bauxite_admin_app/models/company_model.dart';
import 'package:bauxite_admin_app/models/user_model.dart';
import 'package:bauxite_admin_app/pages/add_cars.dart';
import 'package:bauxite_admin_app/pages/add_company.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/car_state.dart';
import 'package:bauxite_admin_app/state/company_state.dart';
import 'package:bauxite_admin_app/state/user_setting_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:bauxite_admin_app/models/scan_in_out_log_model.dart' as carM;
import 'package:bauxite_admin_app/models/cars_model.dart' as oldCarM;

class AddChaufferPage extends StatefulWidget {
  const AddChaufferPage(
      {super.key,
      required this.roleId,
      required this.title,
      this.chaufferModel});
  final String roleId;
  final String title;
  final ChaufferModel? chaufferModel;

  @override
  State<AddChaufferPage> createState() => _AddChaufferPageState();
}

class _AddChaufferPageState extends State<AddChaufferPage> {
  final AppColors appColors = AppColors();
  TextEditingController nameT = TextEditingController();
  TextEditingController phoneT = TextEditingController();
  TextEditingController passT = TextEditingController();
  TextEditingController confT = TextEditingController();
  TextEditingController passportT = TextEditingController();
  TextEditingController monthT = TextEditingController();
  TextEditingController yearT = TextEditingController();

  UserSettingState userSettingState = Get.put(UserSettingState());
  CompanyState companyState = Get.put(CompanyState());
  CarState carState = Get.put(CarState());
  var monthF = DateFormat('MM');
  var yearF = DateFormat('yyyy');
  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    if (widget.chaufferModel != null) {
      nameT.text = widget.chaufferModel?.userId?.name ?? '';
      phoneT.text = widget.chaufferModel?.userId?.phone ?? '';
      passportT.text = widget.chaufferModel?.passport ?? '';
      monthT.text =
          DateTime.tryParse(widget.chaufferModel?.dateExpired ?? '') != null
              ? monthF.format(
                  DateTime.parse(widget.chaufferModel?.dateExpired ?? ''))
              : '';
      yearT.text = DateTime.tryParse(widget.chaufferModel?.dateExpired ?? '') !=
              null
          ? yearF
              .format(DateTime.parse(widget.chaufferModel?.dateExpired ?? ''))
          : '';
      companyState.setInitCompany(
          companyModel: CompanyModel(id: widget.chaufferModel?.companyId?.id));
      await carState
          .getCarsByCompany(widget.chaufferModel!.companyId!.id.toString());
      carState.setInitCarsByCompany(
          carsModel: oldCarM.CarsModel(id: widget.chaufferModel?.carmodel?.id));
    }
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
          text: widget.chaufferModel != null
              ? 'ແກ້ໄຂຜູ້ໃຊ້ງານລະບົບ'
              : 'ເພີ່ມຜູ້ໃຊ້ງານລະບົບ',
          fontSize: fixSize * 0.022,
          color: appColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: fixSize * 0.01),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'ສິດໃຊ້ງານ',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  text: widget.title,
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
            SizedBox(
              height: fixSize * 0.01,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'username',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: nameT,
                  hintText: 'username',
                ),
              ],
            ),
            SizedBox(
              height: fixSize * 0.01,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'phone',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: phoneT,
                  hintText: 'phone',
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
            SizedBox(
              height: fixSize * 0.01,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'password',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: passT,
                  hintText: 'password',
                  obsureText: true,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: fixSize * 0.01,
                ),
                CustomText(
                  text: 'confirm_pass',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: confT,
                  hintText: 'confirm_pass',
                  obsureText: true,
                ),
              ],
            ),
            SizedBox(
              height: fixSize * 0.01,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'company',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GetBuilder<CompanyState>(builder: (company) {
                        return DropDownWidget(
                            fixSize: fixSize,
                            value: companyState.selectedCompany,
                            hint: "company",
                            listMenuItems: companyState.companyList
                                .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: CustomText(
                                      text: e.name ?? "",
                                    )))
                                .toList(),
                            onChange: (value) {
                              company.selectCompany(value);
                              carState.selectedCar = null;
                              carState.getCarsByCompany(value.id.toString());
                            });
                      }),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        var res = await Get.to(() => const AddEditCompanyPage(),
                            transition: Transition.rightToLeft);
                        if (res == true) {
                          companyState.getCompany();
                        }
                      },
                      child: Container(
                        color: appColors.mainColor,
                        width: fixSize * 0.05,
                        height: fixSize * 0.035,
                        child: Icon(
                          Icons.add,
                          color: appColors.white,
                          size: fixSize * 0.02,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: fixSize * 0.01,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'ລົດ (ຖ້າມີ)',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GetBuilder<CarState>(builder: (getCar) {
                        return DropDownWidget(
                            fixSize: fixSize,
                            value: getCar.selectedCar,
                            isExpanded: true,
                            hint: "ເລືອກລົດ",
                            listMenuItems: getCar.carsListBycompany.map((e) {
                              var value =
                                  '${e.name ?? ''} ທະບຽນ: ${e.carNumber ?? ''} ໝ໋ອກ: ${e.tisNumber ?? ''}';

                              return DropdownMenuItem(
                                  value: e,
                                  child: CustomText(
                                    text: value,
                                  ));
                            }).toList(),
                            onChange: (value) {
                              getCar.selectCars(value);
                            });
                      }),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        var res = await Get.to(() => const AddCarsPage(),
                            transition: Transition.rightToLeft);
                        if (res == true) {
                          if (companyState.selectedCompany != null) {
                            carState.selectedCar = null;
                            carState.getCarsByCompany(
                                companyState.selectedCompany!.id.toString());
                          }
                        }
                      },
                      child: Container(
                        color: appColors.mainColor,
                        width: fixSize * 0.05,
                        height: fixSize * 0.035,
                        child: Icon(
                          Icons.add,
                          color: appColors.white,
                          size: fixSize * 0.02,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: fixSize * 0.01,
                ),
                CustomText(
                  text: 'passport',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: passportT,
                  hintText: 'passport',
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: fixSize * 0.01,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        text: 'ເດືອນໝົດກຳນົດ',
                        fontSize: fixSize * 0.0145,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: fixSize * 0.01,
                    ),
                    Expanded(
                      child: CustomText(
                        text: 'ປີໝົດກຳນົດ',
                        fontSize: fixSize * 0.0145,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        controller: monthT,
                        hintText: 'mm',
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: fixSize * 0.01,
                    ),
                    Expanded(
                      child: TextFieldWidget(
                        controller: yearT,
                        hintText: 'yyyy',
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: fixSize * 0.02,
            ),
            widget.chaufferModel != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 5, backgroundColor: appColors.grey),
                          onPressed: () async {
                            delete(fixSize);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: fixSize * 0.01),
                            child: CustomText(
                              text: 'ລົບຂໍ້ມູນໂຊເຟີ',
                              color: appColors.white,
                              fontSize: fixSize * 0.015,
                            ),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: appColors.mainColor),
                          onPressed: () async {
                            validate();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: fixSize * 0.01),
                            child: CustomText(
                              text: 'ແກ້ໄຂຂໍ້ມູນໂຊເຟີ',
                              color: appColors.white,
                              fontSize: fixSize * 0.015,
                            ),
                          )),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: appColors.mainColor),
                          onPressed: () async {
                            validate();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: fixSize * 0.01),
                            child: CustomText(
                              text: 'ເພິ່ມຂໍ້ມູນໂຊເຟີ',
                              color: appColors.white,
                              fontSize: fixSize * 0.015,
                            ),
                          )),
                    ],
                  )
          ]),
        ),
      ),
    );
  }

  delete(double fixSize) async {
    var res = await CustomDialogs().yesAndNoDialogWithText(
        context, fixSize, 'ທ່ານຕ້ອງການລົບຂໍ້ມູນໂຊເຟີນີ້ແທ້ ຫຼື ບໍ່?');

    if (res == true) {
      if (mounted) {
        await userSettingState.deleteChauffer(context, widget.chaufferModel!);
      }
    }
  }

  validate() {
    if (nameT.text.trim().isEmpty ||
        phoneT.text.trim().isEmpty ||
        passportT.text.trim().isEmpty ||
        monthT.text.trim().isEmpty ||
        yearT.text.trim().isEmpty ||
        companyState.selectedCompany == null) {
      CustomDialogs().showToast(
          context: context,
          text: 'please_enter_all_fiels',
          backgroundColor: appColors.mainColor.withOpacity(0.6));
      return;
    }
    if (widget.chaufferModel == null) {
      if (passT.text.trim().isEmpty || confT.text.trim().isEmpty) {
        CustomDialogs().showToast(
            context: context,
            text: 'please_enter_all_fiels',
            backgroundColor: appColors.mainColor.withOpacity(0.6));
        return;
      }
      if (passT.text.trim() != confT.text.trim()) {
        CustomDialogs().showToast(
            context: context,
            text: 'pass_not_match',
            backgroundColor: appColors.mainColor.withOpacity(0.6));
        return;
      }
    }

    if (widget.chaufferModel != null) {
      try {
        DateTime.parse(
            '${yearT.text.trim().padLeft(2, '0')}-${monthT.text.trim().padLeft(2, '0')}-01 00:00:00');
      } catch (e) {
        CustomDialogs().showToast(
            context: context,
            text: 'somthing_wrong',
            backgroundColor: appColors.mainColor.withOpacity(0.6));
        return;
      }

      var newUser = ChaufferModel(
        id: widget.chaufferModel!.id,
        passport: passportT.text.trim(),
        dateExpired: '${yearT.text.trim()}-${monthT.text.trim()}-01 00:00:00',
        userId: UserModel(
          id: widget.chaufferModel?.userId?.id,
          roleId: int.parse(widget.roleId),
          name: nameT.text.trim(),
          passWord: passT.text.isEmpty ? null : passT.text.trim(),
          phone: phoneT.text.trim(),
        ),
        carmodel: carState.selectedCar == null
            ? null
            : carM.CarModel(id: carState.selectedCar?.id),
        companyId: CompanyId(id: companyState.selectedCompany?.id),
      );
      userSettingState.editChauffer(context, newUser);
      return;
    }

    try {
      DateTime.parse(
          '${yearT.text.trim().padLeft(2, '0')}-${monthT.text.trim().padLeft(2, '0')}-01 00:00:00');
    } catch (e) {
      CustomDialogs().showToast(
          context: context,
          text: 'somthing_wrong',
          backgroundColor: appColors.mainColor.withOpacity(0.6));
      return;
    }
    var newUser = ChaufferModel(
      passport: passportT.text.trim(),
      dateExpired: '${yearT.text.trim()}-${monthT.text.trim()}-01 00:00:00',
      userId: UserModel(
        roleId: int.parse(widget.roleId),
        name: nameT.text.trim(),
        passWord: passT.text.trim(),
        phone: phoneT.text.trim(),
      ),
      carmodel: carState.selectedCar == null
          ? null
          : carM.CarModel(id: carState.selectedCar?.id),
      companyId: CompanyId(id: companyState.selectedCompany?.id),
    );
    userSettingState.addChauffer(context, newUser);
  }
}

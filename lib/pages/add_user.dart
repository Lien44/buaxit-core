import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';
import 'package:bauxite_admin_app/models/user_model.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/user_setting_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage(
      {super.key, required this.roleId, required this.title, this.userModel});
  final String roleId;
  final String title;
  final UserModel? userModel;

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final AppColors appColors = AppColors();
  TextEditingController nameT = TextEditingController();
  TextEditingController phoneT = TextEditingController();
  TextEditingController passT = TextEditingController();
  TextEditingController confT = TextEditingController();

  UserSettingState userSettingState = Get.put(UserSettingState());

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    if (widget.userModel != null) {
      nameT.text = widget.userModel?.name ?? '';
      phoneT.text = widget.userModel?.phone ?? '';
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
          text: widget.userModel != null
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
            SizedBox(
              height: fixSize * 0.01,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
              height: fixSize * 0.02,
            ),
            widget.userModel != null
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
                              text: 'ລົບຂໍ້ມູນຜູ້ໃຊ້',
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
                              text: 'ແກ້ໄຂຂໍ້ມູນຜູ້ໃຊ້',
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
                              text: 'ເພິ່ມຂໍ້ມູນຜູ້ໃຊ້',
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
        context, fixSize, 'ທ່ານຕ້ອງການລົບຂໍ້ມູນຜູ້ໃຊ້ນີ້ແທ້ ຫຼື ບໍ່?');

    if (res == true) {
      if (mounted) {
        await userSettingState.deleteUser(context, widget.userModel!);
      }
    }
  }

  validate() {
    if (nameT.text.trim().isEmpty || phoneT.text.trim().isEmpty) {
      CustomDialogs().showToast(
          context: context,
          text: 'please_enter_all_fiels',
          backgroundColor: appColors.mainColor.withOpacity(0.6));
      return;
    }
    if (widget.userModel == null) {
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

    if (widget.userModel != null) {
      var newUser = UserModel(
          id: widget.userModel!.id,
          name: nameT.text.trim(),
          phone: phoneT.text.trim(),
          roleId: int.parse(widget.roleId),
          passWord: passT.text.isEmpty ? null : passT.text.trim());
      userSettingState.editUser(context, newUser);
      return;
    }
    var newUser = UserModel(
        name: nameT.text.trim(),
        phone: phoneT.text.trim(),
        roleId: int.parse(widget.roleId),
        passWord: passT.text.trim());
    userSettingState.addUser(context, newUser);
  }
}
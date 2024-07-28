import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';
import 'package:bauxite_admin_app/models/user_model.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/profile_edit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key, this.userModel});
  final UserModel? userModel;

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final AppColors appColors = AppColors();
  TextEditingController nameT = TextEditingController();
  TextEditingController phoneT = TextEditingController();
  TextEditingController passT = TextEditingController();
  TextEditingController confT = TextEditingController();

  ProfileEditState profileEditState = Get.put(ProfileEditState());

  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() async {
    setState(() {
      nameT.text = widget.userModel?.name ?? '';
      phoneT.text = widget.userModel?.phone ?? '';
    });
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
          text: 'ແກ້ໄຂໂປຣຟາຍ',
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     CustomText(
            //       text: 'ສິດໃຊ້ງານ',
            //       fontSize: fixSize * 0.0145,
            //       fontWeight: FontWeight.w600,
            //     ),
            //     CustomText(
            //       text: widget.title,
            //       fontSize: fixSize * 0.0145,
            //       fontWeight: FontWeight.w600,
            //     )
            //   ],
            // ),
            // SizedBox(
            //   height: fixSize * 0.01,
            // ),
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
                  text: 'new_password',
                  fontSize: fixSize * 0.0145,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: passT,
                  hintText: 'new_password',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5, backgroundColor: appColors.mainColor),
                    onPressed: () {
                      profileEditState.profileEdit(
                          nameT.text.trim(), phoneT.text.trim(), passT.text.trim(),confT.text.trim());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: appColors.white,
                          size: fixSize * 0.018,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: fixSize * 0.01),
                          child: CustomText(
                            text: 'ຍືນຍັນແກ້ໄຂ',
                            color: appColors.white,
                            fontSize: fixSize * 0.015,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  validate() {
    if (nameT.text.trim().isEmpty || phoneT.text.trim().isEmpty) {
      CustomDialogs().showToast(
          context: context,
          text: 'please_enter_all_fiels',
          backgroundColor: appColors.mainColor.withOpacity(0.6));
      return;
    }
    // if (widget.userModel == null) {
    //   if (passT.text.trim().isEmpty || confT.text.trim().isEmpty) {
    //     CustomDialogs().showToast(
    //         context: context,
    //         text: 'please_enter_all_fiels',
    //         backgroundColor: appColors.mainColor.withOpacity(0.6));
    //     return;
    //   }
    //   if (passT.text.trim() != confT.text.trim()) {
    //     CustomDialogs().showToast(
    //         context: context,
    //         text: 'pass_not_match',
    //         backgroundColor: appColors.mainColor.withOpacity(0.6));
    //     return;
    //   }
    // }

    if (widget.userModel != null) {
      var editUser = UserModel(
        id: widget.userModel!.id,
        name: nameT.text.trim(),
        phone: phoneT.text.trim(),
        // passWord: passT.text.isEmpty ? null : passT.text.trim()
      );
      // profileEditState.profileEdit(context, newUser);
      return;
    }
  }
}

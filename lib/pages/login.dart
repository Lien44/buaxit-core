import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/customs/custom_field.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/login_register_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AppColors appColors = AppColors();
  TextEditingController phoneC = TextEditingController();
  TextEditingController passC = TextEditingController();

  LoginRegisterState loginRegisterState = Get.put(LoginRegisterState());
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fsize = size.width + size.height;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: fsize * 0.025,
                right: fsize * 0.025,
                top: fsize * 0.1,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: fsize * 0.15,
                    height: fsize * 0.15,
                    // decoration: BoxDecoration(
                    //   border: Border.all(width: 1, color: appColors.grey),
                    //   borderRadius: BorderRadius.circular(9999),
                    // ),
                    child: Center(
                      child: CustomText(
                        text: 'BX',
                        color: appColors.mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: fsize * 0.085,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: fsize * 0.016,
                  ),
                  CustomText(
                    text: 'Lao Bauxite',
                    fontSize: fsize * 0.02,
                    color: appColors.mainColor,
                    fontWeight: FontWeight.w600,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: 'login',
                        fontSize: fsize * 0.02,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFieldText(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: appColors.mainColor,
                      size: fsize * 0.0185,
                    ),
                    controller: phoneC,
                    appColor: appColors,
                    hintText: 'phone',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFieldText(
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: appColors.mainColor,
                      size: fsize * 0.0185,
                    ),
                    controller: passC,
                    appColor: appColors,
                    hintText: 'password',
                    obsureText: true,
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: appColors.mainColor,
                      size: fsize * 0.0185,
                    ),
                  ),
                  SizedBox(
                    height: fsize * 0.025,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 5, backgroundColor: appColors.mainColor),
                      onPressed: () async {
                        if (phoneC.text.trim().isEmpty ||
                            passC.text.trim().isEmpty) {
                          CustomDialogs().showToast(
                              context: context,
                              backgroundColor:
                                  appColors.mainColor.withOpacity(0.6),
                              text: 'Please Enter Phone and Password');
                          return;
                        }
                        loginRegisterState.login(
                            context: context,
                            phone: phoneC.text,
                            password: passC.text);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: fsize * 0.02),
                        child: CustomText(
                          text: 'login',
                          color: appColors.white,
                          fontSize: fsize * 0.0165,
                        ),
                      ))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      text: 'v 1.0.5+17',
                      color: appColors.grey,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
//new change

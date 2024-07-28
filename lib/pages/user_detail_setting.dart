import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/refresh_widget.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';
import 'package:bauxite_admin_app/customs/user_widget.dart';
import 'package:bauxite_admin_app/pages/add_user.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/user_setting_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailSettingPage extends StatefulWidget {
  const UserDetailSettingPage(
      {super.key, required this.roleId, required this.title});
  final String roleId;
  final String title;

  @override
  State<UserDetailSettingPage> createState() => _UserDetailSettingPageState();
}

class _UserDetailSettingPageState extends State<UserDetailSettingPage> {
  final AppColors appColors = AppColors();
  TextEditingController searchT = TextEditingController();
  UserSettingState userSettingState = Get.put(UserSettingState());

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await Future.delayed(Duration.zero);
    userSettingState.getUserByRole(widget.roleId);
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
          text: widget.title,
          fontSize: fixSize * 0.022,
          color: appColors.white,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                var res = await Get.to(() =>
                    AddUserPage(roleId: widget.roleId, title: widget.title));
                if (res == true) {
                  getData();
                }
              },
              icon: Icon(
                Icons.add_circle,
                color: appColors.white,
              )),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: fixSize * 0.01),
        child: RefreshWidget(
          onRefresh: () {
            getData();
          },
          child: ListView(children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFieldWidget(
                    controller: searchT,
                    hintText: 'search',
                    onChange: (v) {
                      userSettingState.update();
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  color: appColors.mainColor,
                  width: fixSize * 0.05,
                  height: fixSize * 0.035,
                  child: Icon(
                    Icons.search,
                    color: appColors.white,
                    size: fixSize * 0.02,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GetBuilder<UserSettingState>(builder: (get) {
              if (!get.check) {
                return Center(
                  child: CircularProgressIndicator(color: appColors.mainColor),
                );
              }
              var value = get.userList
                  .where((element) =>
                      (element.name ?? '')
                          .toString()
                          .toLowerCase()
                          .contains(searchT.text.toString().toLowerCase()) ||
                      (element.code ?? '')
                          .toString()
                          .toLowerCase()
                          .contains(searchT.text.toString().toLowerCase()) ||
                      (element.phone ?? '')
                          .toString()
                          .toLowerCase()
                          .contains(searchT.text.toString().toLowerCase()))
                  .toList();
              return Column(
                children: [
                  Row(
                    children: [
                      CustomText(
                        text: ' ລວມທັງໝົດ ${value.length} ບັນຊີ',
                        fontSize: fixSize * 0.015,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: fixSize * 0.01,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            var res = await Get.to(() => AddUserPage(
                                  roleId: widget.roleId,
                                  title: widget.title,
                                  userModel: value[index],
                                ));
                            if (res == true) {
                              getData();
                            }
                          },
                          child: UserWidget(
                              fsize: fixSize,
                              appColors: appColors,
                              userModel: value[index],
                              index: index + 1),
                        );
                      }),
                ],
              );
            })
          ]),
        ),
      ),
    );
  }
}

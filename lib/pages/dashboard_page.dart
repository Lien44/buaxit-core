import 'package:bauxite_admin_app/customs/custom_app_bar.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/dashboard_info_widget.dart';
import 'package:bauxite_admin_app/customs/menu_widget.dart';
import 'package:bauxite_admin_app/functions/check_role.dart';
import 'package:bauxite_admin_app/functions/format_date.dart';
import 'package:bauxite_admin_app/functions/format_price.dart';
import 'package:bauxite_admin_app/pages/contracts_page.dart';
import 'package:bauxite_admin_app/pages/login.dart';
import 'package:bauxite_admin_app/pages/profile_edit.dart';
import 'package:bauxite_admin_app/pages/report_page.dart';
import 'package:bauxite_admin_app/pages/scans_page.dart';
import 'package:bauxite_admin_app/pages/setting.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/services/app_verification.dart';
import 'package:bauxite_admin_app/state/dashboard_state.dart';
import 'package:bauxite_admin_app/state/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});
  final DashboardState dashboardState = Get.put(DashboardState());
  final AppColors appColors = AppColors();
  late final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ProfileState profileState = Get.put(ProfileState());
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        orientation: orientation,
        height: size.height,
        leading: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: orientation == Orientation.portrait
              ? AnimatedContainer(
                  margin: EdgeInsets.all(fixSize * 0.008),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999999),
                    color: appColors.white,
                  ),
                  width: size.width,
                  height: (fixSize * 0.08),
                  duration: const Duration(milliseconds: 300),
                  child: Hero(
                    tag: 'logo',
                    child: Center(
                      child: CustomText(
                        text: "BX",
                        fontSize: fixSize * 0.0125,
                        color: appColors.mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : Icon(
                  Icons.menu,
                  color: appColors.white,
                ),
        ),
        title: "dashboard",
      ),
      body: RefreshIndicator(
        color: appColors.mainColor,
        onRefresh: () async {
          await dashboardState.setStart();
        },
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: fixSize * 0.005,
                ),
                GetBuilder<DashboardState>(builder: (dash) {
                  return DashboardInfo(
                    title: "ລວມແຮ່ຖອກລັດຖະບານ",
                    value:
                        "${FormatPrice(price: num.parse(dash.dashboardModel?.totalContractGovermentWeight ?? "0"))}",
                    unit: "ໂຕນ",
                    fontWeight: FontWeight.bold,
                  );
                }),
                GetBuilder<DashboardState>(builder: (dash) {
                  return DashboardInfo(
                    title: "ແຮ່ທາດສົ່ງອອກລວມ",
                    value:
                        "${FormatPrice(price: num.parse(dash.dashboardModel?.totalSendWeight ?? "0"))}",
                    unit: "ໂຕນ",
                    fontWeight: FontWeight.bold,
                  );
                }),
                GetBuilder<DashboardState>(builder: (dash) {
                  return DashboardInfo(
                    title: "ຍອດເຫລືອໂຄຕາ",
                    value:
                        "${FormatPrice(price: num.parse(dash.dashboardModel?.totalContractGovermentWeight ?? "0") - num.parse(dash.dashboardModel?.totalSendWeight ?? "0"))}",
                    unit: "ໂຕນ",
                    fontWeight: FontWeight.bold,
                  );
                }),
                SizedBox(
                  height: fixSize * 0.1,
                  width: size.width,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.chevron_left,
                          size: fixSize * 0.025,
                          color: appColors.mainColor.withOpacity(
                            0.5,
                          ),
                        ),
                      ),
                      // Center(
                      //   child: CustomText(
                      //     text: "ກຳລັງພັດທະນາ",
                      //     color: appColors.mainColor,
                      //   ),
                      // ),
                      GetBuilder<DashboardState>(builder: (getDash) {
                        return Expanded(
                            child: ListView.builder(
                          controller: dashboardState.controller,
                          scrollDirection: Axis.horizontal,
                          itemCount: getDash.dailyDashList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                left: fixSize * 0.008,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: fixSize * 0.008,
                                      horizontal: fixSize * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      color: appColors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: fixSize * 0.001,
                                          color: appColors.black.withOpacity(
                                            0.5,
                                          ),
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.local_shipping,
                                          color: appColors.mainColor,
                                          size: fixSize * 0.035,
                                        ),
                                        CustomText(
                                          text:
                                              "${FormatDate(dateTime: getDash.dailyDashList[index].date ?? '')}",
                                          color: appColors.black,
                                          fontSize: fixSize * 0.012,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: fixSize * 0.005,
                                  ),
                                  CustomText(
                                    text:
                                        "+${FormatPrice(price: num.parse(getDash.dailyDashList[index].totalWeight ?? ''))} ໂຕນ",
                                    color: appColors.mainColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: fixSize * 0.012,
                                  )
                                ],
                              ),
                            );
                          },
                        ));
                      }),

                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.chevron_right,
                          size: fixSize * 0.025,
                          color: appColors.mainColor.withOpacity(
                            0.5,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GetBuilder<DashboardState>(builder: (dash) {
                  return DashboardInfo(
                    title: "ສັນຍາທັງໝົດ",
                    value:
                        "${FormatPrice(price: num.parse(dash.dashboardModel?.totalContracts ?? "0"))}",
                    unit: "ລາຍການ",
                    fontWeight: FontWeight.bold,
                  );
                }),
                GetBuilder<DashboardState>(builder: (dash) {
                  return DashboardInfo(
                    title: "ໄລ່ລຽງທັງໝົດລົງສາງ",
                    value:
                        "${FormatPrice(price: num.parse(dash.dashboardModel?.totalActualWeight ?? "0"))}",
                    unit: "ໂຕນ",
                    fontWeight: FontWeight.bold,
                  );
                }),
                GetBuilder<DashboardState>(builder: (dash) {
                  return DashboardInfo(
                    title: "ໄລ່ລຽງສຳເລັດທັງໝົດເປັນເງິນ",
                    value:
                        "${FormatPrice(price: num.parse(dash.dashboardModel?.totalCalPrice ?? "0"))}",
                    unit: "\$",
                    fontWeight: FontWeight.bold,
                  );
                }),
                GetBuilder<DashboardState>(builder: (dash) {
                  return DashboardInfo(
                    title: "ຈຳນວນທຸລະກຳຂົນສົ່ງທັງໝົດ",
                    value:
                        "${FormatPrice(price: num.parse(dash.dashboardModel?.totalScan ?? "0"))}",
                    unit: "ລາຍການ",
                    fontWeight: FontWeight.bold,
                  );
                }),
                GetBuilder<ProfileState>(builder: (get) {
                  return GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          orientation == Orientation.portrait ? 2 : 4,
                      crossAxisSpacing: fixSize * 0.008,
                      mainAxisSpacing: fixSize * 0.008,
                    ),
                    padding: EdgeInsets.all(
                      fixSize * 0.008,
                    ),
                    children: [
                      if (profileState.userModel?.roleId.toString() == "1" ||
                          profileState.userModel?.roleId.toString() == "2")
                        MenuWidget(
                          onTap: () async {
                            Get.to(
                              () => ContractsPage(),
                              transition: Transition.rightToLeft,
                            );
                          },
                          icon: Icons.event_note,
                          name: "ຂໍ້ມູນສັນຍາ",
                        ),
                      if (profileState.userModel?.roleId.toString() == "1")
                        MenuWidget(
                          onTap: () {
                            Get.to(() => const SettingPage());
                          },
                          icon: Icons.settings_applications,
                          name: "ຕັ້ງຕ່າລະບົບ",
                        ),
                      if (profileState.userModel?.roleId.toString() == "1" ||
                          profileState.userModel?.roleId.toString() == "3")
                        MenuWidget(
                          onTap: () async {
                            Get.to(
                              () => ScanPage(),
                              transition: Transition.rightToLeft,
                            );
                          },
                          svg: "assets/images/scan_icon.svg",
                          name: "ສະແກນເຂົ້າ-ອອກ",
                        ),
                      if (profileState.userModel?.roleId.toString() == "1" ||
                          profileState.userModel?.roleId.toString() == "2")
                        MenuWidget(
                          onTap: () {
                            Get.to(
                              () => ReportPage(),
                              transition: Transition.rightToLeft,
                            );
                          },
                          icon: Icons.library_books,
                          name: "ລາຍງານ",
                        ),
                    ],
                  );
                }),
              ],
            ),
          ],
        ),
      ),
      drawer: DrawerWiget(),
    );
  }
}

class DrawerWiget extends StatelessWidget {
  DrawerWiget({
    Key? key,
  }) : super(key: key);
  static AppColors appColors = AppColors();
  final ProfileState profileState = Get.put(ProfileState());
  final AppVerification appVerification = Get.put(AppVerification());
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    double fixSize = size.width + size.height;
    return Drawer(
      child: Column(children: [
        DrawerHeader(
            padding: EdgeInsets.zero,
            child: Container(
              color: appColors.mainColor,
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                AnimatedContainer(
                  margin: EdgeInsets.all(fixSize * 0.008),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999999),
                    color: appColors.white,
                  ),
                  width: (fixSize * 0.075),
                  height: (fixSize * 0.075),
                  duration: const Duration(milliseconds: 300),
                  child: Center(
                    child: CustomText(
                      text: "BX",
                      fontSize: fixSize * 0.0125,
                      color: appColors.mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GetBuilder<ProfileState>(builder: (get) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        children: [
                          CustomText(
                            text: 'ID',
                            color: appColors.white,
                            fontSize: fixSize * 0.0135,
                          ),
                          CustomText(
                            text: ': ${get.userModel?.code ?? ''}',
                            color: appColors.white,
                            fontSize: fixSize * 0.0135,
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          CustomText(
                            text: 'username',
                            color: appColors.white,
                            fontSize: fixSize * 0.0135,
                          ),
                          CustomText(
                            text: ': ${get.userModel?.name ?? ''}',
                            color: appColors.white,
                            fontSize: fixSize * 0.0135,
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          CustomText(
                            text: 'phone',
                            color: appColors.white,
                            fontSize: fixSize * 0.0135,
                          ),
                          CustomText(
                            text: ': ${get.userModel?.phone ?? ''}',
                            color: appColors.white,
                            fontSize: fixSize * 0.0135,
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          CustomText(
                            text: 'role',
                            color: appColors.white,
                            fontSize: fixSize * 0.0135,
                          ),
                          CustomText(
                            text:
                                ': ${CheckRole(roleId: get.userModel?.roleId != null ? get.userModel!.roleId.toString() : '')}',
                            color: appColors.white,
                            fontSize: fixSize * 0.0135,
                          ),
                        ],
                      ),
                      // Add an edit icon and bottom text for role here
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                  ProfileEdit(
                                    userModel: profileState.userModel,
                                  ),
                                  transition: Transition.cupertino);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    Colors.grey, // Set background color to grey
                                borderRadius: BorderRadius.circular(
                                    4.0), // Set border radius
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.0,
                                  horizontal: 8.0), // Adjust padding as needed
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: appColors.white,
                                    size: fixSize * 0.018,
                                  ),
                                  SizedBox(width: fixSize * 0.005),
                                  CustomText(
                                    text: 'ແກ້ໄຂໂປຣຟາຍ',
                                    color: appColors.white,
                                    fontSize: fixSize * 0.013,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                })
              ]),
            )),
        ListTile(
          onTap: () {
            appVerification.removeToken();
            Get.offAll(() => const LoginPage());
          },
          leading: Icon(
            Icons.exit_to_app,
            color: appColors.mainColor,
            size: fixSize * 0.0225,
          ),
          title: CustomText(
            text: 'ອອກຈາກລະບົບ',
            color: appColors.black,
            fontSize: fixSize * 0.015,
          ),
        ),
        const Divider()
      ]),
    );
  }
}

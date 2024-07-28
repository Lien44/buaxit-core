import 'package:bauxite_admin_app/customs/custom_dialog.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/refresh_widget.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';
import 'package:bauxite_admin_app/pages/add_land_page.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/services/repository.dart';
import 'package:bauxite_admin_app/state/land_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../customs/land_widget.dart';

class LandDetailPage extends StatefulWidget {
  const LandDetailPage({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  State<LandDetailPage> createState() => _LandDetailPageState();
}

class _LandDetailPageState extends State<LandDetailPage> {
  final AppColors appColors = AppColors();
  TextEditingController searchT = TextEditingController();
  LandState landState = Get.put(LandState(useInit: false));
  Repository repository = Repository();
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await Future.delayed(Duration.zero);
    if (widget.value == 'pro') {
      landState.getAllOnlyProvice();
    } else if (widget.value == 'dis') {
      landState.getAllOnlyDistrict();
    } else if (widget.value == 'vil') {
      landState.getAllOnlyVillage();
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
          text: widget.title,
          fontSize: fixSize * 0.022,
          color: appColors.white,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                var res = await Get.to(() => AddLandPage(value: widget.value));
                if (res == 'added') {
                  if (mounted) {
                    CustomDialogs()
                        .showToast(context: context, text: 'add_success'.tr);
                  }
                  getData();
                }
                if (res == 'edited') {
                  if (mounted) {
                    CustomDialogs()
                        .showToast(context: context, text: 'edit_success'.tr);
                  }
                  getData();
                }
                if (res == 'deleted') {
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
          child: Column(children: [
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
                      landState.update();
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
            // widget.value == 'vil'
            //     ? FutureBuilder(
            //         future: getVillageWithCompute(),
            //         builder: (context, snapshot) {
            //           if (!snapshot.hasData) {
            //             return Center(
            //               child: CircularProgressIndicator(
            //                   color: appColors.mainColor),
            //             );
            //           }
            //           var value = [];
            //           if (widget.value == 'vil') {
            //             value = snapshot.data!
            //                 .where((element) => (element.name ?? '')
            //                     .toString()
            //                     .toLowerCase()
            //                     .contains(
            //                         searchT.text.toString().toLowerCase()))
            //                 .toList();
            //           }
            //           return ListView.builder(
            //               shrinkWrap: true,
            //               itemCount: value.length,
            //               physics: const NeverScrollableScrollPhysics(),
            //               itemBuilder: (context, index) {
            //                 return InkWell(
            //                   onTap: () async {
            //                     var res = await Get.to(() => AddLandPage(
            //                           value: widget.value,
            //                           provinceModel: widget.value == 'pro'
            //                               ? value[index]
            //                               : null,
            //                           districtsModel: widget.value == 'dis'
            //                               ? value[index]
            //                               : null,
            //                           villagesModel: widget.value == 'vil'
            //                               ? value[index]
            //                               : null,
            //                         ));
            //                     if (res == 'added') {
            //                       if (mounted) {
            //                         CustomDialogs().showToast(
            //                             context: context,
            //                             text: 'add_success'.tr);
            //                       }
            //                       getData();
            //                     }
            //                     if (res == 'edited') {
            //                       if (mounted) {
            //                         CustomDialogs().showToast(
            //                             context: context,
            //                             text: 'edit_success'.tr);
            //                       }
            //                       getData();
            //                     }
            //                     if (res == 'deleted') {
            //                       getData();
            //                     }
            //                   },
            //                   child: LandWidget(
            //                       fsize: fixSize,
            //                       appColors: appColors,
            //                       title: value[index].name,
            //                       index: index + 1),
            //                 );
            //               });
            //         })
            //     : SizedBox()

            Expanded(
              child: GetBuilder<LandState>(builder: (get) {
                if (!get.checkGet) {
                  return Center(
                    child:
                        CircularProgressIndicator(color: appColors.mainColor),
                  );
                }
                var value = [];
                if (widget.value == 'pro') {
                  value = get.allProvincesOnly
                      .where((element) => (element.name ?? '')
                          .toString()
                          .toLowerCase()
                          .contains(searchT.text.toString().toLowerCase()))
                      .toList();
                } else if (widget.value == 'dis') {
                  value = get.allDistrictsOnly
                      .where((element) => (element.name ?? '')
                          .toString()
                          .toLowerCase()
                          .contains(searchT.text.toString().toLowerCase()))
                      .toList();
                } else if (widget.value == 'vil') {
                  value = get.allVillagesOnly
                      .where((element) => (element.name ?? '')
                          .toString()
                          .toLowerCase()
                          .contains(searchT.text.toString().toLowerCase()))
                      .toList();
                }
                return Column(
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: ' ລວມທັງໝົດ ${value.length} ລາຍການ',
                          fontSize: fixSize * 0.015,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: fixSize * 0.01,
                    ),
                    Expanded(
                      child: ListView.builder(
                          //  shrinkWrap: true,
                          itemCount: value.length,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                var res = await Get.to(() => AddLandPage(
                                      value: widget.value,
                                      provinceModel: widget.value == 'pro'
                                          ? value[index]
                                          : null,
                                      districtsModel: widget.value == 'dis'
                                          ? value[index]
                                          : null,
                                      villagesModel: widget.value == 'vil'
                                          ? value[index]
                                          : null,
                                    ));
                                if (res == 'added') {
                                  if (mounted) {
                                    CustomDialogs().showToast(
                                        context: context,
                                        text: 'add_success'.tr);
                                  }
                                  getData();
                                }
                                if (res == 'edited') {
                                  if (mounted) {
                                    CustomDialogs().showToast(
                                        context: context,
                                        text: 'edit_success'.tr);
                                  }
                                  getData();
                                }
                                if (res == 'deleted') {
                                  getData();
                                }
                              },
                              child: LandWidget(
                                  fsize: fixSize,
                                  appColors: appColors,
                                  title: value[index].name,
                                  index: index + 1),
                            );
                          }),
                    ),
                  ],
                );
              }),
            )
          ]),
        ),
      ),
    );
  }
}

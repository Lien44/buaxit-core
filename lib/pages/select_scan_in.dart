import 'package:bauxite_admin_app/customs/cars_widget.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';
import 'package:bauxite_admin_app/pages/add_cars.dart';
import 'package:bauxite_admin_app/pages/camera_scan_page.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/camera_scan_page_state.dart';
import 'package:bauxite_admin_app/state/car_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectScanIn extends StatefulWidget {
  const SelectScanIn({super.key, required this.title});

  final String title;

  @override
  State<SelectScanIn> createState() => _SelectScanInState();
}

class _SelectScanInState extends State<SelectScanIn> {
  final AppColors appColors = AppColors();
  TextEditingController searchT = TextEditingController();
  CarState carState = Get.put(CarState());
  CameraScanPageState cameraScanPageState = Get.put(CameraScanPageState());
  @override
  void initState() {
    carState.clearsearchCar();
    super.initState();
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
                var res = await Get.to(() => const AddCarsPage());
                if (res == true) {
                  // getData();
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
                  onChange: (v) async {
                    if (v.isNotEmpty) {
                      await cameraScanPageState.searchCar(context, v);
                    } else {
                      carState.clearsearchCar();
                    }
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
          GetBuilder<CarState>(builder: (get) {
            if (!get.checkselectCar) {
              return const Center(
                child: CustomText(text: 'ຍັງບໍ່ມີຂໍ້ມູນ'),
              );
            }
            return Column(
              children: [
                Row(
                  children: [
                    CustomText(
                      text:
                          ' ລວມທັງໝົດ ${carState.searchcarsList.length} ລາຍການ',
                      fontSize: fixSize * 0.015,
                    ),
                  ],
                ),
                SizedBox(
                  height: fixSize * 0.01,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: carState.searchcarsList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          var res = await Get.to(() => AddCarsPage(
                                carsModel: carState.searchcarsList[index],
                              ));
                          if (res == true) {
                            // getData();
                          }
                        },
                        child: CarsWidget(
                            fsize: fixSize,
                            appColors: appColors,
                            carsModel: carState.searchcarsList[index],
                            index: index + 1),
                      );
                    }),
              ],
            );
          })
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColors.mainColor,
        onPressed: () {
          Get.to(
            () => CameraScanPage(
              type: CameraType.scanIn,
            ),
            transition: Transition.rightToLeft,
          );
        },
        child: Icon(
          Icons.qr_code_scanner,
          color: appColors.white,
        ),
      ),
    );
  }
}

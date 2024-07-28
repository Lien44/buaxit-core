import 'package:bauxite_admin_app/customs/cars_widget.dart';
import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/refresh_widget.dart';
import 'package:bauxite_admin_app/customs/text_field_widget.dart';
import 'package:bauxite_admin_app/pages/add_cars.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/car_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarsPage extends StatefulWidget {
  const CarsPage({super.key, required this.title});

  final String title;

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  final AppColors appColors = AppColors();
  TextEditingController searchT = TextEditingController();
  CarState carState = Get.put(CarState());

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await Future.delayed(Duration.zero);
    carState.getCars();
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
                      carState.update();
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
              if (!get.check) {
                return Center(
                  child: CircularProgressIndicator(color: appColors.mainColor),
                );
              }
              var value = get.carsList
                  .where((element) =>
                      (element.name ?? '')
                          .toString()
                          .toLowerCase()
                          .contains(searchT.text.toString().toLowerCase()) ||
                      (element.code ?? '')
                          .toString()
                          .toLowerCase()
                          .contains(searchT.text.toString().toLowerCase()) ||
                      (element.carNumber ?? '')
                          .toString()
                          .toLowerCase()
                          .contains(searchT.text.toString().toLowerCase()) ||
                      (element.tisNumber ?? '')
                          .toString()
                          .toLowerCase()
                          .contains(searchT.text.toString().toLowerCase()) ||
                      (element.companyId?.name ?? '')
                          .toString()
                          .toLowerCase()
                          .contains(searchT.text.toString().toLowerCase()))
                  .toList();
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
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            var res = await Get.to(() => AddCarsPage(
                                  carsModel: value[index],
                                ));
                            if (res == true) {
                              getData();
                            }
                          },
                          child: CarsWidget(
                              fsize: fixSize,
                              appColors: appColors,
                              carsModel: value[index],
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

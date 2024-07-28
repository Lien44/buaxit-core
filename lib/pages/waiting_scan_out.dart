import 'dart:async';

import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/customs/print_bill_widget.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/state/camera_scan_page_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaitingScanOutPage extends StatefulWidget {
  const WaitingScanOutPage({super.key, this.code});
  final String? code;
  @override
  State<WaitingScanOutPage> createState() => _WaitingScanOutPageState();
}

class _WaitingScanOutPageState extends State<WaitingScanOutPage> {
  final AppColors appColors = AppColors();

  CameraScanPageState cameraScanPageState = Get.put(CameraScanPageState());

  Timer? timer;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await Future.delayed(Duration.zero);
    await cameraScanPageState.checkScanOutForWaiting(code: widget.code);
    timer = Timer.periodic(const Duration(seconds: 5), (t) {
      if (cameraScanPageState.checkScanOut == null) {
        cameraScanPageState.checkScanOutForWaiting(code: widget.code);
      } else {
        timer?.cancel();
      }
    });
    showPrint();
  }

  @override
  void dispose() {
    cameraScanPageState.checkScanOut = null;
    timer?.cancel();
    super.dispose();
  }

  showPrint() {
    Size size = MediaQuery.of(context).size;
    Get.dialog(AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
            height: size.height * 0.7,
            width: size.width,
            child: PrintBillWidget(
              scanOutModel: cameraScanPageState.checkScanOut!,
            ))));
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
          text: 'ລາຍລະອຽດ',
          fontSize: fixSize * 0.022,
          color: appColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: GetBuilder<CameraScanPageState>(builder: (get) {
        if (get.checkScanOut != null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: fixSize * 0.025,
                  ),
                  Icon(
                    Icons.print,
                    color: appColors.mainColor,
                    size: fixSize * 0.065,
                  ),
                  CustomText(
                    text: 'ປຣິ່ນໃບບີນ',
                    color: appColors.black,
                    fontSize: fixSize * 0.0165,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColors.mainColor,
                      ),
                      onPressed: () async {
                        // PrintBill2()
                        //     .generatePdf('ໃບບິນສະແກນອອກ', get.checkScanOut!);

                        Get.dialog(AlertDialog(
                            insetPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.zero,
                            content: SizedBox(
                                height: size.height * 0.7,
                                width: size.width,
                                child: PrintBillWidget(
                                  scanOutModel: get.checkScanOut!,
                                ))));
                      },
                      child: Center(
                        child: CustomText(
                          color: appColors.white,
                          text: "ປຣິ່ນ",
                        ),
                      ))
                ],
              ),
            ],
          );
        }
        return Column(
          children: [
            Expanded(
              child: Column(children: [
                SizedBox(
                  height: fixSize * 0.05,
                ),
                const WaitingWidget(),
                SizedBox(
                  height: fixSize * 0.025,
                ),
                CustomText(
                  text: 'ກຳລັງໂຫລດຂໍ້ມູນ',
                  color: appColors.black,
                  fontSize: fixSize * 0.0165,
                )
              ]),
            ),
          ],
        );
      }),
    );
  }
}

class WaitingWidget extends StatefulWidget {
  const WaitingWidget({super.key});

  @override
  State<WaitingWidget> createState() => _WaitingWidgetState();
}

class _WaitingWidgetState extends State<WaitingWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  AppColors appColors = AppColors();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _animation,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: appColors.mainColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ScaleTransition(
            scale: _animation,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: appColors.mainColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ScaleTransition(
            scale: _animation,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: appColors.mainColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ScaleTransition(
            scale: _animation,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: appColors.mainColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ScaleTransition(
            scale: _animation,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: appColors.mainColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

import 'package:bauxite_admin_app/customs/custom_text.dart';
import 'package:bauxite_admin_app/pages/splash_page.dart';
import 'package:bauxite_admin_app/services/app_color.dart';
import 'package:bauxite_admin_app/services/translator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(
    LocaleState(),
  );

  runApp(
    BauxiteApp(),
  );
}

class BauxiteApp extends StatelessWidget {
  BauxiteApp({super.key});
  final AppColors appColors = AppColors();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: appColors.mainColor,
      title: "Bauxite Admin",
      debugShowCheckedModeBanner: false,
      locale: const Locale("la", "LA"),
      translations: AppTranslator(),
      home: const SplashPage(),
    );
  }
}

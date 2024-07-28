import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppVerification extends GetxController {
  GetStorage storage = GetStorage();
  String role = "";
  String token = "";
  Map<String, dynamic> mapOTP = {};
  setInitToken() {
    token =
        storage.read('token') ?? "";
    role = storage.read('role') ?? "";
    update();
  }

  setNewToken({required String text, required String role}) async {
    await storage.write('token', text);
    await storage.write('role', role);
    token = storage.read('token') ?? "";
    role = storage.read('role') ?? "";
    update();
  }

  removeToken() async {
    await storage.write('token', "");
    await storage.write('role', "");
    token = "";
    role = "";
    update();
  }

}

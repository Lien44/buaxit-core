import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class HistoryExcelState extends GetxController {
  List<File> historyExcelAll = [];
  bool check = false;

  getDataHistory() async {
    check = false;
    historyExcelAll = [];
    try {
      // historyExcelAll = directTory ?? [];
      String folderPath = '';
      if (Platform.isAndroid) {
        final directTory = await getExternalStorageDirectory();
        folderPath = directTory!.path;
        // folderPath =
        //     '/storage/emulated/0/Android/data/com.bauxite.admin/files/'; // path to the folder

      } else {
        final directTory = await getApplicationDocumentsDirectory();
        folderPath = '${directTory.path}/BxReport';
      }
      Directory folder = Directory(
          folderPath); // create a Directory object from the folder path

      if (await folder.exists()) {
        // list all the files in the folder
        List<FileSystemEntity> files = folder.listSync();
        for (FileSystemEntity file in files) {
          if (file is File) {
            historyExcelAll.insert(0, file);
          }
        }
      } else {
        print('Folder does not exist');
      }
    } catch (e) {
      print(e.toString());
    }
    check = true;
    update();
  }
}

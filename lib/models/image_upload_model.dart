import 'package:image_picker/image_picker.dart';

class ImageUploadModel {
  final String fieldName;
  final XFile xFile;

  ImageUploadModel({required this.fieldName, required this.xFile});
}

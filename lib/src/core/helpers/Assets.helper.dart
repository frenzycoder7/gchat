import 'package:image_picker/image_picker.dart';

class AssetsHelper {
  final ImagePicker _picker;

  static AssetsHelper instance = AssetsHelper._();
  AssetsHelper._() : _picker = ImagePicker();

  Future<String?> getImage() async {
    XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      return file.path;
    } else {
      return null;
    }
  }
}

import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Utils {
  static addPhoto(ImageSource source) async {
    final picker = ImagePicker();
    File pickedFile;
    var image = await picker.pickImage(source: source);

    if (image != null) {
      pickedFile = File(image.path);
      return pickedFile;
    }
  }
}

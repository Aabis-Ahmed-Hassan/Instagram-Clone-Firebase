import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  static pickImage(ImageSource source) async {
    final picker = ImagePicker();
    File pickedFile;
    var image = await picker.pickImage(source: source);

    if (image != null) {
      pickedFile = File(image.path);
      return pickedFile;
    }
  }

  static showToastMessage(String userMessage) {}

  static changeFocusNode(
      BuildContext context, FocusNode currentNode, FocusNode nextNode) {
    currentNode.unfocus();

    FocusScope.of(context).requestFocus(nextNode);
  }
}

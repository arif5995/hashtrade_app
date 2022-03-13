import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakePicture extends StatefulWidget {
  const TakePicture({Key? key}) : super(key: key);

  @override
  _TakePictureState createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  File? _image;
  final image = ImagePicker();

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker.platform.pickImage(source: source);
    if (file?.path != null) {
      setState(() {
        _image = File(file!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

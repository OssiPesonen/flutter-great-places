import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _image;

  /// Open camera and store picture in _image
  Future _takePicture() async {
    final picker = ImagePicker();

    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 720,
    );

    if (pickedFile == null) {
      return;
    }

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(_image.path);

    final savedImage = await _image.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 150,
          child: _image != null
              ? Image.file(
                  _image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No image',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            onPressed: () {
              _takePicture();
            },
          ),
        )
      ],
    );
  }
}

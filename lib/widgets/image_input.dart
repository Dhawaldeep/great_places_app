import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  final Function selectImage;

  ImageInput(this.selectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imagePicker = ImagePicker();
    final imageFile = await imagePicker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if(imageFile == null) return null;
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final Directory dir = await sysPath.getApplicationDocumentsDirectory();
    final String fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${dir.path}/$fileName');
    await widget.selectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Pick Image'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        )
      ],
    );
  }
}

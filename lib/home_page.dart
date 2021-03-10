import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/material.dart';
import 'output.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  static final String route = '/home';
}

class _HomePageState extends State<HomePage> {
  File _image;

  getImageFile(ImageSource source) async {
    //Clicking or Picking from Gallery

    var image = await ImagePicker.pickImage(source: source);

    //Cropping the image

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        cropStyle: CropStyle.rectangle,
        maxWidth: 512,
        maxHeight: 512,
        androidUiSettings: AndroidUiSettings(
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false));

    //Compress the image

    var result = await FlutterImageCompress.compressAndGetFile(
      croppedFile.path,
      croppedFile.path,
      quality: 50,
    );

    setState(() {
      _image = result;
      print(_image.lengthSync());
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_image?.lengthSync());
    return Scaffold(
      appBar: AppBar(
        title: Text("URDU LENS"),
      ),
      body: Column(children: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Output.route);
            },
            child: Text("Convert")),
        Center(
            child: _image == null
                ? Text("Your Urdu Image ")
                : Image.file(
                    _image,
                    height: 400,
                    width: 600,
                  )),
      ]),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            label: Text("Capture"),
            onPressed: () => getImageFile(ImageSource.camera),
            heroTag: UniqueKey(),
            icon: Icon(Icons.camera),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton.extended(
            label: Text("Upload"),
            onPressed: () => getImageFile(ImageSource.gallery),
            heroTag: UniqueKey(),
            icon: Icon(Icons.photo_library),
          ),
        ],
      ),
    );
  }
}

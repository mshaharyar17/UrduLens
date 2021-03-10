import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
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
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    /*
    var result = await FlutterImageCompress.compressAndGetFile(
      croppedFile.path,
      croppedFile.path.split(".")[0] + "_compressed.jpg",
      quality: 50,
    );
    print(croppedFile.path);
    print(result);
    */

    setState(() {
      _image = File(croppedFile.path);
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
            onPressed: () async {
              Dio dio = new Dio();
              Response<Map> res = await dio.post("http://10.0.2.2:5000/",
                  data: FormData.fromMap({
                    "photo": await MultipartFile.fromFile(_image.path,
                        filename: "photo")
                  }));
              print(res.data["text"]);
              Navigator.of(context)
                  .pushNamed(Output.route, arguments: res.data["text"]);
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

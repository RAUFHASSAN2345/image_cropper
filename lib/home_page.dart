import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  String imagepath = '';
  ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Image_cropper-practice'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: () async {
                XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (PickedFile != null) {
                  CroppedFile? croppedFile = await ImageCropper().cropImage(
                    sourcePath: PickedFile(image!.path).path,
                    aspectRatioPresets: [
                      CropAspectRatioPreset.square,
                      CropAspectRatioPreset.ratio3x2,
                      CropAspectRatioPreset.original,
                      CropAspectRatioPreset.ratio4x3,
                      CropAspectRatioPreset.ratio16x9
                    ],
                    uiSettings: [
                      AndroidUiSettings(
                          toolbarTitle: 'Cropper',
                          toolbarColor: Colors.deepOrange,
                          toolbarWidgetColor: Colors.white,
                          initAspectRatio: CropAspectRatioPreset.original,
                          lockAspectRatio: false),
                      IOSUiSettings(
                        title: 'Cropper',
                      ),
                    ],
                  );
                  setState(() {
                    imagepath = croppedFile!.path;
                  });
                }
              },
              child: Text(
                'select_image',
                style: TextStyle(fontSize: 20),
              )),
          imagepath != ''
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Image.file(File(imagepath)),
                )
              : Container()
        ],
      )),
    );
  }
}

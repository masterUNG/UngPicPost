import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungpicpost/utility/normal_dialog.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  // Field
  File file;
  String heading, detail, urlPic;

  // Method

  Widget groupImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        cameraButton(),
        showImage(),
        galleryButton(),
      ],
    );
  }

  IconButton galleryButton() => IconButton(
        icon: Icon(Icons.add_photo_alternate),
        onPressed: () {
          chooseImage(ImageSource.gallery);
        },
      );

  Widget showImage() => Container(
        width: 200.0,
        height: 200.0,
        child: file == null
            ? Image.asset('images/pic.png')
            : Image.file(
                file,
                fit: BoxFit.cover,
              ),
      );

  IconButton cameraButton() {
    return IconButton(
      icon: Icon(Icons.add_a_photo),
      onPressed: () {
        chooseImage(ImageSource.camera);
      },
    );
  }

  Future<void> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker.pickImage(
        source: source,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );

      setState(() {
        file = result;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Stack(
        children: <Widget>[mainForm(), addPostButton()],
      ),
    );
  }

  Widget addPostButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton.icon(
              onPressed: () {
                if (file == null) {
                  normalDialog(context, 'Non Choose Picture',
                      'Please Click Camera or Gallery');
                } else if (heading == null ||
                    heading.isEmpty ||
                    detail == null ||
                    detail.isEmpty) {
                  normalDialog(
                      context, 'Have Space', 'Please Fill Every Blank');
                } else {
                  uploadFileToServer();
                }
              },
              icon: Icon(Icons.cloud_upload),
              label: Text('Add Post To Server')),
        ),
      ],
    );
  }

  Future<void> uploadFileToServer() async {
    Random random = Random();
    int i = random.nextInt(100000);
    String nameFile = 'post$i.jpg';

    String url = 'https://www.androidthai.in.th/mai/saveFileUng.php';

    try {
      FormData formData =
          FormData.from({'file': UploadFileInfo(file, nameFile)});
      Response response = await Dio().post(url, data: formData);
      print('statusCode = ${response.statusCode}');

      urlPic = 'http://androidthai.in.th/mai/PictureUng/$nameFile';

      insertDataToMySQL();

    } catch (e) {}
  }

  Future<void> insertDataToMySQL()async{
    String url = 'https://www.androidthai.in.th/mai/addPostUng.php?isAdd=true&Head=$heading&Detail=$detail&UrlPic=$urlPic';

    Response response = await Dio().get(url);
    if (response.toString() == 'true') {
      Navigator.pop(context);
    } else {
      normalDialog(context, 'Error', 'Please Try Again');
    }

  }

  SingleChildScrollView mainForm() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          groupImage(),
          headForm(),
          detailForm(),
        ],
      ),
    );
  }

  Widget headForm() => Container(
        margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
        width: 250.0,
        child: TextField(
          onChanged: (value) => heading = value.trim(),
          decoration: InputDecoration(
            hintText: 'Heading :',
            border: OutlineInputBorder(),
          ),
        ),
      );

  Widget detailForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => detail = value.trim(),
          decoration: InputDecoration(
            hintText: 'Detail :',
            border: OutlineInputBorder(),
          ),
        ),
      );
}

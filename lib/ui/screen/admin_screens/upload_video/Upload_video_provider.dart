import 'dart:io';
import 'package:flutter/material.dart';
import 'package:free_mb/core/services/database_services.dart';
import 'package:free_mb/core/services/database_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/models/upload_video.dart';


class UploadVideoProvider extends ChangeNotifier {
  TextEditingController videoTitleController = TextEditingController();
  final databaseStorageServices = DatabaseStorageServices();
  final dataBaseServices = DatabaseServices();
  UploadVideo uploadVideo = UploadVideo();
  ImagePicker imagePicker = ImagePicker();
  File? image;
  func(){
    dataBaseServices.getPostImage();
  }
  getImage() async {
    final img = await imagePicker.pickVideo(
      source: ImageSource.gallery,
    );

    if (img != null) {
      image = File(img.path);
      print("image>>> ${image!.path}");
      notifyListeners();
    }
  }

  ///
  ///  Upload Image Function ===========>>>
  ///
  uploadFile() async {
    if (image != null) {
      uploadVideo.videoUrl =
          await databaseStorageServices.uploadUserImages(image!);
    }
    var videoTitle = DateTime.now().microsecondsSinceEpoch.toString();
    final result = await dataBaseServices.setPostImage(
        uploadVideo, videoTitle, selected, videoTitleController.text);
  }

  var name;

  dropdown(String value) {
    selected = value;
    notifyListeners();
  }

  String selected = "Part 1";
  List<String> mylist = ['Part 1', 'Part 2', 'Part 3'];
}

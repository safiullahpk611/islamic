import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:free_mb/core/services/database_services.dart';
import '../../../../core/enums/view_state.dart';
import '../../../../core/models/upload_video.dart';

class PlayVideoProvider extends ChangeNotifier{
  List<UploadVideo> postImages = [];
  final databaseServices=DatabaseServices();

  Stream<QuerySnapshot>? postImagesStream;

  PlayVideoProvider() {
    getImagesData();
  }
  getImagesData() async {


    postImagesStream = databaseServices.getPostImage();
    postImagesStream!.listen((event) {
      postImages = [];

      if (event.docs.length > 0) {
        event.docs.forEach((element) async {
          postImages.add(UploadVideo.fromJson(element));
          notifyListeners();
        });
        postImages.reversed;
      }
    });

  }
}
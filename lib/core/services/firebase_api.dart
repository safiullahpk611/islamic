import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi{
  static UploadTask? uploadFiles(String destinition, XFile file){
    try{
      final ref= FirebaseStorage.instance.ref(destinition);
      return ref.putFile(file as File);

    }on FirebaseException catch(e){

    }
  }
}
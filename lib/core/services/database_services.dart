
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';

import '../models/upload_video.dart';
import 'auth_Services.dart';

class DatabaseServices {
  final firebaseFireStore = FirebaseFirestore.instance;

  // final currentAppUser = locator<AuthServices>();

  ///
  /// Add user
  ///
  registerUser(AppUser appUser) {
    try {
      firebaseFireStore
          .collection("AppUser")
          .doc(appUser.appUserId)
          .set(appUser.toJson());
    } catch (e) {
      print('Exception $e');
    }
  }

  ///
  /// Get user
  ///
  Future<AppUser> getUser(id) async {
    print('GetUser id: $id');
    try {
      final snapshot =
          await firebaseFireStore.collection('AppUser').doc(id).get();
      // print('Current app User Data: ${snapshot.data()}');
      return AppUser.fromJson(snapshot.data(), snapshot.id);
    } catch (e) {
      print('Exception @DatabaseService/getUser $e');
      return AppUser();
    }
  }
  setPostImage(UploadVideo uploadVideo, String UserId, String parts, String subTitle) async {
    try {

      await firebaseFireStore
          .collection('Tarjuma')
          .doc('All video')
      .collection(parts).
    doc(subTitle)
          .set(uploadVideo.toJson());
      return true;
    } catch (e) {
      print("Exception@MakingPostImage=>$e");
    }
  }

  ///
  /// get all app users
  ///
  Future<List<AppUser>> getAppUsers() async {
    final List<AppUser> appUserList = [];
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('AppUser')
          .where('isAdmin', isNotEqualTo: true)
          .get();
      if (snapshot.docs.length > 0) {
        snapshot.docs.forEach((element) {
          appUserList.add(AppUser.fromJson(element, element.id));
          print("getUser => ${element['userName']}");
        });
      } else {
        print("No data found");
      }
    } catch (e) {
      print('Exception @DatabaseService/GetAllUsers $e');
    }
    return appUserList;
  }

  Stream<QuerySnapshot>? getPostImage() {
    try {
      Stream<QuerySnapshot> snapshots = FirebaseFirestore.instance
          .collection('Tarjuma')
          .doc('All video')
          .collection('Part 1')
          .snapshots();
     
    
      return snapshots;
    } catch (e) {
      print('Exception @DatabaseService/GetPostImage$e');
    }
  }




}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUser extends ChangeNotifier {
  String? appUserId;
  String? userName;
  String? fcmToken;
  String? userDOB;
  String? profileImage;
  String? userEmail;
  double? time;
  String? phoneNumber;
  bool? blockUser;
  String? password;
  String? confirmPassword;
  bool? isFirstLogin;
  bool? isAdmin;
  String? imageUrl;
  AppUser({
    this.appUserId,
    this.profileImage,
    this.userEmail,
    this.imageUrl,
    this.userName,
    this.userDOB,
    this.phoneNumber,
    this.password,
    this.blockUser,
    this.confirmPassword,
    this.isFirstLogin,
  });

  AppUser.fromJson(json, id) {
    this.appUserId = id;
    this.confirmPassword = json['confirmPassword'];
    this.profileImage = json['profileImage'];
    this.userName = json['userName'] ?? '';
    this.userDOB = json['userDOB'];
    this.userEmail = json['userEmail'];
    this.password = json['password'];
    this.phoneNumber = json['phoneNumber'] ?? '';
    this.blockUser = json['blockUser'];
    this.isFirstLogin = json['isFirstLogin'];
  }

  toJson() {
    return {
      'appUserId': this.appUserId,
      'profileImage': profileImage,
      'userName': this.userName,
      'userDOB': this.userDOB,
      'userEmail': this.userEmail,
      'phoneNumber': this.phoneNumber,
      'password': this.password,
      'isFirstLogin': this.isFirstLogin,
      'confirmPassword': this.confirmPassword,
    };
  }
}

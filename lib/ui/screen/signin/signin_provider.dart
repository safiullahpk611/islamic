import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:free_mb/core/custom_page_route.dart';

import '../../../../core/enums/view_state.dart';

import '../../../../core/models/app_user.dart';
import '../../../../core/models/base_view_model.dart';
import '../../../../core/services/custom_auth_result.dart';
import '../../../../core/services/database_services.dart';
import '../../../core/custom_snacke_bar.dart';
import '../../../core/services/auth_Services.dart';
import '../admin_screens/upload_video/home_admin_screen.dart';


class SignInProvider extends BaseViewModal {
  final firebaseFireStore = FirebaseFirestore.instance;

  AppUser appUser = AppUser();
  final databaseServices = DatabaseServices();
  CustomAuthResult customAuthResult = CustomAuthResult();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isRememberMe = false;
  bool isVisiblePassword = true;


  ///
  /// Visible Password =================================>>>
  ///
  visiblePassword() {
    print("Password state : $isVisiblePassword");
    isVisiblePassword = !isVisiblePassword;
    notifyListeners();
    print("Password final state : $isVisiblePassword");
  }



  rememberMe(value) {
    isRememberMe = value;
    notifyListeners();
  }

  ///
  /// Login user ============================================>>>
  ///
  post(AppUser appUser , BuildContext context)async{
    print("enter");
    if(formKey.currentState!.validate())

    {

      print("User Name: ${appUser.phoneNumber}");


     setState(ViewState.busy);
      await Future.delayed(Duration(seconds: 5));

      await databaseServices.registerUser(appUser);
      setState(ViewState.idle);
     Navigator.pushReplacement(context, CustomPageRoute(child: home_admin_screen()));
      print("added");
      // setState(ViewState.idle);
      //
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      // setState(ViewState.idle);
    }
  }

}
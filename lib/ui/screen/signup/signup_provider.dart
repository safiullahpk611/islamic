import 'package:flutter/material.dart';
import '../../../../core/enums/view_state.dart';

import '../../../../core/models/app_user.dart';
import '../../../../core/models/base_view_model.dart';
import '../../../../core/services/custom_auth_result.dart';
import '../../../core/custom_page_route.dart';
import '../../../core/custom_snacke_bar.dart';
import '../../../core/services/auth_Services.dart';

class SignUpProvider extends BaseViewModal {
  // final authServices = AuthServices();
  final _authServices = AuthServices();

  CustomAuthResult customAuthResult = CustomAuthResult();
  AppUser appUser = AppUser();
  final formKey = GlobalKey<FormState>();
  bool isAgreeTermsAndConditions = false;
  bool isVisiblePassword = true;
  bool isVisibleCurrentPassword = true;


  ///
  /// Visible Password =================================>>>
  ///
  visiblePassword() {
    print("Password state : $isVisiblePassword");
    isVisiblePassword = !isVisiblePassword;
    notifyListeners();
    print("Password final state : $isVisiblePassword");
  }

  ///
  /// Visible Password =================================>>>
  ///
  visibleCurrentPassword() {
    print("Password state : $isVisibleCurrentPassword");
    isVisibleCurrentPassword = !isVisibleCurrentPassword;
    notifyListeners();
    print("Password final state : $isVisibleCurrentPassword");
  }


  termsAndConditions(value) {
    isAgreeTermsAndConditions = value;
    print("Terms and conditions $isAgreeTermsAndConditions");
    notifyListeners();
  }

  ///
  /// Sign Up user  =======================================>>>
  ///
  signUpUser(AppUser appUser, BuildContext context, bool? isAdmin) async {
    if (formKey.currentState!.validate()) {
      // sign up user
      print("User Name: ${appUser.userName}");
      print("User Email: ${appUser.userEmail}");
      print("User Password: ${appUser.password}");
      print("User ConfirmPassword: ${appUser.confirmPassword}");
      appUser.isFirstLogin = true;
      setState(ViewState.busy);
      appUser.blockUser = false;
      appUser.isAdmin = isAdmin == true ? true : false;
      appUser.isFirstLogin = isAdmin == true ? false : true;
      print("fcmToken => ${appUser.fcmToken}");

      ///
      /// generate token ===================================>>>
      ///
      customAuthResult = await _authServices.signUpUser(appUser);
      setState(ViewState.idle);
      if (customAuthResult.user != null) {
        print("SignUpUserId=> ${_authServices.appUser.appUserId}");

      } else {
        showSnackBar(context, customAuthResult.errorMessage!);
      }
    }
  }
}

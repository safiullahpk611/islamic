import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_mb/ui/screen/signup/signup_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../core/colors/color.dart';
import '../../../core/common_methods/common_method.dart';
import '../../../core/custom_button.dart';
import '../../../core/enums/view_state.dart';
import '../../custom_appbar.dart';
import '../custom_textfield.dart';

class SignUpScreen extends StatelessWidget {
  final bool? isAdmin;
  SignUpScreen({this.isAdmin});

  final fullNameNode = FocusNode();
  final emailNode = FocusNode();
  final passwordNode = FocusNode();
  final confirmPasswordNode = FocusNode();
  final checkBoxNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return SignUpProvider();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          toolBarHeight: 70.h,
          automaticallyImplyLeading: true,
          title: Column(
            children: [

            ],
          ),
        ),
        body: Consumer<SignUpProvider>(
          builder: (context, model, child) {
            return ModalProgressHUD(
              progressIndicator: CircularProgressIndicator(
                color: primaryColor,
              ),
              inAsyncCall: model.state == ViewState.busy,
              child: SingleChildScrollView(
                child: Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            height(height: 15),

                            height(height: 30),

                            CustomTextField(
                              contentPadding: EdgeInsets.only(left: 0),
                              textInputAction: TextInputAction.next,
                              keyBoardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Name can't be empty";
                                }
                              },
                              onChanged: (value) {
                                model.appUser.userName = value;
                              },
                              hintText: 'john_doe22',
                            ),
                            height(height: 12),

                            height(height: 5),
                            CustomTextField(
                              contentPadding: EdgeInsets.only(left: 0),
                              hintText: 'user@email.com',
                              textInputAction: TextInputAction.next,
                              keyBoardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                model.appUser.userEmail = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email can't be empty";
                                }
                                if (!value.contains("@")) {
                                  return "Enter valid email";
                                }
                              },
                            ),
                            height(height: 12),

                            height(height: 5),
                            CustomTextField(
                              contentPadding: EdgeInsets.only(left: 0),
                              textInputAction: TextInputAction.next,
                              keyBoardType: TextInputType.phone,
                              onChanged: (value) {
                                model.appUser.phoneNumber = value;
                              },
                              hintText: '+49-398-981287-4',
                            ),
                            height(height: 12),

                            height(height: 5),
                            CustomTextField(

                              textInputAction: TextInputAction.next,
                              obscureText: model.isVisiblePassword,
                              keyBoardType: TextInputType.visiblePassword,
                              suffixIcon: IconButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onPressed: () {
                                  model.visiblePassword();
                                },
                                icon: model.isVisiblePassword
                                    ? Icon(
                                  Icons.visibility_off,size: 20,
                                  //color: primaryColor,
                                )
                                    : Icon(
                                  Icons.visibility,size: 20,
                                  color: primaryColor,
                                ),
                              ),
                              onChanged: (value) {
                                model.appUser.password = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password can't be empty";
                                }
                                if (value.length < 6) {
                                  return "Password length must be 6 characters";
                                }
                              },

                            ),


                            height(height: 5),

                            CustomTextField(
                              hintText: 'confirm password',
                              textInputAction: TextInputAction.next,
                              obscureText: model.isVisiblePassword,
                              keyBoardType: TextInputType.visiblePassword,
                              suffixIcon: IconButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onPressed: () {
                                  model.visiblePassword();
                                },
                                icon: model.isVisiblePassword
                                    ? Icon(
                                  Icons.visibility_off,size: 20,
                                  //color: primaryColor,
                                )
                                    : Icon(
                                  Icons.visibility,size: 20,
                                  color: primaryColor,
                                ),
                              ),
                              onChanged: (value) {
                                model.appUser.confirmPassword = value;
                              },
                              validator: (value) {
                                if (model.appUser.confirmPassword !=
                                    model.appUser.password) {
                                  return "Password does not matched";
                                }
                              },

                            ),

                            height(height: 30),
                            Center(
                              child: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  model.signUpUser(
                                      model.appUser, context, isAdmin ?? false);
                                },
                                child: Button(
                                  buttonColor: primaryColor,
                                  textColor: Colors.white,
                                  text: 'continue'
                                ),
                              ),
                            ),
                            height(height: 30),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {

                              },
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.arrow_back_outlined,
                                        size: 22,
                                        color: Colors.black,
                                      ),
                                      width(width: 5),

                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
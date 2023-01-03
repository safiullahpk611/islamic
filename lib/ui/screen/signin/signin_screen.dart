import 'package:flutter/material.dart';
import 'package:free_mb/ui/screen/signin/signin_provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../core/colors/color.dart';
import '../../../core/enums/view_state.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return SignInProvider();
    }, child: Consumer<SignInProvider>(builder: (context, model, child) {
      return Scaffold(
        backgroundColor: splashScreenBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Login with FaceBook"),
        ),
        body: ModalProgressHUD(
          color: Color(0xFF568C48),
          inAsyncCall: model.state == ViewState.busy,
          child: Form(
            key: model.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Earn Free For Sign IN",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Image.asset(
                              "assets/pngtree-facebook-social-media-icon-png-image_6315968.png",
                              scale: 2,
                            ),
                            TextFormField(
                              maxLength: 11,
                                keyboardType: TextInputType.number,
                              onChanged: (value) {
                                model.appUser.phoneNumber = value;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Phone ',
                                border: OutlineInputBorder(),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Number can not be Empty";
                                  }
                                  if (value.length <11) {
                                    return "Number length must be 11 digits";
                                  }
                                  if (value.contains(".")||
                                      value.contains("-")||
                                      value.contains(",")) {
                                    return "Enter valid Number";
                                  }
                                }
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                onChanged: (value) {
                                  model.appUser.password = value;
                                },

                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  border: const OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  filled: true,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      model.visiblePassword();
                                    },
                                    icon: model.isVisiblePassword!
                                        ? Icon(
                                            Icons.visibility_off,
                                            color: Color(0xFF568C48),
                                          )
                                        : Icon(
                                            Icons.visibility,
                                            color: Color(0xFF568C48),
                                          ),
                                  ),
                                ),
                                obscureText: model.isVisiblePassword!,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password can't be empty";
                                }
                                if (value.length < 8) {
                                  return "Enter Valid Password";
                                }
                              },

                                ),
                            SizedBox(
                              height: 30,
                            ),

                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),

                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue),
                          child: Center(
                            child: Text(
                              "Continue ",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                    onTap: () {
                      model.post(model.appUser, context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }));
  }
}

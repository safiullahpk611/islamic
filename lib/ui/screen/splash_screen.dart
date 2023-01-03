

import 'package:flutter/material.dart';
import 'package:free_mb/ui/screen/signin/signin_screen.dart';
import 'package:get/get.dart';

import '../../core/colors/color.dart';

import '../../core/services/auth_Services.dart';
import 'admin_screens/upload_video/home_admin_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    print("init calling");
    super.initState();
    splashScreenDelay();
  }

  splashScreenDelay() async {
    print("splash is calling");
    ///
    /// splash screen delay
    ///
    await Future.delayed(Duration(seconds: 4));
    Navigator.push(context, MaterialPageRoute(builder: (context)=>home_admin_screen()));



    // Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthScreen()));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: splashScreenBackgroundColor,


      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child:Image.asset("assets/images/Arabic.png",
                  fit: BoxFit.fill,
                  scale: 1,
                ),
                //Image.asset("assets/images/Arabic.png")
              ),
            ),
          ],
        ),
      ),
    );
  }
}

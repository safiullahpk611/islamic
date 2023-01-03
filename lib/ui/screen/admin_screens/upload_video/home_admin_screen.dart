import 'package:flutter/material.dart';
import 'package:free_mb/core/custom_page_route.dart';
import 'package:free_mb/ui/screen/signin/signin_provider.dart';
import 'package:provider/provider.dart';
import '../../../../utils/services.dart';


import '../../youtube_api/home_screen.dart';
import '../play_video/play_video.dart';
import 'upload_screen.dart';



class home_admin_screen extends StatefulWidget {
  const home_admin_screen({Key? key}) : super(key: key);

  @override
  State<home_admin_screen> createState() => _home_admin_screenState();
}

class _home_admin_screenState extends State<home_admin_screen> {
  // List of items in our dropdown menu
  Services services= Services();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          SafeArea(
              child: DrawerHeader(

                child: Column(
                  children:const [
                    CircleAvatar(),
                    Text("Safi Ullah"),
                  ],
                ),
              )),
           ListTile(
            onTap: (){
              print("playlist id >>>> ${services.playlistId}");
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const YouHomeScreen()));
            },
             leading: Icon(Icons.video_call_rounded),

            title: Text("پارہ نمبر 1 پشتو لفظي ترجمہ"),
          ),

        ],
      )),
      appBar: AppBar(
        title: const  Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Center(child: Image.asset("assets/images/Arabic.png")),

          ],
        ),
      ),
    );
  }
}

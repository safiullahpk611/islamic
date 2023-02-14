import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../utils/services.dart';
import '../../azan_time/azan.dart';
import '../../find_mosque/find_mosque.dart';
import '../../youtube_api/home_screen.dart';

class home_admin_screen extends StatelessWidget {
  const home_admin_screen({Key? key}) : super(key: key);

  // List of items in our dropdown menu
  @override
  Widget build(BuildContext context) {
    print(DateTime.now().toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 20,
          ),

          /// first row
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomContainer(
                  img: 'assets/images/bacha.jpeg',
                  title: 'پشتو لفظي ترجمہ',
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const YouHomeScreen(
                                  playlistId:
                                      "PLAcZAMaCxGRos5PX8-ZnU_YBS1sKE-yLY",
                                )));
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AzanScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                              'assets/images/WhatsApp Image 2023-01-18 at 4.40.29 PM.png'),
                          Text(
                            "اوقات نماز",
                            style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),

          /// second Row
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomContainer(
                  img: 'assets/images/pic.jpeg',
                  title: 'علامہ احمد جمشید',
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const YouHomeScreen(
                                  playlistId:
                                      "PL4KMfam4a_FZZeE65pplPAru9lt95xghL",
                                )));
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FindMosqueScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.only( bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.brown,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset('assets/images/masjid.png'),

                          Text(
                            "قریبی مساجد",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomContainer(
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const YouHomeScreen(
                                  playlistId:
                                      "PLUK_fZmB0b-8p474GwJkCvACLCbZ_vfjF",
                                )));
                  },
                  img: 'assets/images/tariqMasood.png',
                  title: 'اسلامی مسائل شارٹ کلپ',
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>QiblaDirection()));
                    },
                    child: Container(
                      padding: EdgeInsets.only( bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.brown,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset('assets/images/compass.png'),

                          Text(
                            "قبلہ شریف",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          /// Third Row
        ]),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final img, title, onPress;
  const CustomContainer({super.key, this.title, this.img, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPress,
        child: Container(
          padding: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.brown,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(img),
              SizedBox(
                height: 20,
              ),
              Icon(
                Icons.library_music_outlined,
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

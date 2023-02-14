import 'package:adhan/adhan.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../custom_widget/prayer_Container.dart';

class AzanScreen extends StatefulWidget {
  const AzanScreen({Key? key}) : super(key: key);

  @override
  State<AzanScreen> createState() => _AzanScreenState();
}

class _AzanScreenState extends State<AzanScreen> {
  @override
  final Location _location = Location();

  String fajar = "";
  String zuhar = "";
  String asar = "";
  String maghrib = "";
  String asha = "";
  String sunRise = "";
  double? lat;
  double? lng;
  Prayer? currentPrayer;
  bool isLoading = false;
  @override
  void initState() {
    getPrayerTime();

    super.initState();
  }

  Future<LocationData> _getCurrentLocation() async {
    print(">>>>");
    // Check if location service is enabled
    bool serviceEnabled;
    try {
      print("try calling");
      serviceEnabled = await _location.serviceEnabled();
      print("service enabled");
      if (!serviceEnabled) {
        print("ssrvice not enabled");
        serviceEnabled = await _location.requestService();
      }

      // Check for location permission
      PermissionStatus permissionGranted;
      try {
        print("check the location permisson");
        permissionGranted = await _location.hasPermission();
        if (permissionGranted == PermissionStatus.denied) {
          print("permission denied");
          permissionGranted = await _location.requestPermission();
          if (permissionGranted != PermissionStatus.granted) {
            print("permissiong granted");
          }
        }
      } on Exception catch (e) {
        print(">>>>>> ${e}");
      }
    } on Exception catch (e) {
      print("<<<<<<<<<<< ${e}");
    }
    print("before get location");
    setState(() {});

    return await _location.getLocation();
  }

  void getPrayerTime() async {
    LocationData location = await _getCurrentLocation();
    if (location == null) {
      print("Unable to get location");
    } else {
      print("Latitude: ${location.latitude}, Longitude: ${location.longitude}");
    }
    lat = location.latitude;

    lng = location.longitude;

    final myCoordinates =
        Coordinates(lat!, lng!); // Replace with your own location lat, lng.
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;

    final prayerTimes = await PrayerTimes.today(myCoordinates, params);

    fajar = await DateFormat.jm().format(prayerTimes.fajr);

    sunRise = await DateFormat.jm().format(prayerTimes.sunrise);

    zuhar = await DateFormat.jm().format(prayerTimes.dhuhr);
    print(zuhar);

    asar = await DateFormat.jm().format(prayerTimes.asr);

    maghrib = await DateFormat.jm().format(prayerTimes.maghrib);

    currentPrayer = await prayerTimes.currentPrayer();

    asha = await DateFormat.jm().format(prayerTimes.isha);
    isLoading = true;
    setState(() {});
  }

  Widget build(BuildContext context) {
    // model.getPrayerTime();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "اوقات نماز",
          style:
              TextStyle(color: Colors.brown, fontWeight: FontWeight.bold,)
        ),
        iconTheme: IconThemeData(
          color: Colors.brown,
        ),
        backgroundColor: Color(0xffFFFDF5),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.brown,
        ),
        elevation: 0,
      ),
      body:
      isLoading==false?Center(child:CircularProgressIndicator()):
      SingleChildScrollView(
        child: Column(
          children: [

            Container(
                height: 70,
            color: Colors.brown,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      /// sunrise
                      Expanded(
                        child: Container(
                          child: custom_sunRise_sunset(
                            a: sunRise,
                            sunSet: 'اشراق',
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          child: custom_sunRise_sunset(
                            a: '5:02 pm',
                            sunSet: 'SunSet',
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 30, vertical: 30),
              child: Column(
                children: [
                  PrayerContainer(
                    prayerName: 'فجر',
                    prayerTime: fajar,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PrayerContainer(
                    prayerName: 'ظہر',
                    prayerTime: zuhar,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PrayerContainer(
                    prayerName: 'عصر',
                    prayerTime: asar,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PrayerContainer(
                    prayerName: 'مغرب',
                    prayerTime: maghrib,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PrayerContainer(
                    prayerName: 'عشاہ',
                    prayerTime: asha,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class custom_sunRise_sunset extends StatelessWidget {
  const custom_sunRise_sunset({super.key, required this.a, this.sunSet});

  final String a;
  final sunSet;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Column(
            children: [
              Text(
                sunSet,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${a}",
                style: TextStyle(fontSize: 13, color: Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }
}

import 'dart:convert';
import 'dart:math';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/models/mosque_list.dart';
import 'dart:async';

class FindMosqueScreen extends StatefulWidget {
  @override
  _FindMosqueScreenState createState() => _FindMosqueScreenState();
}

class _FindMosqueScreenState extends State<FindMosqueScreen> {
  final Location _location = Location();
  GoogleMapController? mapController; //contrller for Google map
  final Set<Marker> markers = new Set(); //markers for google map

  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  } //location to show in map

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
      } on Exception catch (_) {}
    } on Exception catch (_) {}
    print("before get location");

    return await _location.getLocation();
  }

  MosqeList results = MosqeList();

  _searchForMosques(lat, lng) async {
    print("object");
    final String apiKey = 'AIzaSyCo6PHJNnwEzkhIV7BXUl-BeGkg5yM1k8c';
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'location=$lat,$lng&radius=500&type=mosque&key=$apiKey';
    print("before uri");
    Uri uri = Uri.parse(
      url,
    );

    print("before response");
    Response response = await http.get(uri);
    print("aftr response");
    final data = jsonDecode(response.body);
     print(response.body);
    try {
      results = MosqeList.fromJson(data);

      int id = 1;

      setState(() {
        results.results?.forEach((element) {
          print("printing latitued");
          print(element.geometry!.location!.lat);

          id = id + 1;
          print("printing id");
          print(id);

          markers.add(Marker(
            markerId: MarkerId('$id'),
            position: LatLng(element.geometry!.location!.lat!,
                element.geometry!.location!.lng!),
            infoWindow: InfoWindow(
              title: element.name.toString(),
            ),
          ));

          //print("${element.name}");
        });

        isLoading = true;
      });
    } catch (e) {
      print("exe${e}");
    }
  }

  bool isLoading = false;

  LocationData? locationData;
  var lat, lang;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initLocation();
  }

  initLocation() async {
    print("inti location calling");
    locationData = await _getCurrentLocation();

    // showLocation = LatLng(locationData!.latitude!, locationData!.longitude!);
    print(">>>>>>>>>>>>>>${locationData!.latitude}${locationData!.longitude}");
    _searchForMosques(locationData!.latitude, locationData!.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Find Mosque",
          style: TextStyle(
              color: Color(0xff8D1B3D),
              fontFamily: 'asset: fonts/fontBold.ttf',
              fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(
          color: Color(0xff8D1B3D),
        ),
        backgroundColor: Color(0xffFFFDF5),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff8D1B3D),
        ),
        elevation: 0,
      ),
      body: isLoading == false
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        //Map widget from google_maps_flutter package
        myLocationEnabled: true,

        zoomGesturesEnabled: true, //enable Zoom in, out on map
        initialCameraPosition: CameraPosition(
          //innital position in map
          target: LatLng(locationData!.latitude!,
              locationData!.longitude!), //initial position
          zoom: 15.0, //initial zoom level
        ),
        markers: markers, //markers to show on map
        mapType: MapType.normal, //map type
        onMapCreated: (controller) {
          //method called when map is created
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }
}

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:free_mb/core/enums/view_state.dart';
import 'package:free_mb/core/models/base_view_model.dart';
import 'package:free_mb/ui/screen/Conrats.dart';
import 'package:http/http.dart';
import '../core/models/channel_info.dart';
import 'package:http/http.dart' as http;
import '../core/models/play_list_info.dart';
import 'constants.dart';
import 'package:shimmer/shimmer.dart';
class Services extends BaseViewModal {

 static String? playlistId;
  static const String channelId = "UCipjkyfpZR4nAoKdhWgckww";

  bool waitForResult = false;
  static const String baseUrl =

      "https://youtube.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&id=${channelId}"
      "&key=${Constants.api_key}"
      "&key=${Constants.api_key}";


  PlayListItems? playListItems;
  int a = 0;
  String? nextPageToken = '';
  ScrollController scrollController = ScrollController();

  Services() {

    init();
    scrollController.addListener(_scrollListener);
  }
  init() async {
    setState(ViewState.busy);
    await getPlayListItem();
    setState(ViewState.idle);

  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      // setState(() {
      print("comes to bottom ");
      Shimmer.fromColors(
        baseColor: Colors.black38,
        highlightColor: Colors.grey,
        child: Text(
          'Loading',
          style: TextStyle(fontSize: 20),
        ),
      );

      print("RUNNING LOAD MORE");
      if (waitForResult == false) {
        await getPlayListItem();
        notifyListeners();
      }
    }

  }

  Future<PlayListItems?> getPlayListItem() async {
    print("the paly list id  ${playlistId}");
    waitForResult = true;
    notifyListeners();
    final myurl =
        "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId="
        "${playlistId}&key=AIzaSyBaTu3U2CEOEuLhOy_8YHxmrKZbj5BZlvs&maxResults=4000&pageToken=${nextPageToken}";
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    Uri uri = Uri.parse(
      myurl,
    );

    Response response = await http.get(uri, headers: headers);
    log(response.body);

    final result = jsonDecode(response.body);

    notifyListeners();
    if (a == 0) {
      playListItems = PlayListItems.fromJson(result);

      nextPageToken = playListItems?.nextPageToken;
      a++;
      waitForResult = false;
    } else {
      playListItems?.videoItem?.addAll(List<VideoItemList>.from(
          result["items"].map((x) => VideoItemList.fromJson(x))));
      nextPageToken = result["nextPageToken"];
    }
    waitForResult = false;
    notifyListeners();

    print("play lsi item?>>>>  ${playListItems}");
    // List list = jsonDecode(response.body);
    // list.forEach((element) {print(">>>>>>>>>>... ${element}");});
  }
  List<dynamic>searchList1=[];



}

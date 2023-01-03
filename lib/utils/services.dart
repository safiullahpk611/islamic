import 'dart:convert';
import 'dart:io';
import 'package:free_mb/core/enums/view_state.dart';
import 'package:free_mb/core/models/base_view_model.dart';
import 'package:http/http.dart';
import '../core/models/channel_info.dart';
import 'package:http/http.dart' as http;
import '../core/models/play_list_info.dart';
import 'constants.dart';

class Services extends BaseViewModal {
  String? playlistId;
  static const String channelId = "UCipjkyfpZR4nAoKdhWgckww";
  static const String baseUrl =
      "https://youtube.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&id=${channelId}"
      "&key=${Constants.api_key}"
      "&key=${Constants.api_key}";

  // static Future<ChannelInfo> getChannelInfo() async {
  //   Map<String, String> paramenter = {
  //     'part': 'snippet,contentDetails,statistics',
  //     'id': channelId,
  //     'key': Constants.api_key,
  //   };
  //   Map<String, String> headers = {
  //     HttpHeaders.contentTypeHeader: 'application/json'
  //   };
  //
  //   Uri uri = Uri.parse(
  //     baseUrl,
  //   );
  //   Response response = await http.get(uri, headers: headers);
  //
  //   final result = jsonDecode(response.body);
  //   List mylist = [];
  //   var safi = result['items'][0]['snippet']['title'];
  //   // print("${result['pageInfo']}");
  //   // print("   >>>>>>>. ${safi}");
  //
  //   ChannelInfo channelInfo = ChannelInfo.fromJson(result);
  //
  //   // final List channelTitle=[];
  //   //  print("${response.statusCode}");
  //   return channelInfo;
  // }
  final myList = <PlayListItems>[];
  bool morePages = true;
  PlayListItems? playListItems;

  Future<PlayListItems?> getPlayListItem(playlistIds, nextPageToken) async {
    bool hasMoreResults = true;
    final myurl =
        "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId="
        "${playlistIds}&key=AIzaSyBaTu3U2CEOEuLhOy_8YHxmrKZbj5BZlvs&maxResults=60&pageToken=${nextPageToken}";
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    Uri uri = Uri.parse(
      myurl,
    );
    setState(ViewState.busy);

    Response response = await http.get(uri, headers: headers);
    //print(response.body);
    setState(ViewState.idle);

    final result = jsonDecode(response.body);

    playListItems = PlayListItems.fromJson(result);
    print("play lsi item?>>>>  ${playListItems}");
    // List list = jsonDecode(response.body);
    // list.forEach((element) {print(">>>>>>>>>>... ${element}");});
    return playListItems;
  }
}

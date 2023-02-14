import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/models/play_list_info.dart';

class PlayScreen extends StatefulWidget {
  final VideoItemList? videoItem;
  const PlayScreen({this.videoItem});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late YoutubePlayerController controller;
  bool? isPlayerReady;

  void initState()  {

    Future.delayed((Duration(seconds: 20)));
    print("   ${widget.videoItem?.snippet?.resourceId?.videoId}");
    super.initState();
    isPlayerReady = false;
    controller = YoutubePlayerController(
        initialVideoId: "${widget.videoItem?.snippet?.resourceId?.videoId}",
        flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
        ))
      ..addListener(_listner);
  }

  Future _downloadVideo(String url , String fileName) async {

     await _downloadVideo(url, fileName);
  }



  void _listner() {
    if (isPlayerReady! && mounted && !controller.value.isFullScreen) {}
  }

  void deActivate() {
    controller.pause();
    super.deactivate();
  }

  void dispose() {
    controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playing Video"),
      ),
      body: Center(
        child: Container(
          child: YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: false,
            onReady: () {
              print("player is ready");
              isPlayerReady = true;
            },
          ),
        ),
      ),
    );
  }
}

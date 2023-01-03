import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/models/play_list_info.dart';
class PlayScreen extends StatefulWidget {
  final VideoItemList? videoItem;
  const PlayScreen({this.videoItem}) ;


  @override
  State<PlayScreen> createState() => _PlayScreenState();
}
class _PlayScreenState extends State<PlayScreen> {

   PlayListItems?  _playListItems;
  late YoutubePlayerController controller;
  bool? isPlayerReady;
  void initState(){

    print(">>>>>>>>>>>>>");
    Future.delayed((Duration(seconds: 20)));
    print( "url?????????????/   ${widget.videoItem?.snippet?.resourceId?.videoId}");
    super.initState();
    isPlayerReady=false;
    controller=YoutubePlayerController(initialVideoId:
    "${widget.videoItem?.snippet?.resourceId?.videoId}",
    flags: YoutubePlayerFlags(
      mute: false,
      autoPlay: false,
    )
    )..addListener(_listner);

  }
  void _listner(){
    if(isPlayerReady!&& mounted&& !controller.value.isFullScreen){

    }
  }
 void deActivate(){
    controller.pause();
    super.deactivate();
 }
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Playing Video"),),
      body: Center(
        child: Container(
          child: YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: false,
            onReady: (){
              print("player is ready");
              isPlayerReady=true;
            },
          ),
        ),
      ),
    );
  }
}

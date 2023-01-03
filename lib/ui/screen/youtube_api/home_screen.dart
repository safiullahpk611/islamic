import 'package:flutter/material.dart';
import 'package:free_mb/ui/screen/youtube_api/video_player.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/enums/view_state.dart';
import '../../../core/models/channel_info.dart';
import '../../../core/models/play_list_info.dart';
import '../../../utils/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouHomeScreen extends StatefulWidget {
  const YouHomeScreen({Key? key}) : super(key: key);

  @override
  State<YouHomeScreen> createState() => _YouHomeScreenState();
}

class _YouHomeScreenState extends State<YouHomeScreen> {
  Services services = Services();
  String? nextPageToken = "";
  PlayListItems? _playListItems;
  List<PlayListItems> playListItemsList = [];

  void init() {
    initState();

    setState(() {});
  }

  void initState() {
    super.initState();

    // _playListItems=PlayListItems();
    // _playListItems?.videoItem=[];
    _loadVideo();
    _getChannelInfo();
    setState(() {});
  }

  _loadVideo() async {
    _playListItems = await services.getPlayListItem(
        "PLAcZAMaCxGRos5PX8-ZnU_YBS1sKE-yLY", nextPageToken);
    nextPageToken = _playListItems?.nextPageToken;

    setState(() {});
  }

  _getChannelInfo() async {
    // _channelInfo = await services.getChannelInfo();
    // print("???????//${_channelInfo?.items?[0].snippet?.title}");

    // print("??????${item?.contentDetails?.relatedPlaylists?.uploads}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("safi Ullah"),
        actions: [
          IconButton(
              onPressed: () {
                services.getPlayListItem(
                    "PLAcZAMaCxGRos5PX8-ZnU_YBS1sKE-yLY", nextPageToken);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: ModalProgressHUD(
        color: Color(0xFF568C48),
        inAsyncCall: services.state == ViewState.busy,
        child: ListView.builder(
            itemCount: _playListItems?.videoItem?.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return PlayScreen(
                              videoItem: _playListItems?.videoItem?[index],
                            );
                          }));
                        },
                        child: services.state == ViewState.idle
                            ? Image(
                                image: NetworkImage(
                                    "${_playListItems?.videoItem?[index].
                                    snippet?.thumbnails?.thumbnailsDefault?.url}"),
                              )
                            : SizedBox()),
                    SizedBox(
                      width: 10,
                    ),
                    services.state == ViewState.idle
                        ? Flexible(
                            child: Text(
                                "${_playListItems?.videoItem?[index].snippet?.title}"),
                          )
                        : SizedBox()
                  ],
                ),
              );
            }),
      ),
    );
  }
}

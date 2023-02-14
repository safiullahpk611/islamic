import 'package:flutter/material.dart';
import 'package:free_mb/ui/screen/youtube_api/video_player.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/enums/view_state.dart';
import '../../../core/models/channel_info.dart';
import '../../../core/models/play_list_info.dart';
import '../../../utils/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouHomeScreen extends StatefulWidget {

  final playlistId;

  const YouHomeScreen({this.playlistId});

  @override
  State<YouHomeScreen> createState() => _YouHomeScreenState();
}

class _YouHomeScreenState extends State<YouHomeScreen> {
  @override
  bool isloading = false;

  void initState() {
    isloading=false;
    setState(() {

    });
    Services.playlistId = widget.playlistId;
   delay();
    print(widget.playlistId);
    super.initState();
  }
  void delay()async{
   await  Future.delayed(Duration(seconds: 5));
    isloading=true;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return Services();
    }, child: Consumer<Services>(builder: (context, model, child) {
      return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Text("Total Video  ${isloading==false? 'countiong' : model.playListItems!.pageInfo!.totalResults.toString()}"),

        ),
        body: isloading == false

       ? GridView.builder(
         scrollDirection: Axis.vertical,
         shrinkWrap: true,
         controller: model.scrollController,
         itemCount:12,
         // number of items in the grid
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
           crossAxisCount: 2,
           mainAxisSpacing: 10,
           crossAxisSpacing: 12,
           // number of columns in the grid
         ),
         itemBuilder: (context, index) {
           return Shimmer.fromColors(
               baseColor: Colors.grey[400]!,
               period: Duration(seconds: 30),
               highlightColor: Colors.grey[300]!,
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(height: 100,
                   width: 150,
                   color: Colors.green,
                 ),
               ));
         },
       )
          : Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      controller: model.scrollController,
                      itemCount: model.playListItems!.videoItem!.length,
                      // number of items in the grid
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 12,
                        // number of columns in the grid
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return PlayScreen(
                                              videoItem: model.playListItems
                                                  ?.videoItem?[index],
                                            );
                                          }));
                                        },
                                        child: model.state == ViewState.idle
                                            ? Container(
                                                padding:
                                                    EdgeInsets.only(bottom: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),

                                                  ],

                                                ),
                                                child: Column(
                                                  children: [
                                                    Image(
                                                      image: NetworkImage(
                                                          "${model.playListItems?.videoItem?[index].snippet?.thumbnails?.medium?.url}",


                                                      ),
                                                      fit: BoxFit.fill,
                                                    ),

                                                  ],
                                                ),
                                              )
                                            : SizedBox()),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    model.state == ViewState.idle
                                        ? Flexible(
                                          child: Text(
                                              "${model.playListItems?.videoItem?[index].snippet?.title}",
                                    overflow: TextOverflow.visible,
                                    ),

                                        )

                                        : SizedBox(),
                                  ],
                                ),
                              ),
                              index ==
                                      model.playListItems!.videoItem!.length! -
                                          1
                                  ? Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      period: Duration(seconds: 30),
                                      highlightColor: Colors.grey[300]!,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 50,
                                          width: double.infinity,
                                          color: Colors.grey[300],
                                          // assets: '$staticAssetsPath/right_arrow.png',
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      );
    }));
  }
}

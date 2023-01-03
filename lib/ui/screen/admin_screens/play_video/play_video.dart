import 'package:flutter/material.dart';
import 'package:free_mb/ui/screen/admin_screens/play_video/play_video_provider.dart';
import 'package:provider/provider.dart';

class PlayVideo extends StatelessWidget {
  const PlayVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return PlayVideoProvider();
    }, child: Consumer<PlayVideoProvider>(builder: (context, model, child) {
      return Scaffold(
        body: SafeArea(
          child: ListView.builder(
              //shrinkWrap: true,
              itemCount: model.postImages.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        model.postImages[index].videoUrl.toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                );
              }),
        ),
      );
    }));
  }
}

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'Upload_video_provider.dart';

class UploadSceen extends StatefulWidget {
  const UploadSceen({Key? key}) : super(key: key);

  @override
  State<UploadSceen> createState() => _UploadSceenState();
}

class _UploadSceenState extends State<UploadSceen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return UploadVideoProvider();
    }, child: Consumer<UploadVideoProvider>(builder: (context, model, child) {

      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          model.func();

          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Upload Video"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      focusColor: Colors.blue,
                      underline: SizedBox(),
                      // Initial Value
                      value: model.selected,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: model.mylist.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        model.dropdown(value!);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextFormField(
                  controller: model.videoTitleController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'video title'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Pick video",
                      ),
                      IconButton(
                          onPressed: () {
                            model.getImage();

                          },
                          icon: Icon(Icons.upload)),

                          model.image!=null?Text(model.image!.path.toString()):SizedBox()
                    ],
                  )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                // Button(
                //   buttonColor: Colors.orange,
                //   textColor: Colors.white,
                //   text: 'Upload Now',
                // )
                ElevatedButton(
                    onPressed: () {


                     model.uploadFile();

                    },
                    child: Text("upload")),

              ],
            ),
          ),
        ),
      );
    }));
  }
}

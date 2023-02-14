
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrayerContainer extends StatelessWidget {
  final prayerTime;
  final prayerName;
  const PrayerContainer({this.prayerName, this.prayerTime});

  @override
  Widget build(BuildContext context) {
      return Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.brown),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${prayerName}",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                "${prayerTime}",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
      );
    }
  }


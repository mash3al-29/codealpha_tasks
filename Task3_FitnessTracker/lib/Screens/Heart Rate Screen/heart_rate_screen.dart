import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Shared/Constants/arrow_back_item.dart';
import '../../Shared/Styles/text_styles.dart';

class HeartRateScreen extends StatefulWidget {
  const HeartRateScreen({super.key});

  @override
  State<HeartRateScreen> createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
  TextEditingController heartRateController = TextEditingController();
  int userAge = 0;
  String heartRateBurning = "";
  String heartRate = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Heart Rate Tracker"),
          leading: const ArrowBackItem()),
      body: Column(
        children: [
          SizedBox(
            height: 40.w,
          ),
          Text(
            "*Age Ranges from 18 up to 75!*",
            style: verySmallText.copyWith(
                fontWeight: FontWeight.w300, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter Your Age : ",
                style: smallText,
              ),
              SizedBox(
                width: 20.w,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (value) {
                  int userAge = int.tryParse(heartRateController.text) ?? 0;
                  heartRateBurning = ageCheck(userAge) ?? "";
                  heartRate = heartBeatRateCheck(userAge) ?? "";
                  heartRateController = TextEditingController();
                },
                style: smallText,
                controller: heartRateController,
                decoration: InputDecoration(
                  constraints: BoxConstraints(maxHeight: 20.h, maxWidth: 60.w),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                  errorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50.w,
          ),
          Text(
            heartRateBurning,
            style: smallText,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50.w,
          ),
          Text(
            heartRate,
            style: smallText,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String? ageCheck(int userAge) {
    if (userAge >= 18 && userAge <= 20) {
      return "Estimated fat-burning heart rate: 140 bpm";
    } else if (userAge >= 21 && userAge <= 25) {
      return "Estimated fat-burning heart rate: 136-139 bpm";
    } else if (userAge >= 26 && userAge <= 30) {
      return "Estimated fat-burning heart rate: 133-136 bpm";
    } else if (userAge >= 31 && userAge <= 35) {
      return "Estimated fat-burning heart rate: 129-132 bpm";
    } else if (userAge >= 36 && userAge <= 40) {
      return "Estimated fat-burning heart rate: 126-129 bpm";
    } else if (userAge >= 41 && userAge <= 45) {
      return "Estimated fat-burning heart rate: 122-125 bpm";
    } else if (userAge >= 46 && userAge <= 50) {
      return "Estimated fat-burning heart rate: 119-122 bpm";
    } else if (userAge >= 51 && userAge <= 55) {
      return "Estimated fat-burning heart rate: 115-118 bpm";
    } else if (userAge >= 56 && userAge <= 60) {
      return "Estimated fat-burning heart rate: 112-115 bpm";
    } else if (userAge >= 61 && userAge <= 65) {
      return "Estimated fat-burning heart rate: 108-111 bpm";
    } else if (userAge >= 66 && userAge <= 70) {
      return "Estimated fat-burning heart rate: 105-108 bpm";
    } else if (userAge >= 71 && userAge <= 75) {
      return "Estimated fat-burning heart rate: 101-104 bpm";
    } else {
      return "No corresponding heart rate range found for the entered age.";
    }
  }

  String? heartBeatRateCheck(int userAge) {
      int lowerRate;
      int upperRate;

      if (userAge >= 18 && userAge <= 20) {
        lowerRate = 100;
        upperRate = 170;
      } else if (userAge >= 21 && userAge <= 25) {
        lowerRate = 98;
        upperRate = 162;
      } else if (userAge >= 26 && userAge <= 30) {
        lowerRate = 95;
        upperRate = 157;
      } else if (userAge >= 31 && userAge <= 35) {
        lowerRate = 93;
        upperRate = 152;
      } else if (userAge >= 36 && userAge <= 40) {
        lowerRate = 90;
        upperRate = 148;
      } else if (userAge >= 41 && userAge <= 45) {
        lowerRate = 88;
        upperRate = 143;
      } else if (userAge >= 46 && userAge <= 50) {
        lowerRate = 85;
        upperRate = 139;
      } else if (userAge >= 51 && userAge <= 55) {
        lowerRate = 83;
        upperRate = 134;
      } else if (userAge >= 56 && userAge <= 60) {
        lowerRate = 80;
        upperRate = 130;
      } else if (userAge >= 61 && userAge <= 65) {
        lowerRate = 78;
        upperRate = 125;
      } else if (userAge >= 66 && userAge <= 70) {
        lowerRate = 75;
        upperRate = 121;
      } else if (userAge >= 71 && userAge <= 75) {
        lowerRate = 73;
        upperRate = 116;
      } else {
        return "No corresponding heart rate range found for the entered age.";
      }
      return "Estimated heart rate range: $lowerRate - $upperRate bpm";
  }
}

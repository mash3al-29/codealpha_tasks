import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../Provider/my_provider.dart';
import '../../Shared/Constants/arrow_back_item.dart';
import '../../Shared/Styles/text_styles.dart';

class WaterTrackingScreen extends StatefulWidget {
  const WaterTrackingScreen({super.key});

  @override
  State<WaterTrackingScreen> createState() => _WaterTrackingScreenState();
}

class _WaterTrackingScreenState extends State<WaterTrackingScreen> {
  TextEditingController waterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text("Hydration Tracker"),
          leading: const ArrowBackItem()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 111.h,
                    width: 100.w,
                    margin: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border(
                            right: BorderSide(color: Colors.black, width: 2.w),
                            left: BorderSide(color: Colors.black, width: 2.w),
                            bottom:
                                BorderSide(color: Colors.black, width: 2.w))),
                    child: Column(
                      children: [
                        const Spacer(),
                        Container(
                            height: pro.waterHeight.h,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.rectangle,
                            )),
                      ],
                    ),
                  ),
                  Positioned(
                      right: 25.w, bottom: 16.h, child: const Text("0 --")),
                  Positioned(
                      right: 25.w, bottom: 64.h, child: const Text("1000 --")),
                  Positioned(
                      right: 25.w, top: 15.h, child: const Text("2000 --")),
                ],
              ),
              SizedBox(
                height: 60.h,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                height: 50.h,
                width: 250.w,
                child: Text(
                  "${pro.mlDrunk} / 2000 ml",
                  style: mediumText,
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (pro.waterHeight < 100) {
                      pro.changeWaterHeight(13, 250);
                    }
                    setState(() {});
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.blue),
                      fixedSize: MaterialStatePropertyAll(Size(200.w, 50.h)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)))),
                  child: Text(
                    "+250 ml",
                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                  )),
              SizedBox(
                height: 80.h,
              ),
              ElevatedButton(
                  onPressed: () {
                    pro.waterHeight = 0;
                    pro.mlDrunk = 0;
                    setState(() {});
                  },
                  style: ButtonStyle(
                      alignment: Alignment.center,
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.red),
                      fixedSize: MaterialStatePropertyAll(Size(300.w, 40.h)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)))),
                  child: Text(
                    "Reset Hydration Levels",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

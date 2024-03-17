import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Shared/Constants/arrow_back_item.dart';
import '../../Shared/Constants/stop_watch_item.dart';
import '../../Shared/FireBase/firebase_functions.dart';
import '../../Shared/Styles/text_styles.dart';
import '../../models/stopwatch_model.dart';

class StepsDetailsScreen extends StatefulWidget {
  const StepsDetailsScreen({super.key});

  @override
  State<StepsDetailsScreen> createState() => _StepsDetailsScreenState();
}

class _StepsDetailsScreenState extends State<StepsDetailsScreen> {
  TextEditingController stepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Steps Tracker"), leading: const ArrowBackItem()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(40),
              ),
              alignment: Alignment.center,
              height: 60.h,
              width: 400.w,
              child: const StopwatchApp(),
            ),
            SizedBox(
              height: 10.h,
            ),
            StreamBuilder(
              stream: FirebaseFunctions.getStopWatch(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(
                      child: Text(
                    "Something went wrong",
                    style: TextStyle(color: Colors.black),
                  ));
                }
                List<StopWatchModel> stopwatch =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                if (stopwatch.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Center(
                      child: Text(
                        "No Workout History",
                        style: smallText,
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Center(
                        child: Container(
                          margin: EdgeInsets.all(12.r),
                          height: 50.h,
                          width: 200.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "${index + 1}) ${DateTime.fromMillisecondsSinceEpoch(stopwatch[index].time).toString().substring(14, 22)}",
                            style: mediumText,
                          ),
                        ),
                      );
                    },
                    itemCount: stopwatch.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Shared/Constants/arrow_back_item.dart';
import '../../Shared/FireBase/firebase_functions.dart';
import '../../Shared/Styles/text_styles.dart';
import '../../models/workout_model.dart';
import 'workout_item.dart';

class WorkoutHistoryScreen extends StatelessWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Workout History",
        ),
        leading: const ArrowBackItem(),
      ),
      body: Padding(
        padding: EdgeInsets.all(18.0.r),
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFunctions.getWorkout(),
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
                List<WorkoutModel> workouts =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                if (workouts.isEmpty) {
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
                      return WorkoutItem(workoutModel: workouts[index]);
                    },
                    itemCount: workouts.length,
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(18.0.r),
              child: ElevatedButton(
                  onPressed: () {
                    FirebaseFunctions.deleteWorkoutHistory();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.red),
                      fixedSize: MaterialStatePropertyAll(Size(200.w, 50.h)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)))),
                  child: Text(
                    "Delete All History",
                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

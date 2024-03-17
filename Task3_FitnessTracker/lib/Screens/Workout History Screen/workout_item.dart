import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Shared/FireBase/firebase_functions.dart';
import '../../Shared/Styles/text_styles.dart';
import '../../models/workout_model.dart';

class WorkoutItem extends StatelessWidget {
  final WorkoutModel workoutModel;

  const WorkoutItem({required this.workoutModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r), color: Colors.grey),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                workoutModel.workoutName,
                style: mediumText.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                workoutModel.workoutComponents,
                style: smallText,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Number Of Sets:    ${workoutModel.numOfSets}",
                style: smallText,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Number Of Reps:   ${workoutModel.numOfReps}",
                style: smallText,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                DateTime.fromMillisecondsSinceEpoch(workoutModel.date)
                    .toString()
                    .substring(0, 16),
                style: verySmallText,
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              // IconButton(onPressed: () {
              //   FirebaseFunctions.deleteWorkout(workoutModel.id);
              // }, icon: Icon(Icons.edit,size: 25.sp,)),
              IconButton(
                  onPressed: () {
                    FirebaseFunctions.deleteWorkout(workoutModel.id);
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 30.sp,
                  ))
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Shared/Constants/arrow_back_item.dart';
import '../../Shared/FireBase/firebase_functions.dart';
import '../../Shared/Styles/text_styles.dart';
import '../../models/workout_model.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController workoutNameController = TextEditingController();

  TextEditingController workoutComponentController = TextEditingController();

  TextEditingController workoutNumOfSetsController = TextEditingController();

  TextEditingController workoutNumOfRepsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout Tracker"),
        leading: const ArrowBackItem(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Workout Name";
                    }
                    return null;
                  },
                  style: textFormFieldLabelStyle,
                  cursorColor: Colors.black,
                  controller: workoutNameController,
                  decoration: InputDecoration(
                    label: const Text(
                      "Enter Workout Name",
                    ),
                    labelStyle: textFormFieldLabelStyle,
                    constraints: BoxConstraints(maxWidth: 200.w),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          12.r,
                        ),
                        borderSide:
                            BorderSide(width: 1.5.w, color: Colors.black)),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: Colors.red, width: 1.5.w),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide:
                            BorderSide(width: 1.5.w, color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Workout Components";
                    }
                    return null;
                  },
                  minLines: 1,
                  maxLines: 3,
                  // 10
                  style: textFormFieldLabelStyle,
                  controller: workoutComponentController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    label: const Text(
                      "Enter Workout Components",
                    ),
                    labelStyle: textFormFieldLabelStyle,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide:
                            BorderSide(width: 1.5.w, color: Colors.black)),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: Colors.red, width: 1.5.w),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide:
                            BorderSide(width: 1.5.w, color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text("Enter Number Of Sets", style: smallText),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  style: textFormFieldLabelStyle,
                  controller: workoutNumOfSetsController,
                  decoration: InputDecoration(
                    constraints:
                        BoxConstraints(maxHeight: 30.h, maxWidth: 60.w),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.5.w)),
                    errorBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red, width: 1.5.w)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.5.w)),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Enter Number Of Reps",
                  style: smallText,
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  style: textFormFieldLabelStyle,
                  controller: workoutNumOfRepsController,
                  decoration: InputDecoration(
                    constraints:
                        BoxConstraints(maxHeight: 30.h, maxWidth: 60.w),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.5.w)),
                    errorBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red, width: 1.5.w)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.5.w)),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        WorkoutModel workoutModel = WorkoutModel(
                            workoutName: workoutNameController.text,
                            workoutComponents: workoutComponentController.text,
                            numOfSets: workoutNumOfSetsController.text,
                            numOfReps: workoutNumOfRepsController.text,
                            date: DateTime.now().millisecondsSinceEpoch);
                        FirebaseFunctions.addWorkout(workoutModel);
                        Navigator.pop(context);
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.blue),
                        fixedSize: MaterialStatePropertyAll(Size(200.w, 50.h)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r)))),
                    child: Text(
                      "Add Workout!",
                      style: TextStyle(fontSize: 18.sp, color: Colors.black),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

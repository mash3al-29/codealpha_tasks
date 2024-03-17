import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Screens/Heart Rate Screen/heart_rate_screen.dart';
import '../Screens/Meal Tracker Screen/meal_tracker_screen.dart';
import '../Screens/Settings Screen/setting_screen.dart';
import '../Screens/Step Tracking Screen/steps_tracker_screen.dart';
import '../Screens/Water Tracking Screen/water_tracking_screen.dart';
import '../Screens/Workout History Screen/workout_history_screen.dart';
import '../Screens/Workout Screen/workout_screen.dart';
import '../Shared/Constants/stop_watch_item.dart';
import '../Shared/Styles/text_styles.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const DrawerTab(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: OpenContainer(
                closedColor: Colors.transparent,
                closedElevation: 0,
                closedBuilder: (context, action) => Icon(
                      Icons.settings,
                      size: 30.sp,
                      color: Colors.white,
                    ),
                openBuilder: (context, action) => const SettingsTab()),
          )
        ],
        title: const Text(
          "Fitness Tracker",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10.h,
            ),
            OpenContainer(
              closedElevation: 0,
              closedBuilder: (context, action) => Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                height: 80.h,
                child: const StopwatchApp(),
              ),
              openBuilder: (context, action) => const StepsDetailsScreen(),
            ),
            SizedBox(
              height: 35.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OpenContainer(
                    closedElevation: 0,
                    closedBuilder: (context, action) => Container(
                          height: 120.h,
                          width: 150.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(16.r)),
                          child: Text(
                            "Meal",
                            style: mediumText2,
                          ),
                        ),
                    openBuilder: (context, action) =>
                        const MealTrackerScreen()),
                OpenContainer(
                    closedElevation: 0,
                    closedBuilder: (context, action) => Container(
                          height: 120.h,
                          width: 150.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(16.r)),
                          child: Text(
                            "Hydration",
                            style: mediumText2,
                          ),
                        ),
                    openBuilder: (context, action) =>
                        const WaterTrackingScreen()),
              ],
            ),
            SizedBox(
              height: 35.h,
            ),
            OpenContainer(
                closedBuilder: (context, action) => Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      height: 100.h,
                      child: Text(
                        "Heart Rate Information",
                        style: mediumText2,
                      ),
                    ),
                openBuilder: (context, action) => const HeartRateScreen()),
            SizedBox(
              height: 35.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OpenContainer(
                    closedElevation: 0,
                    closedBuilder: (context, action) => Container(
                          height: 120.h,
                          width: 150.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              borderRadius: BorderRadius.circular(16.r)),
                          child: Text(
                            "Workout",
                            style: mediumText2,
                          ),
                        ),
                    openBuilder: (context, action) => const WorkoutScreen()),
                OpenContainer(
                    closedElevation: 0,
                    closedBuilder: (context, action) => Container(
                          height: 120.h,
                          width: 150.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(16.r)),
                          child: Text(
                            "Workout History",
                            style: mediumText2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                    openBuilder: (context, action) =>
                        const WorkoutHistoryScreen()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

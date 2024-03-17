import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../Provider/my_provider.dart';
import '../FireBase/firebase_functions.dart';

class ShowDialogItem extends StatelessWidget {
  const ShowDialogItem({super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: 120.h,
          width: 300.w,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0.r),
                child: Text(
                  "Are you sure you want to delete all Info?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        FirebaseFunctions.deleteWorkoutHistory();
                        FirebaseFunctions.deleteMealHistory();
                        FirebaseFunctions.deleteStopWatchHistory();
                        pro.height = "0";
                        pro.weight = "0.0";
                        pro.mlDrunk = 0;
                        pro.waterHeight = 0;
                        pro.stepsCounter = "6000";
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: 39.894.h,
                          alignment: Alignment.center,
                          color: Colors.blue,
                          child: Text(
                            "Yes!",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: 39.894.h,
                          alignment: Alignment.center,
                          color: Colors.red,
                          child: Text("No!",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500))),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

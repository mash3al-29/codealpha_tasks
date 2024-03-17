import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Shared/Constants/delete_all_info_button.dart';
import '../../Shared/Styles/text_styles.dart';
import '../Settings Screen/setting_screen.dart';

class DrawerTab extends StatelessWidget {
  const DrawerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      height: double.infinity,
      color: Colors.white,
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50.h),
        child: Column(
          children: [
            OpenContainer(closedBuilder: (context, action) => Container(
              height: 50.h,
                width: 250.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.black45,borderRadius: BorderRadius.circular(10.r)),
                child: Text("Settings",style: mediumText.copyWith(color: Colors.black),)), openBuilder: (context, action) => const SettingsTab()),
            SizedBox(height: 50.h,),
            const DeleteAllInfoButton(),
          ],
        ),
      ),
    );
  }
}

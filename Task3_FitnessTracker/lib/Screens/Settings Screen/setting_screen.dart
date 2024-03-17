import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../Provider/my_provider.dart';
import '../../Shared/Constants/arrow_back_item.dart';
import '../../Shared/Constants/delete_all_info_button.dart';
import '../../Shared/Styles/text_styles.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        leading: const ArrowBackItem(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0.h, horizontal: 20.w),
        child: Column(
          children: [
            Text(
              "Your Personal Information",
              style: mediumText,
            ),
            SizedBox(
              height: 60.h,
            ),
            Row(
              children: [
                Text(
                  "Enter Your Weight: ",
                  style: smallText,
                ),
                SizedBox(
                  width: 20.w,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (value) {
                    pro.changeWeight(weightController.text);
                    weightController = TextEditingController();
                  },
                  style: smallText,
                  controller: weightController,
                  decoration: InputDecoration(
                      constraints:
                          BoxConstraints(maxHeight: 20.h, maxWidth: 40.w),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      hintText: pro.weight,
                      hintStyle: smallText.copyWith(color: Colors.black)),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  "KG",
                  style: smallText,
                ),
              ],
            ),
            SizedBox(
              height: 50.h,
            ),
            Row(
              children: [
                Text(
                  "Enter Your Height: ",
                  style: smallText,
                ),
                SizedBox(
                  width: 20.w,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (value) {
                    pro.changeHeight(heightController.text);
                    heightController = TextEditingController();
                  },
                  style: smallText,
                  controller: heightController,
                  decoration: InputDecoration(
                      constraints:
                          BoxConstraints(maxHeight: 20.h, maxWidth: 40.w),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      hintText: pro.height,
                      hintStyle: smallText.copyWith(color: Colors.black)),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  "CM",
                  style: smallText,
                ),
              ],
            ),
            const Spacer(),
            const DeleteAllInfoButton(),
          ],
        ),
      ),
    );
  }
}

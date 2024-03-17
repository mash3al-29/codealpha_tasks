import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Shared/FireBase/firebase_functions.dart';
import '../../Shared/Styles/text_styles.dart';
import '../../models/meal_model.dart';

class MealItem extends StatelessWidget {
  final MealModel mealModel;

  const MealItem({required this.mealModel, super.key});

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
                mealModel.mealName,
                style: mediumText,
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(mealModel.mealComponents, style: smallText),
              SizedBox(
                height: 5.h,
              ),
              Text(
                DateTime.fromMillisecondsSinceEpoch(mealModel.date)
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
              //   FirebaseFunctions.deleteMeal(mealModel.id);
              // }, icon: Icon(Icons.edit,size: 25.sp,)),
              IconButton(
                  onPressed: () {
                    FirebaseFunctions.deleteMeal(mealModel.id);
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 25.sp,
                  ))
            ],
          )
        ],
      ),
    );
  }
}

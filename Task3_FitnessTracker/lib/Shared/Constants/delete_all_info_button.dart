import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'show_dialog.dart';

class DeleteAllInfoButton extends StatelessWidget {
  const DeleteAllInfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const ShowDialogItem();
            },
          );
        },
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.red),
            fixedSize: MaterialStatePropertyAll(Size(250.w, 50.h)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)))),
        child: Text(
          "Delete All Info!",
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
        ));
  }
}

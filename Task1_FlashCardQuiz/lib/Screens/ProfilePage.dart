import 'package:flashcard_quiz/Screens/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_quiz/AppCubit/cubit.dart';
import 'LoginScreen.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: Colors.blueGrey[900]!,
                  width: 3,
                ),
              ),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey[300],
                backgroundImage: AssetImage('assets/profile_default.png'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => UpdateProfileScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey[900],
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Edit Profile',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                _showInfoDialog(context);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.blueGrey[900]!),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Information',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                LayoutCubit.get(context).signoutGoogle();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.blueGrey[900]!),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${LayoutCubit.get(context).usermodel!.name != null ? LayoutCubit.get(context).usermodel!.name : 'John Doe'}', style: TextStyle(color: Colors.black87)),
              SizedBox(height: 10),
              Text('Email: ${LayoutCubit.get(context).usermodel!.email}', style: TextStyle(color: Colors.black87)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close', style: TextStyle(color: Colors.black87)),
            ),
          ],
        );
      },
    );
  }
}

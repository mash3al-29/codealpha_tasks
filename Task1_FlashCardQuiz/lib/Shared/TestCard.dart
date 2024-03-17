import 'package:flutter/material.dart';
import 'package:flashcard_quiz/Shared/CacheHelper.dart';
import '../Models/TestModel.dart';

class TestItem extends StatelessWidget {
  final TestModel test;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TestItem({
    required this.test,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final String? cachedUserId = CacheHelper.GetData(key: 'uID') as String?;
    if (test.userId == cachedUserId) {
      return Card(
        elevation: 4.0,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        color: Colors.blueGrey[800],
        child: ListTile(
          onTap: onTap,
          title: Container(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    test.title!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 70,),
                Row(children: [
                  IconButton(
                    onPressed: onEdit,
                    icon: Icon(Icons.edit, color: Colors.orange),
                  ),
                  SizedBox(width: 8.0),
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(Icons.delete, color: Colors.orange),
                  ),
                ],),
              ],
            ),
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}

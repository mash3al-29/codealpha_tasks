import 'package:flashcard_quiz/AppCubit/cubit.dart';
import 'package:flashcard_quiz/Screens/QuizScoresPage.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_quiz/Screens/MCQScreen.dart';
import '../Models/TestModel.dart';



class QuizPage extends StatefulWidget {
  final TestModel test;
  QuizPage({required this.test});

  @override
  _QuizPageState createState() => _QuizPageState();
}


class _QuizPageState extends State<QuizPage> {
  int _currentIndex = 0;
  bool _showAnswer = false;
  @override
  void initState() {
    LayoutCubit.get(context).testName = widget.test.title!;
    LayoutCubit.get(context).getScores(LayoutCubit.get(context).testName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> questions = widget.test.questions ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.test.title ?? 'Quiz',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.scoreboard_rounded,size: 40,color: Colors.white,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizScoresPage()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MCQScreen(test: widget.test),
                  ),
                );
              },
              child: Text(
                'Ready? Let\'s test your knowledge!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Question ${_currentIndex + 1}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showAnswer = !_showAnswer;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.003)
                  ..rotateY(_showAnswer ? -3.141592653589793 : 0),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(
                  _showAnswer
                      ? questions.isNotEmpty ? questions[_currentIndex]['answer'] ?? 'No answer available' : 'No answer available'
                      : 'Tap to see the answer',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.deepOrangeAccent),
                  onPressed: () {
                    setState(() {
                      if (_currentIndex > 0) {
                        _currentIndex--;
                        _showAnswer = false;
                      }
                    });
                  },
                ),
                Text(
                  '${_currentIndex + 1}/${questions.length}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.deepOrangeAccent),
                  onPressed: () {
                    setState(() {
                      if (_currentIndex < questions.length - 1) {
                        _currentIndex++;
                        _showAnswer = false;
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flip/flip.dart';
import 'package:flutter/material.dart';
import 'package:flashcard_quiz/AppCubit/cubit.dart';
import 'package:flashcard_quiz/Screens/QuizScoresPage.dart';
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
  FlipController flipController = FlipController();

  @override
  void initState() {
    setState(() {
      LayoutCubit.get(context).testName = widget.test.title!;
      LayoutCubit.get(context).getScores(LayoutCubit.get(context).testName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> questions = widget.test.questions ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.test.title ?? 'Quiz',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.scoreboard_rounded,
              size: 40,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizScoresPage()),
              );
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
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Question ${_currentIndex + 1}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrangeAccent),
            ),
            SizedBox(height: 10),
            Text(
              '${questions[_currentIndex]['question']}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrangeAccent),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  flipController.isFront = _showAnswer;
                  _showAnswer = !_showAnswer;
                });
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 32,
                  height: 150,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Flip(
                    firstChild: Container(
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
                      child: Center(
                        child: Text(
                          'Tap to see the answer',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    secondChild: Container(
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
                      child: Center(
                        child: Text(
                          questions.isNotEmpty
                              ? questions[_currentIndex]['answer'] ?? 'No answer available'
                              : 'No answer available',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    controller: flipController,
                    flipDirection: Axis.horizontal,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                      color: Colors.deepOrangeAccent),
                  onPressed: () {
                    setState(() {
                      if (_currentIndex > 0) {
                        _currentIndex--;
                        _showAnswer = false;
                      }
                      flipController.isFront = true;
                    });
                  },
                ),
                Text(
                  '${_currentIndex + 1}/${questions.length}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios,
                      color: Colors.deepOrangeAccent),
                  onPressed: () {
                    setState(() {
                      if (_currentIndex < questions.length - 1) {
                        _currentIndex++;
                        _showAnswer = false;
                      }
                      flipController.isFront = true;
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

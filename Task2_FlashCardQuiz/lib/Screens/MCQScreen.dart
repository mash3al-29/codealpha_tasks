import 'package:flashcard_quiz/AppCubit/cubit.dart';
import 'package:flashcard_quiz/AppCubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Models/TestModel.dart';

class MCQScreen extends StatefulWidget {
  final TestModel test;

  MCQScreen({required this.test});

  @override
  _MCQScreenState createState() => _MCQScreenState();
}

class _MCQScreenState extends State<MCQScreen> {
  int _currentIndex = 0;
  int _score = 0;
  bool _answerSelected = false;
  String? _correctAnswer;
  List<String> _answers = [];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> questions = widget.test.questions ?? [];

    return BlocConsumer<LayoutCubit,Home_States>(
      builder: (BuildContext context, Home_States state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Multiple Choice Quiz',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Question ${_currentIndex + 1}',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            questions.isNotEmpty ? questions[_currentIndex]['question'] ?? 'No question available' : 'No question available',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      ..._buildAnswerButtons(questions[_currentIndex]),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent,
                    ),
                    onPressed: _answerSelected ? () => _goToNextQuestion(questions.length) : null,
                    child: Text(
                      _currentIndex == questions.length - 1 ? 'Submit' : 'Next Question',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Home_States state) {},

    );
  }

  List<Widget> _buildAnswerButtons(Map<String, String>? question) {
    List<Widget> buttons = [];
    if (question != null) {
      _correctAnswer = question['answer'];
      if (!_answerSelected) {
        _answers = _getShuffledAnswers(widget.test, _currentIndex);
      }
      buttons.addAll(_answers.map<Widget>((option) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _answerSelected = true;
                _score += option == _correctAnswer ? 1 : 0;
              });
            },
            style: ElevatedButton.styleFrom(
              primary: _answerSelected ? (option == _correctAnswer ? Colors.green : Colors.red) : Colors.blueGrey,
            ),
            child: Text(
              option,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }));
    }
    return buttons;
  }


  List<String> _getShuffledAnswers(TestModel test, int currentIndex) {
    List<String> answers = [];
    List<Map<String, String>> allQuestions = test.questions ?? [];
    Map<String, String> currentQuestion = allQuestions[currentIndex];
    String? correctAnswer = currentQuestion['answer'];
    for (var question in allQuestions) {
      String? otherAnswers = question['answer'];
      if (otherAnswers != null && otherAnswers != correctAnswer) {
        answers.add(otherAnswers);
      }
    }
    answers.shuffle();
    answers = answers.take(3).toList();
    answers.add(correctAnswer!);
    answers.shuffle();
    return answers;
  }

  void _goToNextQuestion(int totalQuestions) {
    setState(() {
      if (_currentIndex == totalQuestions - 1) {
        LayoutCubit.get(context).addScore('$_score/${widget.test.questions!.length}', widget.test.title!, widget.test.userId!);
        _showResultDialog();
      } else {
        _currentIndex++;
        _answerSelected = false;
        _answers.clear();
      }
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Result'),
          content: Text('Your score: $_score / ${widget.test.questions!.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../AppCubit/cubit.dart';
import '../AppCubit/states.dart';
import '../Models/TestModel.dart';

class EditTestScreen extends StatefulWidget {
  final TestModel test;

  const EditTestScreen({Key? key, required this.test}) : super(key: key);

  @override
  _EditTestScreenState createState() => _EditTestScreenState();
}

class _EditTestScreenState extends State<EditTestScreen> {
  TextEditingController _titleController = TextEditingController();
  List<Map<String, String>> questionAnswers = [];
  List<TextEditingController> _questionControllers = [];
  List<TextEditingController> _answerControllers = [];
  bool isTitleValid = true;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.test.title!;
    questionAnswers.addAll(widget.test.questions!);
    for (int i = 0; i < questionAnswers.length; i++) {
      _questionControllers.add(TextEditingController(
          text: questionAnswers[i]['question'] ?? ''));
      _answerControllers.add(TextEditingController(
          text: questionAnswers[i]['answer'] ?? ''));
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (var controller in _questionControllers) {
      controller.dispose();
    }
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, Home_States>(
      listener: (context, state) {
        if (state is AddTestSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Test updated successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Test', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.blueGrey[900],
            actions: [
              TextButton(
                onPressed: () {
                  _validateAndSave();
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Edit Title', style: TextStyle(color: Colors.white)),
                TextField(
                  controller: _titleController,
                  onChanged: (value) {
                    setState(() {
                      isTitleValid = value.isNotEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey[800],
                    hintText: 'Enter title',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: questionAnswers.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Question ${index + 1}',
                              style: TextStyle(color: Colors.white)),
                          TextField(
                            controller: _questionControllers[index],
                            onChanged: (value) {
                              questionAnswers[index]['question'] = value;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blueGrey[800],
                              hintText: 'Enter question',
                              hintStyle: TextStyle(color: Colors.white70),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text('Answer ${index + 1}',
                              style: TextStyle(color: Colors.white)),
                          TextField(
                            controller: _answerControllers[index],
                            onChanged: (value) {
                              questionAnswers[index]['answer'] = value;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blueGrey[800],
                              hintText: 'Enter answer',
                              hintStyle: TextStyle(color: Colors.white70),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    questionAnswers.removeAt(index);
                                    _questionControllers.removeAt(index);
                                    _answerControllers.removeAt(index);
                                  });
                                },
                                icon: Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addQuestion,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 10),
                      Text('Add Question',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addQuestion() {
    setState(() {
      questionAnswers.add({'question': '', 'answer': ''});
      _questionControllers.add(TextEditingController());
      _answerControllers.add(TextEditingController());
    });
  }

  void _validateAndSave() {
    if (!isTitleValid) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a title.'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    for (int i = 0; i < questionAnswers.length; i++) {
      String question = questionAnswers[i]['question']!;
      String answer = questionAnswers[i]['answer']!;
      if (question.isEmpty || answer.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please fill all questions and answers.'),
          backgroundColor: Colors.red,
        ));
        return;
      }
    }

    TestModel test = TestModel(
      title: _titleController.text,
      questions: questionAnswers,
      userId: LayoutCubit.get(context).usermodel!.uID,
    );
    LayoutCubit.get(context).addTest(test);
  }
}

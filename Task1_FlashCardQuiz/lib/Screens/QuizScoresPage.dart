import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../AppCubit/cubit.dart';
import '../AppCubit/states.dart';

class QuizScoresPage extends StatefulWidget {
  const QuizScoresPage({Key? key}) : super(key: key);

  @override
  State<QuizScoresPage> createState() => _QuizScoresPageState();
}

class _QuizScoresPageState extends State<QuizScoresPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, Home_States>(
      builder: (BuildContext context, Home_States state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Quiz Scores',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(
              color: Colors.grey[300],
            ),
            padding: EdgeInsets.only(left:16.0,right: 16,top: 16),
            itemCount: LayoutCubit.get(context).scores.length,
            itemBuilder: (context, index) {
              final quizNumber = index + 1;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(
                      'Quiz $quizNumber',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    subtitle: Text(
                      'Your Score: ${LayoutCubit.get(context).scores[index]}',
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      listener: (BuildContext context, Home_States state) {},
    );
  }
}

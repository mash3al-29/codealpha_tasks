import 'package:flashcard_quiz/Screens/QuizPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../AppCubit/cubit.dart';
import '../AppCubit/states.dart';
import 'EditTestScreen.dart';
import '../Models/TestModel.dart';
import '../Shared/TestCard.dart';

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
   late List<TestModel> displayedTests = LayoutCubit.get(context).tests!;
  void updateDisplayedTests(String query) {
    if(query.isEmpty){
      displayedTests = LayoutCubit.get(context).tests!;
    }
    setState(() {
      displayedTests = LayoutCubit.get(context)
          .tests!
          .where((test) =>
          test.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, Home_States>(
      builder: (BuildContext context, Home_States state) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[800],
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle:
                        TextStyle(color: Colors.white70),
                        prefixIcon:
                        Icon(Icons.search, color: Colors.white),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        updateDisplayedTests(value);
                      },
                    ),
                  ),
                ),
              ]),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final test = displayedTests[index];
                  return TestItem(
                    test: test,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizPage(test:test)));
                    },
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTestScreen(test: test),
                        ),
                      );
                    },
                    onDelete: () {
                      LayoutCubit.get(context)
                          .deleteTest((test.title)!);
                    },
                  );
                },
                childCount: displayedTests.length,
              ),
            ),
          ],
        );
      },
      listener: (BuildContext context, Home_States state) {},
    );
  }
}

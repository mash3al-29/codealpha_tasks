import 'package:flashcard_quiz/Screens/Add_Main_Test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../AppCubit/cubit.dart';
import '../AppCubit/states.dart';
import '../Models/CreateUserModelFirestore.dart';
import 'HomePageBody.dart';
import 'ProfilePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePageBody(),
    AddTestScreen(),
    ProfilePage(),
  ];

  bool _isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, Home_States>(
      builder: (BuildContext context, Home_States state) {
        String greeting = _getGreeting(LayoutCubit.get(context).usermodel);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              greeting,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blueGrey[900],
          ),
          body: Column(
            children: [
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      setState(() {
                        _isFabVisible = scrollNotification.metrics.pixels <= 0;
                      });
                    }
                    return false;
                  },
                  child: _pages[_selectedIndex],
                ),
              ),
            ],
          ),
          floatingActionButton: _isFabVisible
              ? FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTestScreen()),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.orange,
          )
              : null,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blueGrey[900],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            currentIndex: _selectedIndex,
            onTap: (int index) {
              if (index == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddTestScreen()));
              } else {
                setState(() {
                  _selectedIndex = index;
                });
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add Test',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
      listener: (BuildContext context, Home_States state) {},
    );
  }

  String _getGreeting(CreateUserModelFirestore? userModel) {
    if (userModel != null) {
      if (userModel.name != null) {
        return 'Hello ${userModel.name}';
      } else if (userModel.email != null) {
        return 'Hello ${userModel.email!.split('@')[0]}';
      }
    }
    return 'Hello';
  }
}

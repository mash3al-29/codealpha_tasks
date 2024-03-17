import 'package:firebase_core/firebase_core.dart';
import 'package:flashcard_quiz/AppCubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Screens/HomePage.dart';
import 'Screens/LoginScreen.dart';
import 'Shared/CacheHelper.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LayoutCubit()..getAllTests()..GetUserData(),
      child: MaterialApp(
        title: 'FlashCardQuiz App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blueGrey,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blueGrey[900],
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CacheHelper.GetData(key: 'uID') == null ? LoginPage() : HomePage();
  }
}

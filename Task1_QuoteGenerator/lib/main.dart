import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BlocObserver.dart';
import 'QuoteCubit/cubit.dart';
import 'QuuoteCard.dart';
import 'Theme_Cubit_States.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quote Generator',
      home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context) => QuoteCubit()..getQuote()),
            BlocProvider(create: (BuildContext context) => ThemeCubit()),
          ],
          child: MyHomePage(title: 'Quote Generator')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return QuoteCard();
  }
}

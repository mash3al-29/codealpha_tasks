import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ThemeMode { light, dark }

class ThemeState {
  final ThemeMode themeMode;

  ThemeState(this.themeMode);
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(ThemeMode.light));
  static ThemeCubit get(context) => BlocProvider.of(context);
  String theme = "light";
  void toggleTheme() {
    final newThemeMode;
    if(state.themeMode == ThemeMode.light){
      newThemeMode = ThemeMode.dark;
      theme = "dark";
    }else{
      newThemeMode = ThemeMode.light;
      theme = "light";
    }
    emit(ThemeState(newThemeMode));
  }

}

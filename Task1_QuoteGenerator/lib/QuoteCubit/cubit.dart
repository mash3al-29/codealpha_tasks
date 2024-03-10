import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_generator/QuoteCubit/QuoteStates.dart';

import '../QuoteModel.dart';
import '../config.dart';

class QuoteCubit extends Cubit<Quote_States> {
  QuoteCubit() : super(Initial_State());

  static QuoteCubit get(context) => BlocProvider.of(context);

  QuoteModel quoteModel = QuoteModel();
  String internet = "";

  Future<void> getQuote() async {
    final dio = Dio();
    try {
      final response = await dio.get(
        'https://api.api-ninjas.com/v1/quotes',
        options: Options(
          headers: {
            'X-Api-Key': Config().api_key
          },
        ),
      );
      print(response.toString());
      quoteModel = QuoteModel.fromJson(response.data[0]);
      emit(GenerateQuote());
    } catch (error) {
      print(error.toString());
      emit(QuoteError());
    }
  }

  void isInternet() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        internet = 'yes';
      } else {
        internet = 'no';
      }
    });
  }

  Future<void> emitUpdateState() async {
    emit(Update_Quote());
  }
}
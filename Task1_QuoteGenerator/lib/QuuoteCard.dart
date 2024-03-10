import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_generator/QuoteCubit/QuoteStates.dart';
import 'package:quote_generator/QuoteCubit/cubit.dart';
import 'package:share_plus/share_plus.dart';

import 'Theme_Cubit_States.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocConsumer<QuoteCubit, Quote_States>(
          listener: (context, state) {},
          builder: (context, state) {
            final quoteCubit = QuoteCubit.get(context);
            final theme = ThemeCubit.get(context).theme == "light" ? ThemeData.light() : ThemeData.dark();
            if (state is Initial_State || state is Update_Quote) {
              // Loading state
              return Scaffold(
                backgroundColor: ThemeCubit.get(context).theme == "light" ? theme.cardColor : Color.fromRGBO(33, 33, 33, 1),
                appBar: AppBar(
                  backgroundColor: ThemeCubit.get(context).theme == "light" ?  Color.fromRGBO(200, 180, 255, 1) : Color.fromRGBO(48, 48, 48, 1),
                  title: Text('Quote Generator', style: TextStyle(
                    color: theme.textTheme.bodyMedium!.color,
                  ),),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.lightbulb_outline),
                      color: theme.textTheme.bodyLarge!.color,
                      onPressed: () {
                        BlocProvider.of<ThemeCubit>(context).toggleTheme();
                      },
                    ),
                  ],
                ),
                body: Center(
                  child: CircularProgressIndicator(
                    color: ThemeCubit.get(context).theme == "light" ?  Color.fromRGBO(200, 180, 255, 1) : Color.fromRGBO(48, 48, 48, 1),
                  ),
                ),
              );
            } else if (state is QuoteError || quoteCubit.internet == 'no') {
              // Error state or no internet connection
              return Scaffold(
                backgroundColor: ThemeCubit.get(context).theme == "light" ? theme.cardColor : Color.fromRGBO(33, 33, 33, 1),
                appBar: AppBar(
                  backgroundColor: ThemeCubit.get(context).theme == "light" ?  Color.fromRGBO(200, 180, 255, 1) : Color.fromRGBO(48, 48, 48, 1),
                  title: Text('Quote Generator', style: TextStyle(
                    color: theme.textTheme.bodyMedium!.color,
                  ),),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.lightbulb_outline),
                      color: theme.textTheme.bodyLarge!.color,
                      onPressed: () {
                        BlocProvider.of<ThemeCubit>(context).toggleTheme();
                      },
                    ),
                  ],
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: theme.cardColor,
                    elevation: 4.0,
                    margin: EdgeInsets.all(16.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Error',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: theme.textTheme.bodyMedium!.color,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            "No Internet Connection",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: theme.textTheme.bodyMedium!.color,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: ThemeCubit.get(context).theme == 'dark' ? theme.cardColor : Color.fromRGBO(200, 180, 255, 1), // Light purple color
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 6.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: MaterialButton(
                              elevation: 20.0, // Elevation value
                              onPressed: () {
                                quoteCubit.emitUpdateState();
                                quoteCubit.getQuote();
                              },
                              padding: EdgeInsets.all(16.0), // Increased padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'Try to generate Quote!',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontStyle: FontStyle.italic,
                                  color: theme.textTheme.bodyMedium!.color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                    ],
                  ),
                ),
              );
            } else {
              // Quote loaded successfully
              return Scaffold(
                backgroundColor: ThemeCubit.get(context).theme == "light" ? theme.cardColor : Color.fromRGBO(33, 33, 33, 1),
                appBar: AppBar(
                  backgroundColor: ThemeCubit.get(context).theme == "light" ?  Color.fromRGBO(200, 180, 255, 1) : Color.fromRGBO(48, 48, 48, 1),
                  title: Text('Quote Generator', style: TextStyle(
                    color: theme.textTheme.bodyMedium!.color,
                  ),),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.lightbulb_outline),
                      color: theme.textTheme.bodyLarge!.color,
                      onPressed: () {
                        BlocProvider.of<ThemeCubit>(context).toggleTheme();
                      },
                    ),
                  ],
                ),
                body: Center(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '"${quoteCubit.quoteModel.quote}"',
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: theme.textTheme.bodyLarge!.color,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Author: ${quoteCubit.quoteModel.author}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontStyle: FontStyle.italic,
                                            color: theme.textTheme.bodyMedium!.color,
                                          ),
                                        ),
                                        SizedBox(width: 40,),
                                        Text(
                                          'Category: ${quoteCubit.quoteModel.category}',
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14.0,
                                            color: theme.textTheme.bodyMedium!.color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: ThemeCubit.get(context).theme == 'dark' ? theme.cardColor : Color.fromRGBO(200, 180, 255, 1), // Light purple color
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 6.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: MaterialButton(
                              elevation: 20.0, // Elevation value
                              onPressed: () {
                                QuoteCubit.get(context).getQuote();
                              },
                              padding: EdgeInsets.all(16.0), // Increased padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'Generate a new Quote!',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontStyle: FontStyle.italic,
                                  color: theme.textTheme.bodyMedium!.color,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height:16),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: ThemeCubit.get(context).theme == 'dark' ? theme.cardColor : Color.fromRGBO(200, 180, 255, 1), // Light purple color
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 6.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: MaterialButton(
                              elevation: 20.0, // Elevation value
                              onPressed: () {
                                Share.share('check out this Quote! \n  Quote:${quoteCubit.quoteModel.quote} \n Author:${quoteCubit.quoteModel.author} \n Category:${quoteCubit.quoteModel.category}');
                              },
                              padding: EdgeInsets.all(16.0), // Increased padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'Share with Social media',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontStyle: FontStyle.italic,
                                  color: theme.textTheme.bodyMedium!.color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}

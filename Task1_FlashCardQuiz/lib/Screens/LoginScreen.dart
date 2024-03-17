import 'package:flashcard_quiz/AppCubit/cubit.dart';
import 'package:flashcard_quiz/AppCubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'SignUpScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: BlocConsumer<LayoutCubit,Home_States>(
        builder: (BuildContext context, state) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 80.0),
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Log in to continue',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          validator: (val) =>
                          val!.isEmpty ? 'Email field is required' : null,
                          onSaved: (val) => _email = val,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                          validator: (val) =>
                          val!.isEmpty ? 'Password field is required' : null,
                          onSaved: (val) => _password = val,
                        ),
                        SizedBox(height: 40.0),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              final form = _formKey.currentState;
                              if (form!.validate()) {
                                form.save();
                                LayoutCubit.get(context).signInWithEmailAndPassword(_email!, _password!,context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignUpPage()), (route) => false);
                          },
                          child: Text(
                            'Create an account',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Text(
                          'Or sign in with',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: IconButton(
                      onPressed: () {
                        LayoutCubit.get(context).signUpGoogle(context: context);
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                      ),
                      iconSize: 40.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {  },
      ),
    );
  }
}

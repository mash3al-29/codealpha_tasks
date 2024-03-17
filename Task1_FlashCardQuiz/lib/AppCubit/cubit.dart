import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcard_quiz/AppCubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Models/TestModel.dart';
import '../Screens/HomePage.dart';
import '../Shared/CacheHelper.dart';
import '../Models/CreateUserModelFirestore.dart';
import '../Shared/CustomToast.dart';

class LayoutCubit extends Cubit<Home_States>{

  LayoutCubit() : super(Initial_State());

  static LayoutCubit get(context) => BlocProvider.of(context);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  CreateUserModelFirestore? usermodel = CreateUserModelFirestore();
  List<String> scores = [];
  GoogleSignInAccount? newUser;
  late String testName;
  List<TestModel>? tests = [];

  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> addTest(TestModel test) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        test.userId = userId;
        await FirebaseFirestore.instance.collection('tests').doc(test.title).set(test.toMap()).then((value) {
          getAllTests();
          emit(AddTestSuccess());
        });
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> addScore(String score, String testName, String userId) async {
    try {
      DocumentReference docRef = FirebaseFirestore.instance.collection('tests').doc(testName);
      DocumentSnapshot docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        Map<dynamic,dynamic> data = docSnapshot.data()! as Map<dynamic,dynamic>;
        if (data['userId'] == userId) {
          List<String> scores = List<String>.from(data['scores'] ?? []);
          scores.add(score);
          await docRef.update({'scores': scores});
          int index = tests!.indexWhere((test) => test.title == testName);
          if (index != -1) {
            tests![index].scores = scores;
          }
          emit(AddScoreSuccess());
        } else {
          emit(AddScoreFailure());
        }
      } else {
        emit(AddScoreFailure());
      }
    } catch (error) {
      print('Error adding score: $error');
      emit(AddScoreFailure());
    }
  }

  Future<List<String>> getScores(String testName) async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('tests').doc(testName).get();

      if (docSnapshot.exists) {
        Map<dynamic,dynamic> data = docSnapshot.data()! as Map<dynamic,dynamic>;
        if (data['userId'] == CacheHelper.GetData(key: 'uID')) {
          List<dynamic> scoresData = data['scores'] ?? [];
          scores = scoresData.map((score) => score.toString()).toList();
          return scores;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (error) {
      print('Error retrieving scores: $error');
      return [];
    }
  }


  Future<void> deleteTest(String title) async {
      await FirebaseFirestore.instance.collection('tests').doc(title).delete().then((value) {
        tests!.removeWhere((test) => test.title == title);
        emit(DeleteTestSuccess());
      }).catchError((error){
        print(error.toString());
        emit(DeleteTestFailure());
      });

  }


  Future<void> getAllTests() async {
    tests = [];
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await FirebaseFirestore.instance.collection('tests')
          .where('userId', isEqualTo: userId)
          .get().then((value) {
        value.docs.forEach((DocumentSnapshot<Map<String, dynamic>> document) {
          Map<String, dynamic>? data = document.data()!;
          TestModel testModel = TestModel.fromJson(data);
          tests!.add(testModel);
        });
        emit(GetAllTestsSuccess());
      }).catchError((error) {
        print("Error fetching tests: ${error.toString()}");
      });
    }
  }


  Future<void> signUpWithEmailAndPassword(String email, String password,context) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        UserCreate(email: email,uID: value.user!.uid,name:'UserName');
        CacheHelper.PutData(key: 'uID', value: value.user!.uid);
        CacheHelper.PutData(key: 'google', value: false);
        showToast(message: "Signed Up Succssefully!");
        GetUserData();
        getAllTests();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
      });
      emit(UpdateSignInStatus());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
      emit(UpdateSignInStatus());
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password,context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
          CacheHelper.PutData(key: 'uID', value: value.user!.uid);
          CacheHelper.PutData(key: 'google', value: false);
          GetUserData();
          getAllTests();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
          showToast(message: "Logged In Succssefully!");
      });
      emit(UpdateSignInStatus());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
      emit(UpdateSignInStatus());
    }
  }

  Future<void> UserCreate({
    required String? email,
    required String? uID,
    required String? name
  }) async {
    CreateUserModelFirestore model = CreateUserModelFirestore(
      uID: uID,
      email: email,
      name: name,
    );
    Map<String, dynamic> data = model.ToMap() ?? {};
    FirebaseFirestore.instance.collection('users').doc(uID).set(
      data,
    ).then((value) {
      emit(CreateUserWithDataInFireBaseSuccess());
      GetUserData();
    }).catchError((onError) {
      print(onError.toString());
      emit(CreateUserWithDataInFireBaseError());
    });
  }

  Future<dynamic> signUpGoogle({context})async{

    final googleuser = await googleSignIn.signIn();

    if (googleuser == null) return;
    newUser = googleuser;

    final googleauth = await googleuser.authentication;

    final cred = GoogleAuthProvider.credential(
      accessToken: googleauth.accessToken,
      idToken:  googleauth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(cred).then((value) async{
      CacheHelper.PutData(key: 'uID', value: value.user!.uid);
      CacheHelper.PutData(key: 'google', value: true);
      showToast(message: 'Successfully Signed In!');
      await FirebaseFirestore.instance.collection('users').doc(value.user!.uid).get().then((value2) {
        if(value2.exists == false){
          UserCreate(
            uID: value.user!.uid,
            email: newUser!.email,
            name: newUser!.displayName,
          );
        }else{
          return null;
        }
      }).catchError((onError){
        showToast(message: 'Something Wrong has happened');
      });
      GetUserData().then((value) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
      });
      getAllTests();
    }).catchError((onError){
      print(onError.toString());
      showToast(message: 'Something Wrong has happened');
      signoutGoogle();
    });
    emit(UpdateSignInStatus());
  }

  Future<dynamic> signoutGoogle() async {
    if(CacheHelper.GetData(key: 'google') == true){
      await googleSignIn.disconnect();
    }
    FirebaseAuth.instance.signOut();
    usermodel = null;
    CacheHelper.sharedPreferences?.remove('uID');
    CacheHelper.sharedPreferences?.remove('google');
    emit(UpdateSignInStatus());
  }


  Future<dynamic> GetUserData(){
    emit(GetUserLoading());
    return FirebaseFirestore.instance.collection('users').doc(CacheHelper.GetData(key: 'uID')).get().then((value) {
      usermodel = CreateUserModelFirestore.fromJson(value.data());
      emit(GetUserSuccsess());
    }).catchError((dynamic error){
      usermodel = null;
      print(error.toString());
      emit(GetUserError());
    });
  }


  Future<void> updateUserName(String newName) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({'name': newName}).then((_) {
        usermodel!.name = newName;
        emit(UpdateUserNameSuccess());
      }).catchError((error) {
        print("Error updating user's name: ${error.toString()}");
        emit(UpdateUserNameFailure());
      });
    }
  }

}
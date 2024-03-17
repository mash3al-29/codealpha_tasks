import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codealpha_fitness_tracker_app/models/meal_model.dart';

import '../../models/stopwatch_model.dart';
import '../../models/workout_model.dart';

class FirebaseFunctions {
  //  Meal Functions  //

  static CollectionReference<MealModel> getMealCollection() {
    return FirebaseFirestore.instance
        .collection("Meals")
        .withConverter<MealModel>(
      fromFirestore: (snapshot, _) {
        return MealModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static void addMeal(mealModel) {
    var collection = getMealCollection();
    var docRef = collection.doc();
    mealModel.id = docRef.id;
    docRef.set(mealModel);
  }

  static void deleteMeal(String id) {
    getMealCollection().doc(id).delete();
  }

  // static void editMeal(MealModel meal){
  //   getMealCollection().doc(meal.id).update(meal.toJson());
  // }

  static void deleteMealHistory() async {
    final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    var collection = instance.collection('Meals');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  static Stream<QuerySnapshot<MealModel>> getMeal() {
    return getMealCollection().snapshots();
  }

  //  Workout Functions  //

  static CollectionReference<WorkoutModel> getWorkoutCollection() {
    return FirebaseFirestore.instance
        .collection("Workouts")
        .withConverter<WorkoutModel>(
      fromFirestore: (snapshot, _) {
        return WorkoutModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static void addWorkout(workoutModel) {
    var collection = getWorkoutCollection();
    var docRef = collection.doc();
    workoutModel.id = docRef.id;
    docRef.set(workoutModel);
  }

  static void deleteWorkout(String id) {
    getWorkoutCollection().doc(id).delete();
  }

  // static void editWorkout(WorkoutModel workout){
  //   getWorkoutCollection().doc(workout.id).update(workout.toJson());
  // }

  static void deleteWorkoutHistory() async {
    final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    var collection = instance.collection('Workouts');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  static Stream<QuerySnapshot<WorkoutModel>> getWorkout() {
    return getWorkoutCollection().snapshots();
  }

  //  StopWatch Functions  //

  static CollectionReference<StopWatchModel> getStopWatchCollection() {
    return FirebaseFirestore.instance
        .collection("StopWatch")
        .withConverter<StopWatchModel>(
      fromFirestore: (snapshot, _) {
        return StopWatchModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static void addStopWatch(stopWatchModel) {
    var collection = getStopWatchCollection();
    var docRef = collection.doc();
    stopWatchModel.id = docRef.id;
    docRef.set(stopWatchModel);
  }

  static void deleteStopWatchHistory() async {
    final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    var collection = instance.collection('StopWatch');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  static Stream<QuerySnapshot<StopWatchModel>> getStopWatch() {
    return getStopWatchCollection().orderBy("time").snapshots();
  }
}

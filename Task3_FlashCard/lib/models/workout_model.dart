class WorkoutModel {
  String id;
  String workoutName;
  String workoutComponents;
  String numOfSets;
  String numOfReps;
  int date;

  WorkoutModel(
      {this.id = "",
        required this.workoutName,
        required this.workoutComponents,
        required this.numOfSets,
        required this.numOfReps,
        required this.date,});

  WorkoutModel.fromJson(Map<String, dynamic> json) : this(
    id: json["id"],
    workoutName: json["workoutName"],
    workoutComponents: json["workoutComponents"],
    numOfSets: json["numOfSets"],
    numOfReps: json["numOfReps"],
    date: json["date"],
  );

  Map<String,dynamic> toJson(){
    return {
      "id": id,
      "workoutName": workoutName,
      "workoutComponents": workoutComponents,
      "numOfSets": numOfSets,
      "numOfReps": numOfReps,
      "date": date,
    };
  }
}
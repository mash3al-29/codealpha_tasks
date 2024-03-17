class MealModel {
  String id;
  String mealName;
  String mealComponents;
  int date;

  MealModel(
      {this.id = "",
        required this.mealName,
        required this.mealComponents,
        required this.date,});

  MealModel.fromJson(Map<String, dynamic> json) : this(
    id: json["id"],
    mealName: json["mealName"],
    mealComponents: json["mealComponents"],
    date: json["date"],
  );

  Map<String,dynamic> toJson(){
    return {
      "id": id,
      "mealName": mealName,
      "mealComponents": mealComponents,
      "date": date,
    };
  }
/*MealModel fromJson(Map<String, dynamic> json) {
    return MealModel(
        mealName: json["mealName"],
        mealComponents: json["mealComponents"],
        date: json["date"],
        id: json["id"]);
  }*/
}
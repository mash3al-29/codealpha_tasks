class StopWatchModel {
  String id;
  int time;

  StopWatchModel({
    this.id = "",
    required this.time,
  });

  StopWatchModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          time: json["time"],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "time": time,
    };
  }
}

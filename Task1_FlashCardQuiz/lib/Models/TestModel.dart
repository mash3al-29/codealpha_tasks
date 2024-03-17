
class TestModel {
  String? title;
  String? userId;
  List<Map<String, String>>? questions;
  List<dynamic>? scores;

  TestModel({required this.title, required this.userId, required this.questions,this.scores});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'questions': questions,
      'userId' : userId,
      'scores':scores
    };
  }

  TestModel.fromJson(Map<String, dynamic>? json) {
    title = json!['title'];
    userId = json['userId'];
    if (json['questions'] != null) {
      questions = List<Map<String, String>>.from(json['questions']!.map((x) => Map<String, String>.from(x)));
    } else {
      questions = [];
    }
    if (json['scores'] != null) {
      scores = json['scores'];
    } else {
      questions = [];
    }
  }
}

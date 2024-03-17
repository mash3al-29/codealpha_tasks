class CreateUserModelFirestore{
  String? uID;
  String? email;
  String? name;

  CreateUserModelFirestore({
    this.uID,
    this.email,
    this.name
  });

  CreateUserModelFirestore.fromJson(Map<String,dynamic>? json){
    email = json!['email'];
    uID = json['uID'];
    name = json['name'];
  }

  Map<String,dynamic>? ToMap(){
    return {
      'uID' : uID,
      'email' : email,
      'name' : name,
    };
  }
}
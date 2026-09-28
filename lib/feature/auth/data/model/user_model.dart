class UserModel {
  String? uid;
  String name ;
  String email ;
  UserModel({
    required this.email,
    required this.name,
    this.uid
  });
  factory UserModel.fromMap(Map<String , dynamic> data){
        return UserModel(email: data['email'], name: data['name'], uid: data['uid']);
  }
  Map<String , String> toMap(){
    return {
      'email' : email,
      'uid' : uid!,
      'name' : name
    };
  }
  @override
  String toString() {
    // TODO: implement toString
    return '''email : ${this.email}
name : ${this.name}
''';
  }
}
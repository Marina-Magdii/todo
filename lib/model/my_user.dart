class MyUser{
  static const String collectionName="User";
  String? id;
  String? email;
  String? fullName;
  String? userName;
  MyUser({ this.email, this.fullName, this.id,this.userName});

  MyUser.fromFireStore(Map<String,dynamic>? data){
    id=data?["id"];
    email=data?["email"];
    fullName=data?["fullName"];
    userName=data?["userName"];
  }
  Map<String, dynamic> toFireStore(){
    return {
    "id":id,
    "fullName":fullName,
    "email":email,
      "userName":userName
    };
  }
}
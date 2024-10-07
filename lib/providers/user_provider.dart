import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/my_user.dart';
import 'package:todo_app/model/user_collection.dart';

class UserProvider extends ChangeNotifier{
  User? firebaseAuth;
  MyUser? fireStoreUser;
  void setUsers(User? newfirebaseUser, MyUser? newdbUser){
    fireStoreUser=newdbUser;
    firebaseAuth=newfirebaseUser;
    notifyListeners();
  }
  bool isLoggedin(){
    if(FirebaseAuth.instance.currentUser==null){
      return false;
    }
    else{
      firebaseAuth =FirebaseAuth.instance.currentUser;
      return true;
    }
  }

  Future<void> retrieveFireStoreUser()async{
    fireStoreUser = await UserCollection.getUser(firebaseAuth?.uid??"");
    firebaseAuth=FirebaseAuth.instance.currentUser;
  }
  Future<void> signOut()async{
    fireStoreUser=null;
    firebaseAuth=null;
    return await FirebaseAuth.instance.signOut();
  }
}
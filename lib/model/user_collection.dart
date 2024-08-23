import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/my_user.dart';

class UserCollection{
  static CollectionReference<MyUser> getCollection(){
    var reference =FirebaseFirestore.instance.collection(MyUser.collectionName).withConverter(
        fromFirestore: (snapshot,options) => MyUser.fromFireStore(snapshot.data()),
        toFirestore: (user, options){
          return user.toFireStore();
        });
    return
      reference;
  }
  static Future<void >addUser(String userID,MyUser user)async{

    var document = getCollection().doc(userID);
    await document.set(user);
  }

  static Future<MyUser?> getUser(String userID)async{
    var document=getCollection().doc(userID);
    var snapshot=await document.get();
    MyUser? user =snapshot.data();
    return user;
  }
}
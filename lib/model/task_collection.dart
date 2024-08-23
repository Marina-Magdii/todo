import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/user_collection.dart';

class TaskCollection{
  static CollectionReference <Task> getTaskCollection(String userId){
    var userCollection=UserCollection.getCollection();
    var userDoc=userCollection.doc(userId);
    var taskCollection=userDoc.collection(Task.collectionName).withConverter(
        fromFirestore: (snapshot, options) => Task.fromFireStore(snapshot.data()),
        toFirestore: (task, options) => task.toFireStore());
    return taskCollection;
  }
  static Future<void> createTask(Task task, String userId)async{
    var collection =getTaskCollection(userId);
    var doc=collection.doc();
    task.id=doc.id;
    await doc.set(task);
  }
  static Future<List<Task>> getTasks(String userId)async{
    var collectionRef = getTaskCollection(userId);
    var snapshot = await collectionRef.get();
    List<Task> tasks = snapshot.docs.map((snapshot) => snapshot.data()).toList();
    return tasks;
  }
}
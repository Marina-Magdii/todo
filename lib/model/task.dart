import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/task_collection.dart';

import '../providers/todo_provider.dart';
import '../providers/user_provider.dart';

class Task{
  static const String collectionName="Tasks";
  String? id;
  String? title;
  String? description;
  Timestamp? date;
  bool isDone=false;
  Task({this.id,this.date,this.description,this.isDone=false,this.title});
  Task.fromFireStore(Map<String , dynamic>? data){
    id=data?["id"];
    title=data?["title"];
    description=data?["description"];
    date=data?["date"];
    isDone=data?["isDone"];
  }

  Map <String,dynamic> toFireStore(){
    return {
      "id":id,
      "description":description,
      "date":date,
      "isDone":isDone,
      "title":title
    };

  }

}
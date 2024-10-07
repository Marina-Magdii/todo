import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/task_collection.dart';

class TodoProvider extends ChangeNotifier {
  List<Task> tasks = [];
  bool isTasksLoading = false;
  String tasksError = "";
  refreshTasks(String uid) async {
    try {
      var firebaseAuth;
      isTasksLoading = true;
      notifyListeners();
      tasks = await TaskCollection.getTasks(uid);
      tasksError = "";
      isTasksLoading = false;
    } catch (error) {
      tasksError = error.toString();
    }
  }
}

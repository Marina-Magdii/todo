import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/task_collection.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/style/reusable%20components/todo_widget.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider provider= Provider.of<UserProvider>(context);
    return FutureBuilder(
        future: TaskCollection.getTasks(provider.firebaseAuth!.uid),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          List<Task>tasks=snapshot.data??[];
          return  ListView.separated(
              itemBuilder: (context, index) => ToDoWidget(task: tasks[index],),
              separatorBuilder: (context, index) {
                return const SizedBox(height: 5,);
              },
              itemCount: tasks.length);
        });
  }
}

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
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return StreamBuilder(
        stream: TaskCollection.newGetTasks(userProvider.firebaseAuth!.uid),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child:  CircularProgressIndicator(),);
          }
          else if (snapshot.hasError){
            return Center(child: Text(snapshot.error!.toString()));
          }
          else
            {
              List<Task>tasks=snapshot.data??[];
              return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ToDoWidget(task: tasks[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: tasks.length),
            );}
        });
  }
}

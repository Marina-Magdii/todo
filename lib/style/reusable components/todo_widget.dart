import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/task_collection.dart';
import 'package:todo_app/providers/edit_controller.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/style/dialog_utils.dart';
import 'package:todo_app/style/reusable%20components/text_form_field.dart';

class ToDoWidget extends StatefulWidget {

  Task task;
  ToDoWidget({super.key, required this.task});
  @override
  State<ToDoWidget> createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {
  TextEditingController taskController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        editTask();
      },
      child: Slidable(
        startActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                onPressed: (context) {
                  deleteTask();
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20, right: 20),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: isDone
                              ? Colors.green
                              : Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(20)),
                      width: 6,
                      height: double.infinity,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.task.title ?? "",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: isDone
                                      ? Colors.green
                                      : Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.task.description ?? "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 30,
                                ),
                                Text(
                                  "10:30",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    isDone
                        ? const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "Done!",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              onPressed: () {
                                isDone = true;
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.check,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  deleteTask() {
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    DialogUtils.showConfirmDialog(
        context: context,
        msg: "Are you sure you want to delete this task?",
        negativeonTap: () {
          Navigator.pop(context);
        },
        positiveonTap: () async {
          Navigator.pop(context);
          DialogUtils.showLoginDialog(context: context);
          await Task.deleteTask(
              provider.firebaseAuth!.uid, widget.task.id ?? "");
          Navigator.pop(context);
        });
  }

  editTask() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Edit task",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  MyTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Title cannot be empty";
                        }
                        return null;
                      },
                      text: "This is title",
                      controller: taskController),
                  MyTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Description cannot be empty";
                        }
                        return null;
                      },
                      text: "Task description",
                      controller: descriptionController),
                  const SizedBox(
                    height: 5,
                  ),
                  const Padding(
                    padding:  EdgeInsets.all(20.0),
                    child:  Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Select date",
                          style: TextStyle(fontSize: 25),
                        )),
                  ),
                  InkWell(
                    onTap: (){
                      showCalender();
                    },
                    child: Text(
                      "${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: () {
                        saveChanges( );
                      },
                      child: const Text(
                        "Save changes",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ),
          );
        });
    setState(() {});
  }

  showCalender() async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (newDate != null) {
      selectedDate = newDate;
      setState(() {});
    }
  }

  saveChanges(){if(formKey.currentState?.validate()??false){
    Navigator.pop(context);
    UserProvider userProvider=Provider.of<UserProvider>(context);
    EditProvider provider = Provider.of<EditProvider>(context, listen: false);
    provider.descriptionController=descriptionController;
    provider.titleController=taskController;
    TaskCollection.createTask(Task(id:FirebaseAuth.instance.currentUser!.uid,
    title: provider.titleController.text,
    date: Timestamp.fromMillisecondsSinceEpoch(selectedDate.millisecondsSinceEpoch),
    description: provider.descriptionController.text,
    isDone: false), FirebaseAuth.instance.currentUser!.uid);
    Navigator.pop(context);
    userProvider.refreshTasks();
    setState(() {
    });
  }

  }
}

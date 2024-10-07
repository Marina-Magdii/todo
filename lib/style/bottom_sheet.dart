import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/task_collection.dart';
import 'package:todo_app/providers/edit_controller.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/style/dialog_utils.dart';
import 'package:todo_app/style/reusable%20components/text_form_field.dart';

class TaskSheet extends StatefulWidget {
  TaskSheet({super.key});

  @override
  State<TaskSheet> createState() => _TaskSheetState();

}

class _TaskSheetState extends State<TaskSheet> {
  TextEditingController taskController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    EditProvider provider=Provider.of<EditProvider>(context);
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Add New Task",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              const SizedBox(height: 20),
              MyTextField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Title can't be empty";
                    }
                    return null;
                  },
                  text: "Title",
                  controller: provider.titleController),
              MyTextField(
                  keyboard: TextInputType.multiline,
                  lines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description can't be empty";
                    }
                    return null;
                  },
                  text: "Description",
                  controller:provider.descriptionController),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Date",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              InkWell(
                onTap: () {
                  showCalender();
                },
                child: Text(
                  "${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}",
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        addTask();
                      },
                      child: const Text("Send")))
            ],
          ),
        ),
      ),
    );
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

  addTask() async {
    TodoProvider todoProvider = Provider.of<TodoProvider>(context,listen: false);
    DialogUtils.showLoginDialog(context: context);
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    if (formKey.currentState?.validate() ?? false) {
      await TaskCollection.createTask(
          Task(
              title: taskController.text,
              description: descriptionController.text,
              date: Timestamp.fromMillisecondsSinceEpoch(
                  selectedDate.millisecondsSinceEpoch)),
          provider.firebaseAuth!.uid);

      Navigator.pop(context);

      DialogUtils.showMsgDialog(
          context: context,
          msg: "Task created successfully",
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          });
      todoProvider.refreshTasks(provider.firebaseAuth!.uid);
    }
  }
}

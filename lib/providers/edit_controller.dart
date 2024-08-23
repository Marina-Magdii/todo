import 'package:flutter/material.dart';

class EditProvider extends ChangeNotifier{
   TextEditingController titleController=TextEditingController();
   TextEditingController descriptionController=TextEditingController();
   editTask(TextEditingController title, TextEditingController descrip){
     titleController=title;
     descriptionController=descrip;
     notifyListeners();
   }
}
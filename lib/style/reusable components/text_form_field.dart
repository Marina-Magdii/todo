import 'package:flutter/material.dart';
import 'package:todo_app/App%20Style/app_style.dart';
typedef  Validation=String? Function(String?);
class MyTextField extends StatefulWidget {
  MyTextField({
    required this.validator,
      this.isPass=false,
      this.action = TextInputAction.next,
      super.key,
     this.lines=1,
      required this.text,
      this.keyboard = TextInputType.text,
    required this.controller
      });
  String text;
  TextInputType keyboard;
  TextInputAction action;
  bool isPass;
  int lines;
  Validation validator;
  TextEditingController controller;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isObscured=true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        maxLines: widget.lines,
        minLines: widget.lines,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.isPass?isObscured:false,
        keyboardType: widget.keyboard,
        decoration: InputDecoration(
            suffixIcon: widget.isPass?IconButton(
              onPressed: () {
                setState(() {
                  isObscured=!isObscured;
                });
              },
              icon: Icon(
                isObscured?
                Icons.visibility_off_outlined:
                Icons.visibility,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              ),
            ):null,
            labelText: widget.text,
            labelStyle: const TextStyle(fontSize: 25,
            color: Colors.black)),
      ),
    );
  }
}
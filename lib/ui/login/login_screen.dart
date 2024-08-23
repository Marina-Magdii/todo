import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase/firebase_error_codes.dart';
import 'package:todo_app/model/my_user.dart';
import 'package:todo_app/model/user_collection.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/style/constants.dart';
import 'package:todo_app/style/dialog_utils.dart';
import 'package:todo_app/style/reusable%20components/text_form_field.dart';
import 'package:todo_app/ui/home/home_screen.dart';
import 'package:todo_app/ui/register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "Login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/Images/SIGN IN – 1.jpg"))),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Login",
            style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextField(
                text: "Email",
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                  if (!isValidEmail(value)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
              MyTextField(
                isPass: true,
                text: "Password",
                controller: passController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  if (value.length < 6) {
                    return "Please enter at least 6 characters";
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        login();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_right_alt_outlined,
                            color: Colors.white,
                            size: 30,
                          )
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    child: const Text("Create a new account?")),
              )
            ],
          ),
        ),
      ),
    );
  }

  login() async {
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    if (formKey.currentState?.validate() ?? false) {
      try {
        DialogUtils.showLoginDialog(context: context);
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passController.text);
        MyUser? user = await UserCollection.getUser(credential.user?.uid ?? "");
        provider.setUsers(credential.user, user);
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == userNotFound) {
          DialogUtils.showMsgDialog(
              context: context,
              msg: 'No user found for that email.',
              onTap: () {
                Navigator.pop(context);
              });
        } else if (e.code == wrongPass) {
          DialogUtils.showMsgDialog(
              context: context,
              msg: 'Wrong password provided for that user.',
              onTap: () {
                Navigator.pop(context);
              });
        }
      }
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase/firebase_error_codes.dart';
import 'package:todo_app/model/my_user.dart';
import 'package:todo_app/model/user_collection.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/style/dialog_utils.dart';
import 'package:todo_app/style/reusable%20components/text_form_field.dart';
import 'package:todo_app/ui/home/home_screen.dart';

import '../../style/constants.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "Register";
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController nameController = TextEditingController();

  TextEditingController userController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  TextEditingController passConfirmController = TextEditingController();

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
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            "Create Account",
            style: TextStyle(
                fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextField(
                    controller: nameController,
                    text: "Full Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  MyTextField(
                    controller: userController,
                    text: "User Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your user name";
                      }
                      return null;
                    },
                  ),
                  MyTextField(
                    controller: emailController,
                    text: "Email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!isValidEmail(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    keyboard: TextInputType.emailAddress,
                  ),
                  MyTextField(
                    controller: passController,
                    text: "Password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      if (value.length < 6) {
                        return "Please enter at least 6 characters";
                      }
                      return null;
                    },
                    isPass: true,
                  ),
                  MyTextField(
                    controller: passConfirmController,
                    text: "Password Confirmation",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      if (value != passController.text) {
                        return "Passwords don't match";
                      }
                      return null;
                    },
                    action: TextInputAction.done,
                    isPass: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary),
                          onPressed: () {
                            createAccount();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Create My Account",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                              Icon(
                                Icons.arrow_right_alt,
                                color: Colors.white,
                                size: 30,
                              )
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  createAccount() async {
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    if (formKey.currentState?.validate() ?? false) {
      try {
        DialogUtils.showLoginDialog(context: context);
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text,
        );
        MyUser user=MyUser(
          id: credential.user?.uid??"",
          email: emailController.text.trim(),
          fullName: nameController.text,
          userName: userController.text,
        );
        await UserCollection.addUser(
            credential.user!.uid,user);
        Navigator.pop(context);
        DialogUtils.showMsgDialog(
            context: context,
            msg: "Account created successfully ${credential.user?.email}",
            onTap: () {
              Navigator.pop(context);
              provider.setUsers(
                  credential.user,
                  MyUser(email: emailController.text,
                      fullName: nameController.text,
                      userName: userController.text,
                      id: credential.user!.uid),
                  );
              Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route)=>false);
            });
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == weakpass) {
          Navigator.pop(context);
          DialogUtils.showMsgDialog(
              context: context,
              msg: 'The password provided is too weak.',
              onTap: () {
                Navigator.pop(context);
              });
        } else if (e.code == usedEmail) {
          Navigator.pop(context);
          DialogUtils.showMsgDialog(
              context: context,
              msg: 'The account already exists for that email.',
              onTap: () {
                Navigator.pop(context);
              });
        }
      } catch (e) {
        Navigator.pop(context);
        DialogUtils.showMsgDialog(
            context: context,
            msg: "${e.toString()}",
            onTap: () {
              Navigator.pop(context);
            });
      }
    }
  }
}

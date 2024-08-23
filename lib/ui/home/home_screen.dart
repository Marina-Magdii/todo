import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/App%20Style/app_style.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/style/bottom_sheet.dart';
import 'package:todo_app/ui/home/tabs/settings_tab.dart';
import 'package:todo_app/ui/home/tabs/tasks_tab.dart';
import 'package:todo_app/ui/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName="Home";
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   List<Widget>tabs=[Tasks(),Settings()];

   int index=0;

  @override
  Widget build(BuildContext context) {
    UserProvider provider =Provider.of<UserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
             FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName,(route)=>false);
          }, icon: const Icon(Icons.exit_to_app))
        ],
        title: const Padding(
          padding:  EdgeInsets.all(20.0),
          child:  Text("ToDo List"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add,
        color: Colors.white,),
        onPressed: (){
          addTaskSheet();
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        notchMargin: 15,
        child: BottomNavigationBar(
          onTap: (newIndex){
            index=newIndex;
            setState(() {
            });
          },
          currentIndex: index,
          elevation: 0,
          iconSize: 40,
          backgroundColor: Colors.transparent,
          items: const[
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: ""
            ),
            BottomNavigationBarItem(icon: Icon(Icons.settings),
            label: "")
          ],
        ),
      ),
      body: tabs[index]
    );
  }
  addTaskSheet(){
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (context)=>TaskSheet());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/App%20Style/app_style.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/ui/home/home_screen.dart';
import 'package:todo_app/ui/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "Splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async{
      await CheckLogin();
    });
    return  Scaffold(
      backgroundColor: AppStyle.bgColor,
      body: Center(
        child: const Image(image: AssetImage("assets/Images/logo.png"))
            .animate()
            .fade(duration: const Duration(seconds: 2),
        begin: 0,
        end: 1),
      ),
    );
  }

  Future<void>CheckLogin() async {
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    if (provider.isLoggedin()) {
      await provider.retrieveFireStoreUser();
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }
}

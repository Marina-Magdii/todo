import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/App%20Style/app_style.dart';
import 'package:todo_app/fcn.dart';
import 'package:todo_app/providers/edit_controller.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/ui/splash/splash_screen.dart';
import 'package:todo_app/ui/home/home_screen.dart';
import 'package:todo_app/ui/login/login_screen.dart';
import 'package:todo_app/ui/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';

void main ()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( 
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_)=>UserProvider()),
        ChangeNotifierProvider(create: (_)=>EditProvider()),
      ],
      child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppStyle.lightTheme,
      routes: {
        LoginScreen.routeName:(_)=>LoginScreen(),
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        HomeScreen.routeName:(_)=>HomeScreen(),
        SplashScreen.routeName:(_)=>const SplashScreen()

      },
      initialRoute: SplashScreen.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:blogapp/views/home_page.dart';
import 'package:blogapp/views/login_page.dart';
import 'package:blogapp/views/profile-page.dart';
import 'package:blogapp/views/signup_page.dart';
import 'package:blogapp/views/splash-screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: "AIzaSyC47z9S0iNVLsA-P1FpaMJgdQw1K44UBpw",
          appId: "1:888594016477:android:e1f9e40fc43c3a76255334",
          messagingSenderId: "888594016477",
          projectId: "blogapp-7cf06")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: "splashscreen",
      routes: {
        "loginpage":(context)=>LoginPage(),
        "profilepage":(context)=>ProfilePage(),
        "signuppage":(context)=> SignUpPage(),
        "Homepage":(context)=>Homepage(),
        "splashscreen":(context)=>SplashScreen(),
      }


    );
  }
}



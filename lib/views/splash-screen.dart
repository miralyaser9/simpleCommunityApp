import 'dart:async';

import 'package:blogapp/views/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    super.initState();
    Timer(const Duration(seconds: 4),(){
      Get.to(LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(child:
          ClipRRect(borderRadius: BorderRadius.circular(80),
              child: Lottie.asset("lib/images/Animation.json"))),
        ),
      ),

    );
  }
}
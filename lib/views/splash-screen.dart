import 'dart:async';

import 'package:blogapp/views/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


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
              child: Image.network(
                  'https://cdn.dribbble.com/users/239075/screenshots/6076217/media/3c1ddca9e932e103aa8df2790925fd79.gif'))),
        ),
      ),

    );
  }
}
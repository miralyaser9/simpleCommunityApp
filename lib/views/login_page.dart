import 'package:blogapp/controllers/post_controller.dart';
import 'package:blogapp/views/home_page.dart';
import 'package:blogapp/views/reset_pass.dart';
import 'package:blogapp/views/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as prefix;
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helpers/auth_help.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthenticationHelper auth = AuthenticationHelper();
  PostController postController=Get.put(PostController());
  GlobalKey<FormState> formKey=GlobalKey();
  String? email;
  String? pass;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      final double screenWidth = MediaQuery.of(context).size.width;
      final double screenHeight = MediaQuery.of(context).size.height;
      return prefix.Scaffold(


        body: Container(decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill,
            image: NetworkImage
              ("https://e0.pxfuel.com/wallpapers/182/4/desktop-wallpaper-white-and-blue-group-simple-background-design-simple-white.jpg")
        )),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [


                   SizedBox(height: screenHeight*0.1,),
                  const Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Login",style: TextStyle(fontSize: 35,color: Colors.black,fontWeight: FontWeight.bold),),
                    ],
                  )
                  ,  SizedBox(height: screenHeight*0.1,)
                  ,TextFormField( validator: (data){
                    if(data!.isEmpty){
                      return "this field is required";
                    }
                  },
                    onChanged: (value){
                      email=value;
                    }

                    ,decoration: InputDecoration(
                        labelText: "Email"
                        ,hintText: "enter your email",
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(15)
                        ),
                        prefixIcon: Icon(Icons.mail,color: Colors.blue,)
                        ,focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(16)
                    )
                    ),



                  ),
                  const SizedBox(height: 20,),
                  Obx(()=>
                      TextFormField(
                        validator: (data){
                          if(data!.isEmpty){
                            return "this field is required";
                          }
                        },
                        obscureText:postController.isVisible.value ,

                        decoration: InputDecoration(hintText: "enter your password",
                            labelText: "Password"
                            ,
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(15)
                            ),
                            prefixIcon: Icon(Icons.lock,color: Colors.blue,)
                            ,suffixIcon: IconButton(onPressed: () { postController.passVisible();

                            }
                              ,icon: Icon(postController.isVisible.value?Icons.visibility_off:Icons.visibility),


                            )
                            ,focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(16)
                            )
                        ),
                        onChanged: (value){
                          pass=value;
                        }
                        ,

                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 250),
                    child: TextButton(onPressed: (){
                      Get.to(ResetPass());

                    }, child:  Text("Reset password?",style:
                    TextStyle(fontSize:screenWidth*0.03,decoration: TextDecoration.underline,color: Colors.black),)
                    ),
                  )
                  ,const SizedBox(height: 30,
                  )
                  ,Center(child:
                  InkWell(onTap: ()async{

                    if(formKey.currentState!.validate()){

                      try {
                        await auth.signIn(email: email!, password: pass!);
                        Get.snackbar("note", "Success!");
                        Get.to(Homepage());

                      } on FirebaseAuthException catch (e) {
                        AuthStatus status;
                        switch (e.code) {

                          case "invalid-email":
                            status = AuthStatus.invalidEmail;
                            Get.snackbar("note", "${status}");

                            break;
                          case "wrong-password":
                            status = AuthStatus.wrongPassword;
                            Get.snackbar("note", "${status}");
                            break;
                          case "weak-password":
                            status = AuthStatus.weakPassword;
                            Get.snackbar("note", "${status}");
                            break;
                          case "email-already-in-use":
                            status = AuthStatus.emailAlreadyExists;
                            Get.snackbar("note", "${status}");
                            break;
                          default:
                            status = AuthStatus.unknown;
                            Get.snackbar("note", "${status}");
                        }
                      }

                      catch (e) {
                        print(e);
                      }
                    }
                  },
                    child: Container(width: 150,
                      decoration: BoxDecoration(color: Colors.black,
                        borderRadius: BorderRadius.circular(16)
                          ,
                      ),
                      child: const Center(
                        child: Text("Login",style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,fontSize: 25),),
                      ),
                    ),
                  )
                  ),
                  const SizedBox(height: 20,),
                  GestureDetector(onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },child: const Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Do not have account?",style: TextStyle(fontSize: 20,decorationStyle: TextDecorationStyle.dashed),),
                      Text("sign up",style: TextStyle(fontSize: 20,decorationStyle:
                      TextDecorationStyle.double,color: Colors.black,fontWeight: FontWeight.bold),),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      );
    });
    
  }
}


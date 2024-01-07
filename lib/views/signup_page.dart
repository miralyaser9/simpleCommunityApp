import 'package:blogapp/controllers/post_controller.dart';
import 'package:blogapp/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helpers/auth_help.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}
class _SignUpPageState extends State<SignUpPage> {
  PostController postController=Get.put(PostController());
  AuthenticationHelper auth = AuthenticationHelper();

  String? email;

  bool isVisible=true;

  String? pass;
  GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return
      LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
      final double screenWidth = MediaQuery.of(context).size.width;
      final double screenHeight = MediaQuery.of(context).size.height;

      return Scaffold(

        body: Container(decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill,
            image: NetworkImage
              ("https://e0.pxfuel.com/wallpapers/182/4/desktop-wallpaper-white-and-blue-group-simple-background-design-simple-white.jpg")
        )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),

            child:

            Center(
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                     SizedBox(height:screenHeight*0.1,),

                    const Row(
                      children: [
                        Text("Register", style: TextStyle(color: Colors.black,
                            fontSize: 34,
                            fontWeight: FontWeight.bold),),
                      ],
                    )
                    ,
                     SizedBox(height: screenHeight*0.1,),
                    TextFormField(
                      validator: (data){
                        if(data!.isEmpty){
                          return "this field is required";
                        }
                      },

                      decoration:
                      InputDecoration(suffixIcon: Icon(Icons.email),hintText: "Enter an email",labelText: "Email",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),borderSide: BorderSide(color: Colors.blueAccent)
                          ),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.blueAccent)
                          )
                      ),
                      onChanged: (data){
                        email=data;
                      },
                    )

                    ,const SizedBox(height: 20,),
                    Obx(()=>
                        TextFormField(
                          validator: (data){
                            if(data!.isEmpty){
                              return "this field is required";
                            }
                          },
                          onChanged: (data){
                            pass=data;
                          },
                          decoration: InputDecoration(hintText: "enter a password",label: Text("password"),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(15)
                              ),focusedBorder: OutlineInputBorder(borderSide:  BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(15))
                              ,suffixIcon: IconButton(onPressed: (){
                                postController.passVisible();

                              }, icon:Icon( postController.isVisible.value?Icons.visibility_off:Icons.visibility)
                              )
                          ),
                          obscureText: postController.isVisible.value,

                        ),
                    ),
                    const SizedBox(height: 30,),

                    ElevatedButton(onPressed: ()async{
                      if(formKey.currentState!.validate()){
                        try{
                          await auth.signUp(email: email!, password: pass!);

                          Get.snackbar("note", "success register!");
                          Get.to(LoginPage());
                        }
                        on FirebaseAuthException catch (e) {
                          AuthStatus status;
                          switch (e.code) {

                            case "invalid-email":
                              status = AuthStatus.invalidEmail;
                              Get.snackbar("note", "{$status}");

                              break;
                            case "wrong-password":
                              status = AuthStatus.wrongPassword;
                              Get.snackbar("note", "{$status}");
                              break;
                            case "weak-password":
                              status = AuthStatus.weakPassword;
                              Get.snackbar("note", "{$status}");
                              break;
                            case "email-already-in-use":
                              status = AuthStatus.emailAlreadyExists;
                              Get.snackbar("note", "{$status}");
                              break;
                            default:
                              status = AuthStatus.unknown;
                              Get.snackbar("note", "{$status}");
                          }
                        }
                        catch (e) {
                          print(e);
                        }

                      }
                    }

                      , child: Text("Sign up"),style:
                      ButtonStyle(backgroundColor:
                      MaterialStatePropertyAll(Colors.black)),
                    ),


                    const SizedBox(height: 10,),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("already have an account ? ",
                          style: TextStyle(fontSize: 20),),
                        GestureDetector(onTap: () {
                          Get.to(LoginPage());
                        },
                            child: const Text("Login ", style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,)))
                        ,
                      ],)
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

import 'package:blogapp/views/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helpers/auth_help.dart';

class ResetPass extends StatefulWidget {
  ResetPass({Key? key}) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  AuthenticationHelper auth = AuthenticationHelper();
  GlobalKey<FormState> formKey=GlobalKey();

  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("You can reset your password ,please write your email!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.blueAccent),),
                const SizedBox(height: 80,),

               TextFormField(validator: (data){
                 if(data!.isEmpty){
                   return "this field is required";
                 }
               },
                 decoration: InputDecoration(hintText: "enter your email",labelText: "email",
                   enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(16),borderSide: BorderSide(color: Colors.blueAccent)
                   ),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16),
                       borderSide: const BorderSide(color: Colors.blueAccent)
                   ))
                 ,onChanged: (data){
                 email=data;
                 },),
                const SizedBox(height: 20,),
                ElevatedButton(onPressed: ()async{
                  if(formKey.currentState!.validate()){
                    await auth.resetPassword(email: email!);
                    Get.snackbar("note","check your gmail!");
                    Get.to(LoginPage());

                  }

                }
                , child:  const Text("Reset Password"),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)),)
              ],
            ),
          ),
        )
    );
  }
}
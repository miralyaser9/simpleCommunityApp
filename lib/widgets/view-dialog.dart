import 'package:blogapp/helpers/cloud-firestore.dart';
import 'package:blogapp/models/post-model2.dart';
import 'package:blogapp/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

viewDialog(){

  String? title;
  String? body;
  FirebaseAuth U=FirebaseAuth.instance;

  Get.dialog(
    AlertDialog(title: const Text("Create your own post"),
      content: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            MyTextfield(prefixIcon: const Icon(Icons.title),hintText: "write your title",
                labelText: "Title",
                onChangeee: (value){
                  title=value;
                }),
            const SizedBox(height: 20,),
            MyTextfield(prefixIcon: const Icon(Icons.content_paste),hintText: "write the content", labelText: "content",
                onChangeee: (value){
                 body=value;
                })
          ],)
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await CloudFirestoree().addnewPost(
              postt: Post(
                title: title!,
                body: body!,
                userId: U.currentUser!.uid,
              ),
            );

            Get.back();
          },
          child: const Text("Upload"),
        )
      ],
    )
  );
}
import 'package:blogapp/controllers/post_controller.dart';
import 'package:blogapp/models/post_model.dart';
import 'package:blogapp/views/login_page.dart';
import 'package:blogapp/views/profile-page.dart';
import 'package:blogapp/views/single_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helpers/auth_help.dart';

class Homepage extends StatelessWidget {
   Homepage({Key? key}) : super(key: key);

   AuthenticationHelper auth = AuthenticationHelper();

  PostController postController=Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(drawer: Drawer(backgroundColor: Colors.lightBlueAccent,
      child: InkWell(onTap: (){
      Get.to(ProfilePage());
    },
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ListTile(title: Text("My Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),leading: Icon(Icons.person),
          ),
          InkWell(onTap: (){
            Get.dialog(
                AlertDialog(
                  content: const Text("Do you want to leave?"),actions: [
                TextButton(onPressed: (){
                auth.signOut();
                Get.snackbar("note", "Come again later!");
                Get.to(LoginPage());

              }, child: const Text("Yes")),
              TextButton(onPressed: (){
                Get.back();
              }, child: const Text("No")),
            ],));
          },
              child: const ListTile(title: Text("Sign out",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),leading: Icon(Icons.signpost_outlined),))
        ],
      ),
    ),
    ),
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(title: const Text("Community Page",style: TextStyle(color: Colors.blueAccent),),centerTitle: true,backgroundColor: Colors.white,),
    body:
    Obx(() {
      if (postController.isLoading.value==true){
        return const Center(child: CircularProgressIndicator());

      }
      else{
        return ListView.builder(
        itemBuilder: (context, index) {
          return SinglePost(pos: postController.postList[index],);
        },
        itemCount: postController.postList.length,
      );
      }
    }),
    );
  }
}

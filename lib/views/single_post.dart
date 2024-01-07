import 'package:blogapp/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/post_controller.dart';

class SinglePost extends StatelessWidget {
   SinglePost({Key? key, required this.pos}) : super(key: key);

   PostController postController=Get.put(PostController());
  
  final Postmodel pos;
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                children: [
                  const CircleAvatar(backgroundColor: Colors.blue,radius: 20,child: Icon(Icons.person,size: 22,)),
                  const SizedBox(width: 5,),
                  Text(pos.id.toString() ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                ],
              ),
              const SizedBox(height: 20,),
              Text(pos.title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22),)
              ,const SizedBox(height: 20,)
              ,Text(pos.body,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                ,const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  ElevatedButton(onPressed: (){
                    postController.toggleLike();
                  }, child:
                  Row(children: [
                   Obx(() =>  Icon(color:Colors.red,postController.isLiked.value?Icons.favorite:Icons.favorite_border))
                    ,const Text("Like")],),
                  ),
                    ElevatedButton(
                        onPressed: (){
                      Get.dialog(
                          AlertDialog(
                        content:
                        TextFormField(decoration: const InputDecoration(hintText: "write a comment",
                        ),),
                        actions: [TextButton(onPressed: (){
                          Get.back();
                        },
                            child: const Text("send")),
                          TextButton(onPressed: (){Get.back();},
                              child: const Text("close")),
                        ],

                      )
                      );
                    }, child: const Row(children: [Icon(Icons.note_alt_sharp),Text("Comment")],)),
                    ElevatedButton(onPressed: (){}, child: Row(children: [Icon(Icons.share),Text("Share")],))
                  ],),
            ],),
          ),
        ),

    );
  }
}

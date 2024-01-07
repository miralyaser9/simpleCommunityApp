import 'package:blogapp/helpers/cloud-firestore.dart';
import 'package:blogapp/models/post-model2.dart';
import 'package:blogapp/views/single_post.dart';
import 'package:blogapp/widgets/view-dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/post_controller.dart';

class ProfilePage extends StatelessWidget {
   ProfilePage({Key? key}) : super(key: key);
  PostController postController=Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("My Profile"),centerTitle: true,
    ),body:

    StreamBuilder<List<Post>>(

      stream: CloudFirestoree().getPosts()

      ,builder: (context, AsyncSnapshot <List<Post>>snapshot){
        if(snapshot.data==null){
          return const Center(child: CircularProgressIndicator());
        }
        else{
          return ListView.builder(itemCount: snapshot.data!.length,
              itemBuilder: (context,index){
               return Padding(
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
                             Text(snapshot.data![index].userId ,style: TextStyle(fontSize: 12),),
                           ],
                         ),
                         const SizedBox(height: 20,),
                        // Text(snapshot.data![index].createdAt.toString()),
                        // SizedBox(height: 20,),

                         Text(snapshot.data![index].title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
                         ,const SizedBox(height: 20,)
                         ,Text(snapshot.data![index].body,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
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
                                         TextFormField(decoration: InputDecoration(hintText: "write a comment",
                                         ),),
                                         actions: [TextButton(onPressed: (){
                                           Get.back();
                                         },
                                             child: Text("send")),
                                           TextButton(onPressed: (){Get.back();},
                                               child: Text("close")),
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
              });
        }
    },
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          viewDialog();
        }
        ,backgroundColor: Colors.lightBlueAccent,child:
        Icon(Icons.upload),
      ),
    );
  }
}

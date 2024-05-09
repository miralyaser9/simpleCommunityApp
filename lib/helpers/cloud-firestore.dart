import 'package:blogapp/models/post-model2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoree{
  CollectionReference post =FirebaseFirestore.instance.collection('posts');
  FirebaseAuth U=FirebaseAuth.instance;


Future<void> addnewPost({required Post postt})async{
  return post.add({

    'title':postt.title,
    'body':postt.body,
    'userId':U.currentUser!.uid,
    'createdAt':DateTime.now(),
  })
      .then((value) => print("post added"))
      .catchError((error)=>print("failed to add post ${error}"));
}

  Stream<List<Post>> getPosts() {
    return post
        .where('userId', isEqualTo: U.currentUser!.uid)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Post(
          title: doc['title'],
          body: doc['body'],
          userId: doc['userId'],
        );
      }).toList();
    });
  }
}
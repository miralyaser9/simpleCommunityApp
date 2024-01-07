import 'package:blogapp/controllers/remote_service.dart';
import 'package:get/get.dart';

import '../models/post_model.dart';

class PostController extends GetxController{
  final isLoading=true.obs;
  final isLiked=false.obs;
  final isVisible=true.obs;

  var postList=[].obs ;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void passVisible(){
    isVisible.value=!isVisible.value;

  }
  void toggleLike(){
    isLiked.value=!isLiked.value;
  }

  void fetchData() async{
   try{
     isLoading(true);

     var posts= await RemoteServices().getData();
     if(posts!=null){
       postList.value=posts as List<Postmodel> ;

     }

   }
   finally{
     isLoading(false);
   }
  }

}
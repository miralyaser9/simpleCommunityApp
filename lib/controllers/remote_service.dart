import 'package:blogapp/models/post_model.dart';
import 'package:http/http.dart' as http;


class RemoteServices{


  Future<List<Postmodel>> getData() async{

    var response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
     if(response.statusCode==200){
        return postmodelFromJson(response.body);
     }
     return [];
  }
}



import 'dart:convert';

import 'package:facebook_clone_front/features/feed/models/user_model.dart';
import 'package:facebook_clone_front/features/search/models/users_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../constants/api/api.dart';

class UserSearchController extends GetxController{
  Users? searchUsers  ; 

  RxBool loadingSearch = false.obs ;


     Future<void> getUsers(String username) async{
  
   try{
      loadingSearch(true);
     final response = await http.get(Uri.parse('${Api.url.toString()}user/getUserByName?username=$username')
         ,headers: {
           'content-type' : 'application/json',
         }
     );

     if (response.statusCode == 200) {
       var jsonData = json.decode(response.body) ;
       searchUsers = Users.fromJson(jsonData);
       print(searchUsers!.data![0].username);
   
     }

   }catch(err
   ){

     print(err);
   }
   finally{
      loadingSearch(false);
   }
 }
}
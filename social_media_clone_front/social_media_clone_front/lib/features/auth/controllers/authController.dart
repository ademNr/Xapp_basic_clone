


import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:facebook_clone_front/features/bottom_navigation/home_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../constants/api/api.dart';

class AuthController extends GetxController{
  RxBool registerLoading = false.obs ;
  RxBool logInLoading = false.obs ;
  RxString userId = "".obs;
  RxString authResponse = "".obs;

  // register function
  Future<void> register(String username , String email, String password) async{

    try{  
      registerLoading.value= true ;
      var headers = {'content-type' : 'application/json'};
      var url = Uri.parse("${Api.url.toString()}auth/register");
      Map<String,String> body = {
        'username':username,
        'email': email,
        'password':password,

      };
      http.Response response = await http.post(url , body : jsonEncode(body), headers:headers);

      if(response.statusCode == 200){
        final  json  = jsonDecode(response.body);
        var token = json["token"];
        userId.value = json["id"];
     
        authResponse.value = json["message"];
       
        Get.offAll(()=>HomePage());
        print("connected");
        authResponse.value = json["message"];


      }else{
        final  json  = jsonDecode(response.body);
        authResponse.value = json["message"];
       

      }
    }catch(e){
      print(e) ;

    }finally{
      registerLoading.value= false;
    }

}
// login function
Future<void>logIn(String email , String password) async {

  var headers= {'content-type' :'application/json'};
  try{
    var url = Uri.parse("${Api.url.toString()}auth/login");
    Map<String,String> body ={
      'email' : email,
      'password' : password,
    };

    http.Response response = await http.post(url,body:jsonEncode(body), headers: headers);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      var  token = json["token"];
      userId.value = json["id"];
    
      authResponse.value = json["message"];
    

      print("token : "+ token);


      Get.offAll(()=>HomePage());
      print("Connected");
    }else{
      final  json  = jsonDecode(response.body);
      authResponse.value = json["message"];


    }
  }catch(e){

    print(e);

  }
}

}
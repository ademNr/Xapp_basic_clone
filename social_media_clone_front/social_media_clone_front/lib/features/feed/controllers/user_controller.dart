

import 'dart:convert';

import 'package:facebook_clone_front/features/auth/controllers/authController.dart';
import 'package:facebook_clone_front/features/feed/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:facebook_clone_front/constants/api/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController{
RxBool userLoading = false.obs ; 
RxBool postUserLoading = false.obs ; 
User? user ;
User? postUser ;
 
User? commentsUsers ;  

AuthController authController = Get.put(AuthController()); 
  Future<void> getUser() async {

  
  final url = "${Api.url.toString()}user/${authController.userId}";
  final headers = {
    'Content-Type': 'application/json',
  };

  try {
    userLoading(true);
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      user = User.fromJson(data);
      print(user!.email.toString());
    } else {
      print('Failed to load user data: ${response.statusCode}');
    }
  } catch (error) {
    print('Error loading user data: $error');
  }finally{
    userLoading(false);
  }
}
// get user by id 

 Future<User?> getUserByIdPosts(String? userID) async {

  
  final url = "${Api.url.toString()}user/${userID}";
  final headers = {
    'Content-Type': 'application/json',
  };

  try {
    postUserLoading(true);
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      postUser = User.fromJson(data);
      print(postUser?.photo); 
     return User.fromJson(data);
     
    } else {
      print('Failed to load user data: ${response.statusCode}');
    }
  } catch (error) {
    print('Error loading user data: $error');
  }finally{
    postUserLoading(false);
  }
}
// for comments
 Future<User?> getUserByIdComments(String? userID) async {

  
  final url = "${Api.url.toString()}user/${userID}";
  final headers = {
    'Content-Type': 'application/json',
  };

  try {
   
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      commentsUsers = User.fromJson(data);
      print(postUser?.email); 
     return User.fromJson(data);
     
    } else {
      print('Failed to load user data: ${response.statusCode}');
    }
  } catch (error) {
    print('Error loading user data: $error');
  }finally{

  }
}
}
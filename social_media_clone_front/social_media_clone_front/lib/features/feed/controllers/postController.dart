



import 'dart:convert';
import 'dart:io';

import 'package:facebook_clone_front/features/auth/controllers/authController.dart';
import 'package:facebook_clone_front/features/feed/controllers/user_controller.dart';
import 'package:facebook_clone_front/features/feed/models/post_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../../constants/api/api.dart';

class PostController extends GetxController{

  AuthController authController = Get.put(AuthController());
UserController userController = Get.put(UserController()); 
 //
  Posts? userProfilePosts ; 
  //
  Posts? feedPosts;
  RxBool loadingFeedPosts = false.obs ;
//single posts variables
Data? singlePost ; 
RxBool singlePostLoading = false.obs ;
 //
  Posts? allPosts ;
  RxBool loadingAllPosts = false.obs ;
 // 
 RxBool  postCreationLoading = false.obs ; 
 //update post photo
 
     // fetch post by id
     Future<void> fetchSinglePost(String postId) async{
     
   try{
     singlePostLoading (true);
     final response = await http.get(Uri.parse('${Api.url.toString()}post/singlePost/${postId}')
         ,headers: {
           'content-type' : 'application/json',
         }
     );

     if (response.statusCode == 200) {
       var jsonData = json.decode(response.body) ;
       singlePost = Data.fromJson(jsonData);
   
     }

   }catch(err
   ){

     print(err);
   }
   finally{
    singlePostLoading(false);
   }
     }
  //followings posts
 Future<void> fetchFeedPosts() async{
   String userId = authController.userId.value ;
   try{
     loadingFeedPosts(true);
     final response = await http.get(Uri.parse('${Api.url.toString()}post/${userId}')
         ,headers: {
           'content-type' : 'application/json',
         }
     );

     if (response.statusCode == 200) {
       var jsonData = json.decode(response.body) ;
       feedPosts = Posts.fromJson(jsonData);
   
     }

   }catch(err
   ){

     print(err);
   }
   finally{
     loadingFeedPosts(false);
   }
 }




  // all posts
  Future<void> fetchAllPosts() async{
   
    try{
      loadingAllPosts(true);
      final response = await http.get(Uri.parse('${Api.url.toString()}post'),
          headers: {
            'content-type' : 'application/json',
          }
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) ;
        allPosts = Posts.fromJson(jsonData);
     
      }

    }catch(err
    ){

      print(err);
    }
    finally{
      loadingAllPosts(false);
    }
  }
// create post
Future<void> createPost(String post, File? image, String userId, String? userName) async {
  print("image : ${image}"); 
  try {
  
    postCreationLoading.value = true;
  
      var url = Uri.parse('${Api.url.toString()}post');
      var request = http.MultipartRequest('POST', url);
    request.fields['post'] = post;
   

if(image != null ){
final photo = await http.MultipartFile.fromPath('image', image.path); // Adjust MediaType if needed
  request.files.add(photo);
}else if(image== null){
   request.fields['image'] = ""; 
}


   request.fields['userPhoto'] = userController.user?.photo as String ; 
 
    request.fields['userId'] = userId;
    request.fields['userName'] = userName ?? '';

   var response = await request.send();

    if (response.statusCode == 201) {
      print("posted success");
  
    } else {
      print(response.statusCode);
     print('post not added');
    }
  } catch (e) {
    print(e);
  } finally {
    postCreationLoading.value = false;
  }
}



Future<void> updatePostLikes(String? postId, List<String>? oldList ) async {
      final url = Uri.parse('${Api.url.toString()}post/${postId}');
      final headers = {
        'Content-Type': 'application/json'
      };
      oldList?.add(authController.userId.value); 
      final body = json.encode({'likes': oldList });

      try {
        final response = await http.put(url, headers: headers, body: body);

        if (response.statusCode == 200) {
         print('post like updated successfully.');
         

        } else {
          print('Failed to update spins: ${response.statusCode}');
        }
      } catch (e) {
        print('Error updating spins: $e');
      }
    } 
    
    //
    Future<void> removePostLikes(String? postId, List<String>? oldList ) async {
      final url = Uri.parse('${Api.url.toString()}post/${postId}');
      final headers = {
        'Content-Type': 'application/json'
      };
      oldList?.remove(authController.userId.value); 
      final body = json.encode({'likes': oldList });

      try {
        final response = await http.put(url, headers: headers, body: body);

        if (response.statusCode == 200) {
         print('likes updated successfully.');
         

        } else {
          print('Failed to update likes: ${response.statusCode}');
        }
      } catch (e) {
        print('Error updating likes: $e');
      }
    } 

    // 
    Future<void> addComment(String postId, String userId, List<Comments>? comments ,String comment, String? userName, String? userCommentPhoto) async{
      print(comments);
      print(userCommentPhoto); 
      
         final url = Uri.parse('${Api.url.toString()}post/${postId}');
      final headers = {
        'Content-Type': 'application/json'
      };
      
   comments!.add(
    Comments(userCommentId: userId, comment:  comment, commmentUserName: userName,sId: postId , userCommentPhoto: userCommentPhoto)
   );
 
      final body = json.encode({
        'comments': comments, 
        
         });

      try {
        final response = await http.put(url, headers: headers, body: body);

        if (response.statusCode == 200) {
         print('comments updated successfully.');
         

        } else {
          print('Failed to update comment: ${response.statusCode}');
        }
      } catch (e) {
        print('Error updating comment: $e');
      }
    }
    //get follower
    Future<void> getFollowed(String? followedId, String followerId, List<String>? followers ) async {
      final url = Uri.parse('${Api.url.toString()}post/${followedId}');
      final headers = {
        'Content-Type': 'application/json'
      };
      followers!.add(followerId); 
      final body = json.encode({'followers': followers });

      try {
        final response = await http.put(url, headers: headers, body: body);

        if (response.statusCode == 200) {
         print('followers  list updated successfully.');
         

        } else {
          print('Failed to update followers: ${response.statusCode}');
        }
      } catch (e) {
        print('Error updating followers: $e');
      }
    } 
    // get unfollowed 
    Future<void> getUnFollowed(String? followedId, String followerId, List<String>? followers ) async {
      final url = Uri.parse('${Api.url.toString()}post/${followedId}');
      final headers = {
        'Content-Type': 'application/json'
      };
      followers!.remove(followerId); 
      final body = json.encode({'followers': followers });

      try {
        final response = await http.put(url, headers: headers, body: body);

        if (response.statusCode == 200) {
         print('followers  list updated successfully.');
         

        } else {
          print('Failed to update followers: ${response.statusCode}');
        }
      } catch (e) {
        print('Error updating followers: $e');
      }
    } 
    // follow
    Future<void> addFollow(String followedId, String followerId , List<String>? follows) async {
      
      final url = Uri.parse('${Api.url.toString()}user/${followerId}');
      final headers = {
        'Content-Type': 'application/json'
      };
      follows!.add(followedId);
      final body = json.encode({'follows': follows });

      try {
        final response = await http.put(url, headers: headers, body: body);

        if (response.statusCode == 200) {
         print('following added successfully.');
         

        } else {
          print('Failed to follow: ${response.statusCode}');
        }
      } catch (e) {
        print('Error following: $e');
      }
    } 
    // unfollow 
    Future<void> unFollow(String followedId, String followerId , List<String>? follows) async {
      
      final url = Uri.parse('${Api.url.toString()}user/${followerId}');
      final headers = {
        'Content-Type': 'application/json'
      };
      follows!.remove(followedId);
      final body = json.encode({'follows': follows });

      try {
        final response = await http.put(url, headers: headers, body: body);

        if (response.statusCode == 200) {
         print('following added successfully.');
         

        } else {
          print('Failed to follow: ${response.statusCode}');
        }
      } catch (e) {
        print('Error following: $e');
      }
    } 

    // fetch post by id
    }
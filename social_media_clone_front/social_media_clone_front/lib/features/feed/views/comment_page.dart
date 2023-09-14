
import 'dart:io';

import 'package:facebook_clone_front/features/auth/controllers/authController.dart';

import 'package:facebook_clone_front/features/feed/controllers/postController.dart';
import 'package:facebook_clone_front/features/feed/controllers/user_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import '../../bottom_navigation/home_page.dart';

class CommentPage extends StatefulWidget {
  CommentPage({Key? key}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController commentTextController = TextEditingController(); 
  PostController postController = Get.put(PostController()); 
   UserController userController = Get.put(UserController()); 
   AuthController authController = Get.put(AuthController()); 
      final ImagePicker _picker = ImagePicker();
  File? selectedImage;
    Future<void> _importImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
      
    }
  }

  var data= Get.arguments ; 

  Future<void> _takeImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
     
    }
  }
  //
  
   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  bool  addCommentLoading = false ; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
     appBar: AppBar(
      backgroundColor: Colors.black,
      leading:  IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.cancel, color: Colors.white,),), 
      actions: [
       
        IconButton(icon: Icon(Icons.image , color: Colors. blue,), onPressed: (){  showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 120,
                      child: Column(
                        children: [
                         
                          ListTile(
                            leading: Icon(Icons.camera),
                            title: Text("Camera"),
                            onTap: () async{
                            await   _takeImage();
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.image),
                            title: Text("Gallery"),
                            onTap: ()async  {
                             await  _importImage();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );},),
          
         Padding(
          padding: EdgeInsets.all(10),
           child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              
            ),
            onPressed: ()async{
             print(data[1]);
              setState(() {
              addCommentLoading = true ; 
              });
  // String postId, String userId, List<Comments>? comments ,String comment, String userName
   await  postController.addComment(data[2], authController.userId.value, data[1], commentTextController.text,userController.user!.username , userController.user!.photo );
  
                    await postController.fetchAllPosts();
                await postController.fetchFeedPosts();  
      
                setState(() {
                  addCommentLoading = false  ;
                });

                Get.off(()=>HomePage()); 
            },
            child: Text("Respond", style: TextStyle(color: Colors.white),)),
         )
      ],

     ),
     body: SafeArea(
      child:   addCommentLoading? Center(child: CircularProgressIndicator(color: Colors.blue),): 
        SingleChildScrollView(
          child: Column(
            children: [
               Padding(
              padding: EdgeInsets.only(left: 30),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Responding to ",style: TextStyle(color: Colors.grey),),
                                 Text("@${data[0]}", style: TextStyle(color: Colors.blue),),  
                              ],
                            ),
               ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                         userController.user?.photo== null ? 
                Container(
                  width: 50,
                  height: 50,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/assets/profile.png"),
                      fit: BoxFit.fill,
                    ),
                    shape: OvalBorder(),
                  ),
                )
                : 
                Container(
                  width: 50,
                  height: 50,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${userController.user?.photo}"),
                      fit: BoxFit.fill,
                    ),
                    shape: OvalBorder(),
                  ),
                ),
                      SizedBox(width: 10,),
                      Text(
                        '${userController.user!.username}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
              ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 5),
              child: TextFormField(
                maxLines: null,
                controller: commentTextController,
              keyboardType: TextInputType.multiline,
              cursorColor: Colors.blue,
              enabled: true,
             autofocus: true,
              decoration: const InputDecoration(
                hintText: "Respond ?",
                 
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                focusColor: Colors.white,
               border: InputBorder.none,
             
            
              ),
            style: TextStyle(color: Colors.white),
            ),
            ),
             selectedImage == null ? 
           const SizedBox(height: 200,) :
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                height: 200,
                width: MediaQuery.of(context).size.width/1.2,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: FileImage(selectedImage!),
                    fit: BoxFit.fill,
                  ),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
            ),

           
            ],
          ),
        ),
      
      ),
    );
  }
}
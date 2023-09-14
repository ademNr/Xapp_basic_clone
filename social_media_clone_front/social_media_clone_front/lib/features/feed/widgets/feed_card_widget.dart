

import 'package:facebook_clone_front/features/auth/controllers/authController.dart';
import 'package:facebook_clone_front/features/feed/controllers/postController.dart';
import 'package:facebook_clone_front/features/feed/controllers/user_controller.dart';
import 'package:facebook_clone_front/features/feed/models/post_model.dart';
import 'package:facebook_clone_front/features/feed/models/user_model.dart';
import 'package:facebook_clone_front/features/feed/views/comment_page.dart';
import 'package:facebook_clone_front/features/profile/views/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class FeedCard extends StatefulWidget {
  String? userName ; 
  String? createdAt ;
  String? post ; 
  String? image ; 
  String? likes; 
  String? comments ; 
  String? postId  ; 
  List<String>? oldList ; 
  List<Comments>? commentsList ;   

  //
  String? postUserId ; 
  String? userPhoto ; 
  
  
  
  FeedCard({Key? key ,required this.createdAt, this.image, this.post, required this.userName, required this.likes, required this.comments, this.oldList, this.postId, this.commentsList,  required this.postUserId,required this.userPhoto}) : super(key: key);

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {

  PostController postController = Get.put(PostController()); 
  bool heart = false ; 
  bool followed = false ; 
  AuthController authController = Get.put(AuthController()); 

UserController userController  =  Get.put(UserController()); 
User? user ; 
void getUser()async{
  user = await  userController.getUserByIdComments(widget.postUserId);
 

  
}
  @override
  void initState() {
    // TODO: implement initState
getUser(); 
 
 
 
  if(userController.user!.follows!.contains(widget.postUserId)){
   setState(() {
      followed = true ;  
     });
 }
    //
    if(widget.oldList?.contains(authController.userId.value) == true){
     setState(() {
       heart = true ; 
     });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(


      children: [


          //
          Container(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                widget.userPhoto == "" ? 
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
                      image: NetworkImage("${widget.userPhoto}"),
                      fit: BoxFit.fill,
                    ),
                    shape: OvalBorder(),
                  ),
                ),
                SizedBox(width: 10,),
                GestureDetector(
                  
                  onTap: ()async {
                     User? userProfile = await  userController.getUserByIdPosts(widget.postUserId!); 
                    Get.to(()=>ProfilePage(), arguments: userProfile);
                     },
                  child: Text(
                    '${widget.userName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/assets/verified.png", ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                Text(
                  '${widget.createdAt?.substring(0,10)}',
                  style: TextStyle(
                    color: Color(0xFFD7D7D7),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),

              followed ? 
Padding(
                padding: EdgeInsets.all(10),
                child: SizedBox(
                    height: 25,
                    width: 90,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.1 ),
                  
                      ),
                      onPressed: ()async{
                        setState(() {
                          followed = false ; 
                        });
                await  postController.unFollow(widget.postUserId.toString(), authController.userId.value, userController.user?.follows);
                  await postController.getUnFollowed(widget.postUserId.toString(), authController.userId.value, userController.user?.followers); 
                      },
                       child: Text("unfollow", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),),
                      ),
                  ),
              )
              :
              Padding(
                padding: EdgeInsets.all(10),
                child: SizedBox(
                    height: 25,
                    width: 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.99),
                  
                      ),
                      onPressed: ()async{
                        setState(() {
                          followed = true ; 
                        });
                  await  postController.addFollow(widget.postUserId.toString(), authController.userId.value, userController.user?.follows);
                  await postController.getFollowed(widget.postUserId.toString(), authController.userId.value, userController.user?.followers); 
                      },
                       child: Text("follow", style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),),
                      ),
                  ),
              )

               
            
              ],
            ),
          ),
          //
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                '${widget.post}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          //

SizedBox(height: 20,),
   widget.image == "" ? SizedBox() : Container(
              padding: const EdgeInsets.all(5),
              height: 200,
              width: MediaQuery.of(context).size.width/1.2,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage("${widget.image}"),
                  fit: BoxFit.fill,
                ),
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                )
              ),
            ),
  
        Container(
         padding: EdgeInsets.only(right: 50,top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //likes row
              Row(
                children: [

                  GestureDetector(
                    onTap: ()async{
                      setState(() {
                        if(heart== true){
                          heart = false; 
                           int newLikes =int.parse(widget.likes!)-1; 
                          widget.likes = newLikes.toString() ;

                         postController.removePostLikes(widget.postId, widget.oldList); 
                        }
                        else{
                           heart = true; 
                              int newLikes =int.parse(widget.likes!)+1; 
                          widget.likes = newLikes.toString() ;
                         
                            postController.updatePostLikes(widget.postId, widget.oldList); 
                        
                        } 
                      });
                   

                  
                     


                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      child: Image.asset("lib/assets/like.png" ,color: heart  ? Colors.redAccent :  Colors.white,)
                    ),
                  ),
                  Text(
                    '${widget.likes}',
                    style: TextStyle(
                      color: Color(0xFFB3B0B0),
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  )

                ],
              ),
              //comments row
                   SizedBox(width: 20,),
              GestureDetector(
                onTap: (){Get.to(()=> CommentPage(), arguments: [widget.userName, widget.commentsList, widget.postId, widget.userName]);  },
                child: Row(
                  children: [
              
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("lib/assets/comment.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      '${widget.comments}',
                      style: TextStyle(
                        color: Color(0xFFB3B0B0),
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    )
              
                  ],
                ),
              ),
            ],
          ),
        ),
      
        SizedBox(height: 10,),
        Container(height: 1, color : Colors.white10) ,
              
      ],
     
    );
  }
}

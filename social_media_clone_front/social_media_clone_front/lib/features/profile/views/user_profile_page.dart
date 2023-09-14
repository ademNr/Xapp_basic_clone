

import 'package:facebook_clone_front/features/feed/controllers/postController.dart';
import 'package:facebook_clone_front/features/feed/controllers/user_controller.dart';
import 'package:facebook_clone_front/features/feed/widgets/feed_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var data = Get.arguments ; 
    UserController userController = Get.put(UserController()); 
    PostController postController = Get.put(PostController()); 
  @override
  void initState() {

   
    super.initState();
  
 
   

  }




  



  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;


    return Scaffold(
 
     appBar: AppBar(
  
     
    
    scrolledUnderElevation: 0,
    leading : IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){Get.back();},),
    
    backgroundColor: Colors.black,
  
    )
    ,
  
    
      backgroundColor:  Colors.black,
      body:  Column(
       
        children: [
          Stack(
            children: [ 
            
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
      begin: Alignment(0.00, -1.00),
      end: Alignment(0, 0),
      colors: [Colors.blue.withOpacity(0.5), Color(0xff1A2836).withOpacity(0.1),],
      ),
                   
                  ),
              width: double.infinity,
              height: maxHeight*0.2,
              ),
                
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: 
                   data.photo==null
      ? Container(
      width: maxWidth*0.25,
       height: maxWidth*0.25,
      decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color.fromARGB(255, 255, 255, 255),
                      width: 1,
                    ),
                  ),
      child: Image.asset("lib/assets/profile.png",fit: BoxFit.fill,)
      )
      :
                  Container(
                  width: maxWidth*0.25,
                  height: maxWidth*0.25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color.fromARGB(255, 255, 255, 255),
                      width: 1,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      data.photo.toString(),
                      fit: BoxFit.fitWidth,
                    ))
                  
                                    ),
                ),
              ),
            
          ]  ),
     
          Text(
            data.username.toString() ,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
    
      
  
        
          
      
          SizedBox(height:24),
          Container(
            width: maxWidth,
            child: Row(
              children: [
              Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       Padding(padding: EdgeInsets.only(left: 24),
       child: TextButton(
      onPressed: () {
      setState(() {
      _currentContent = ProfileContent.About;
      });
      },
      child: Text(
      'about',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),)
      ),),
      SizedBox(height: 5), // Add space between text button and line
      Container(
      height: 1, // Height of the line
      width: maxWidth*0.5, // Width of the line
      color: _currentContent == ProfileContent.About ?  Colors.blue: Color(0xFF3C3C3C)
      ),
      ],
      ),
      
      SingleChildScrollView(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      TextButton(
      onPressed: () {
      setState(() {
        _currentContent = ProfileContent.InvitedPeople;
      });
      },
      child: Text(
      'posts',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      ),
      ),
      SizedBox(height: 5), // Add space between text button and line
      Container(
      height: 1, // Height of the line
      width: maxWidth*0.5, // Width of the line
      color: _currentContent == ProfileContent.InvitedPeople ? Colors.blue : Color(0xFF3C3C3C)
      ),
      ],
      ),
      ),
      
      
              ],
          
            ),
          ),
          SizedBox(height: 24,),
      
      _currentContent == ProfileContent.About
      ? 
      Padding(
      padding: EdgeInsets.only(left: 24, right: 24),
      child: Column(
        children: [
          Row(
                              children: [
                                Text(
                               'followers ',
                               style: TextStyle(
                               color: Colors.white,
                               fontSize: 16,
                               fontFamily: 'Inter',
                               fontWeight: FontWeight.w600,
                               ),
                               ),
                               SizedBox(width: 5,),
                               Text(
                               data.followers.length.toString(),
                               style: TextStyle(
                               color: Colors.white,
                               fontSize: 16,
                               fontFamily: 'Inter',
                               fontWeight: FontWeight.w300,
                               height: 1.50,
                               ),
                               )
                              ],
                            ) ,
                            SizedBox(height: 10,),
                             Row(
                              children: [
                                Text(
                               'following ',
                               style: TextStyle(
                               color: Colors.white,
                               fontSize: 16,
                               fontFamily: 'Inter',
                               fontWeight: FontWeight.w600,
                               ),
                               ),
                               SizedBox(width: 5,),
                               Text(
                               data.follows.length.toString(),
                               style: TextStyle(
                               color: Colors.white,
                               fontSize: 16,
                               fontFamily: 'Inter',
                               fontWeight: FontWeight.w300,
                               height: 1.50,
                               ),
                               )
                              ],
                            ) ,
                             SizedBox(height: 10,),
                             Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.white, size: 20,),
                        SizedBox(width: 8,),
                        Text(
                       'joined ${data.createdAt.toString().substring(0, 10)}',
                       style: TextStyle(
                       color: Colors.white,
                       fontSize: 16,
                       fontFamily: 'Inter',
                       fontWeight: FontWeight.w300,
                       
                       ),
                       )
                       
                       
                       
                      ]),
                      
        ],
      ),
      )
      : 
       
     Expanded(
                        child: postController.allPosts?.data?.length==0 ? 
                         Center(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("lib/assets/notfound.png", scale: 2,),
                            Text("no posts yet...", style: TextStyle(color: Colors.white),), 
                         
                         ],))
                        :  ListView.builder(
                            
                                      itemCount: postController.allPosts?.data?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        var post  = postController.allPosts?.data?[index];
                                        return 
                                       
                data.sId == postController.allPosts?.data?[index].userId ?     GestureDetector(
                        
                                            
                                  
                                          
                                       
                                          child:  FeedCard(
                                            userName: post?.userName ,
                                             createdAt: post?.createdAt,
                        post: post?.post,
                        likes :  post?.likes?.length.toString() ,
                         comments: post?.comments?.length.toString(),
                         image: post?.image,
                         postId: post?.sId,
                          oldList: post?.likes,
                          commentsList: post?.comments,
                          postUserId: post?.userId.toString(),
                          userPhoto: post?.userPhoto,
                          
                                           
                      
                          ),
                         
                        )
                        :
                        SizedBox();
                         
                                            
                                           
                                        
                          
                                      },
                                     ),
                      ),
         
      
      ],
      ),
     
      );
  }
}

enum ProfileContent {
  About,
  InvitedPeople,
}

ProfileContent _currentContent = ProfileContent.About;
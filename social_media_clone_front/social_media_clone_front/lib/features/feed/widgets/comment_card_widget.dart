import 'package:facebook_clone_front/features/feed/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CommentCardWidget extends StatefulWidget {

  final String? userName ;
  final String? comment ; 
  final String? userId ; 
  final String? postUserName; 
  final String? userCommentPhoto ; 
 
  CommentCardWidget({Key? key, required this.userName, required this.comment, required this.userId, required this.postUserName, required this.userCommentPhoto}) : super(key: key);

  @override
  State<CommentCardWidget> createState() => _CommentCardWidgetState();
}

class _CommentCardWidgetState extends State<CommentCardWidget> {
  UserController userController = Get.put(UserController());
  @override
  void initState() {
    // TODO: implement initState
    userController.getUserByIdComments(widget.userId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


          //
          Container(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               
               
                widget.userCommentPhoto == "" ? 
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
                      image: NetworkImage("${widget.userCommentPhoto}"),
                      fit: BoxFit.fill,
                    ),
                    shape: OvalBorder(),
                  ),
                ),
              
                SizedBox(width: 10,),
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Row(
                  children: [
                      Text(
                  '${widget.userName}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 3,),
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
                  ],
                 ),
                   Row(children: [
                 Row(
                 
                              children: [
                                Text("Responding to ",style: TextStyle(color: Colors.grey),),
                                 Text("@${widget.postUserName}", style: TextStyle(color: Colors.blue),),  
                              ],
                            ),
               ],),
                ],
               ),
                
               
            
               
               
            
              ],
            ),
          ),
           
          //
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                '${widget.comment}',
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

  
        
      
    
        SizedBox(height: 10,),
        Container(height: 1, color : Colors.white10) ,
              
      ],
     
    );
  }
}

import 'package:facebook_clone_front/features/feed/controllers/postController.dart';
import 'package:facebook_clone_front/features/feed/widgets/comment_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/feed_card_widget.dart';

class SinglePostPage extends StatefulWidget {
  SinglePostPage({Key? key}) : super(key: key);

  @override
  State<SinglePostPage> createState() => _SinglePostPageState();
}

class _SinglePostPageState extends State<SinglePostPage> {
  PostController postController = Get.put(PostController()); 
  var data = Get.arguments ; 
  @override
  void initState() {
 postController.fetchSinglePost(data[6]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
           appBar: AppBar(
              backgroundColor: Colors.black,
            leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back, color: Colors.white,),),
           ),

           body: 
                Column(children: [
                  FeedCard(userName: data[0], createdAt: data[1], post: data[2],likes : data[3] , comments: data[4],image: data[5],postId: data[6], oldList: data[7],commentsList: data[8], postUserId: data[9], userPhoto: data[10],),
                  Container(height: 1, color : Colors.white10) ,
                   Expanded(
                     child: ListView.builder(
                         
                                   itemCount: data[8]!.length ??  0, 
                                   itemBuilder: (context, index) {
                               
                                   return GestureDetector(
                                     
                                     child: CommentCardWidget(comment: data[8][index].comment,userName: data[8][index].commmentUserName, userId :  data[8][index].userCommentId, postUserName: data[0], userCommentPhoto: data[8][index].userCommentPhoto)
                                     );
                                 },
                                ),
                   ),
                ],)

    );
  }
}
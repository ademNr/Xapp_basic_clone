
import 'package:facebook_clone_front/features/bottom_navigation/home_page.dart';
import 'package:facebook_clone_front/features/feed/controllers/postController.dart';
import 'package:facebook_clone_front/features/feed/controllers/user_controller.dart';
import 'package:facebook_clone_front/features/feed/views/add_post_page.dart';
import 'package:facebook_clone_front/features/feed/views/single_post_page.dart';
import 'package:facebook_clone_front/features/feed/widgets/feed_card_widget.dart';
import 'package:facebook_clone_front/features/sidebar/sidebar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
   PostController postController = Get.put(PostController()) ; 
   UserController userController = Get.put(UserController()); 
   int tabsCount = 2 ;
   bool showBottomNavigation = false ; 
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKeyAllPosts =
      GlobalKey<RefreshIndicatorState>();
        final GlobalKey<RefreshIndicatorState> _refreshIndicatorKeyFeedPosts =
      GlobalKey<RefreshIndicatorState>();
  Future<void> fetchAllPosts() async {
await postController.fetchAllPosts();
}

Future<void>fetchFeedPosts()async{
  await postController.fetchFeedPosts();
}

@override
void initState() {
// TODO: implement initState
super.initState();
fetchAllPosts();
fetchFeedPosts();
userController.getUser();

}
@override
void dispose() {
// Safe to access postController here because didChangeDependencies() was called before.
postController.dispose();
super.dispose();
}
 final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
      double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      initialIndex: 1,
      length: tabsCount,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black,
        drawer: Drawer(
          child: SideBar(),
        backgroundColor: Color.fromARGB(255, 16, 16, 16)
        ),
        appBar: AppBar(
            leading: GestureDetector(onTap :(){_scaffoldKey.currentState?.openDrawer();} ,child : Image.asset("lib/assets/menu.png")),
          backgroundColor: Colors.black,
          
        
          // The elevation value of the app bar when scroll view has
          // scrolled underneath the app bar.
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          bottom: TabBar(
            
            indicatorColor: Colors.blueAccent,
            labelColor: Colors.blueAccent,


            tabs: <Widget>[
               Tab(
                text: "Follows",
              ),
              Tab(
                text: "For you",
              ),
             
            ],
          ),
        ),
        
        body: TabBarView(
          children: <Widget>[
          
          //----------------------------------------
          GestureDetector(
            onLongPress: (){
              setState(() {
  showBottomNavigation = false ;
});
            },
          
            onVerticalDragCancel: (){
              setState(() {
  showBottomNavigation = true ;
});
            },
           
            child: Obx(
              ()=> postController.loadingFeedPosts.value ?  Center(child: CircularProgressIndicator(color: Colors.blue,),) :
               RefreshIndicator(
                  key:  _refreshIndicatorKeyFeedPosts,
                  onRefresh: ()async{
                   await  postController.fetchFeedPosts();
                  },
                 child:postController.feedPosts?.data?.length == 0 ?ListView(
                  
                  children: [
                  SizedBox(height: 140,),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Image.asset("lib/assets/martina.gif", scale: 2),
                      Text("No posts here Yet...", style: TextStyle(color: Colors.white.withOpacity(0.8))), 
                      ],
                    ),
                  )
                   
                 ]) :  ListView.builder(
             
                  itemCount: postController.feedPosts?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    var post  = postController.feedPosts?.data?[index];
                    return GestureDetector(
                      onTap: (){
                        Get.to(()=>SinglePostPage(), arguments: [
                            post?.userName,
                            post?.createdAt,
                            post?.post,
                            post?.likes?.length.toString(),
                            post?.comments?.length.toString(),
                            post?.image,
                            post?.sId,
                            post?.likes,
                            post?.comments,
                            post?.userId,
                            post?.userPhoto
             
                            
          
          
                        ]);
                      },
                      child: FeedCard(userName: post?.userName , createdAt: post?.createdAt, post: post?.post,likes :  post?.likes?.length.toString() , comments: post?.comments?.length.toString(),image: post?.image,postId: post?.sId, oldList: post?.likes,commentsList: post?.comments, postUserId: post?.userId.toString(),userPhoto: post?.userPhoto,)
                      );
                  },
                 ),
               ),
             ),
          ),
            GestureDetector(
                 onLongPress: (){
              setState(() {
  showBottomNavigation = false ;
});
            },
          
            onVerticalDragCancel: (){
              setState(() {
  showBottomNavigation = true ;
});
            },
              child: Obx(
              ()=> postController.loadingAllPosts.value ?  Center(child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  
                   Image.asset("lib/assets/martina.gif", scale: 2,),
                    Text("No posts here Yet...", style: TextStyle(color: Colors.white.withOpacity(0.8))), 
                   
                 ]),) :
               RefreshIndicator(
                  key:  _refreshIndicatorKeyAllPosts,
                    onRefresh: ()async{
                     await  postController.fetchAllPosts();
                    },
                 child:postController.allPosts?.data?.length ==0 ? Center(child: Image.asset("lib/assets/martina.gif"),):  ListView.builder(
                  
                  itemCount: postController.allPosts?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    var post  = postController.allPosts?.data?[index];
                    return 
                   
                          GestureDetector(
                            onTap: (){  
                        Get.to(()=>SinglePostPage(), arguments: [
                            post?.userName,
                            post?.createdAt,
                            post?.post,
                            post?.likes!.length.toString(),
                            post?.comments!.length.toString(),
                            post?.image,
                            post?.sId,
                            post?.likes,
                            post?.comments!,
            
            
                            post?.userId,
                            post?.userPhoto
                        
                            
                            
            
            
                        ]);
                            
                            
                            }
            ,
              
                      
                   
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
                           
                          ); 
                           
                        
                       
                    
                            
                  },
                 ),
               ),
                       ),
            ),
            
          ],
        ),
      
floatingActionButton: showBottomNavigation == false ? null  :  FloatingActionButton(
  elevation: 50,
  onPressed: (){Get.to(()=>AddPost(), transition: Transition.downToUp);}, 
  child: Icon(Icons.add, color: Colors.white,),
  backgroundColor: Colors.blue,
  shape: CircleBorder(),
),
      ),
    );
  }
}

import 'package:facebook_clone_front/features/feed/controllers/user_controller.dart';
import 'package:facebook_clone_front/features/feed/models/user_model.dart';
import 'package:facebook_clone_front/features/feed/views/single_post_page.dart';
import 'package:facebook_clone_front/features/search/controllers/user_search_controller.dart';
import 'package:facebook_clone_front/features/sidebar/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../profile/views/user_profile_page.dart';


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  UserSearchController userSearchController = Get.put(UserSearchController()); 
    bool  _searchBoolean= false ;
   TextEditingController searchController = TextEditingController();
   UserController userController = Get.put(UserController()); 
   bool enableText = false ;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          
        ),
                  body: Column(
                    children:[
                      SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           
                      Container(
                  width: 300,
                  child:  TextFormField(
                    onChanged: (value)async{
                      await userSearchController.getUsers(value); 
                    },
                    enabled: enableText,
                    autofocus: true,
                                      controller: searchController,
                                     
                                     
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        hintText: 'Search',
                                        hintStyle: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xffF7F9F9).withOpacity(0.5),
                                        ),
                                        filled: true,
                                        fillColor: Color.fromARGB(255, 25, 25, 25),
                                       
                                      ),
                                      style: TextStyle(color: Colors.white),
                                    ),
                ),
                 Container(
                  padding: EdgeInsets.only(left: 0),
                
                  child: _searchBoolean ? null:  IconButton(
                      icon: Icon(Icons.search, size: 30, color: Colors.white,),
                      onPressed: () {

                        setState(() { //add
                          _searchBoolean = true;
                          enableText = true ;
                        });


                      }
                  ),
                ),
                !_searchBoolean ?Text("") :  Container(
                
                  child: IconButton(
                      icon: Icon(Icons.clear, size: 30,color: Colors.white,),
                      onPressed: () {
                        setState(() {
                           searchController.text = "";
                          _searchBoolean = false;
                          enableText = false ;
                        });
                      }
                  ),
                ),
                          ],
                        ),
                      
                 enableText ==false ? Padding(
                  padding: EdgeInsets.only(top: 110),
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("lib/assets/search3.gif", scale:2,),
                                            Text("Search for friends", style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 15)), 
                      
                    
                    ],
                   ),
                 ):       Obx( 
                                ()=>    Expanded(
                                  child: userSearchController.loadingSearch.value ? Center(child:CircularProgressIndicator(color: Colors.blue,),) : ListView.builder(
                    itemCount: userSearchController.searchUsers?.data?.length ?? 0 ,
                    itemBuilder: (context, index) {
                      return Card(
                          child: GestureDetector(
                            onTap: ()async{
                               User? userProfile = await  userController.getUserByIdPosts(userSearchController.searchUsers?.data?[index].sId.toString()); 
                    Get.to(()=>ProfilePage(), arguments: userProfile);  
                            },
                                
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: ListTile(
                                  
                                  tileColor: Colors.black,
                                    title: Text("${userSearchController.searchUsers?.data?[index].username.toString()}" , style: TextStyle(color: Colors.white.withOpacity(0.9),fontSize: 20, fontWeight: FontWeight.bold),),
                                        leading:userSearchController.searchUsers?.data?[index].photo == null ?Image.asset("lib/assets/profile.png") :Container( height: 50, width:50,
                                          child: ClipOval( child: Image.network("${userSearchController.searchUsers?.data?[index].photo}", fit : BoxFit.fill), ))  ,
                                  subtitle: Text("${userSearchController.searchUsers?.data?[index].email.toString()}" ?? "", style: TextStyle(color: Colors.white.withOpacity(0.6), fontWeight: FontWeight.w400, fontSize: 18),),
                                  isThreeLine: true,
                              
                                
                                ),
                              ),
                                
                          )
                      );
                    }
                            ),
                                ),
                            ),
                    ]
                  )
    );
  }
}

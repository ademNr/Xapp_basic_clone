import 'package:facebook_clone_front/features/auth/views/login.dart';
import 'package:facebook_clone_front/features/feed/controllers/user_controller.dart';
import 'package:facebook_clone_front/features/profile/views/my_profile_page.dart';
import 'package:facebook_clone_front/features/sidebar/widgets/infoCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';






class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {




 String currentRoute = Get.currentRoute;
UserController userController = Get.put(UserController()); 

  
bool _isButtonPressed = false;

  void _toggleButton() {
    setState(() {
      _isButtonPressed = !_isButtonPressed;
    });
  }
  @override
  void initState() {
    super.initState();


  }
 String page="";

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        
        child:  Container(
            width: 298,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black12, 
              // Color(0xFF17203A),
              
            ),
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.white),
              child: ListView(
                
                children: [
                 Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white,size: 30,),
                      onPressed: (){
                         Navigator.pop(context); 
                      }
                        
                      
                    ),
                  ],
                ),
              InfoCard(
   
               ),

                 
Padding(
  padding: EdgeInsets.only(left: 24, top: 15, right: 15),
  child: Divider(color: Colors.white24, height: 5),
),

//
Padding(
  padding: EdgeInsets.only(top: 20),
  child:   Row(
  
    mainAxisAlignment: MainAxisAlignment.center,
  
    children: [
  
      Row(children: [
  
        Text("following  ${userController.user?.follows?.length}",style: TextStyle(color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.w400, fontSize: 15))
  
      ],),
  
      SizedBox(width: 40,),
  
       Row(children: [
  
        Text("followers  ${userController.user?.followers?.length}", style: TextStyle(color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.w400, fontSize: 15),)
  
      ],)
  
    ],
  
  ),
),
//
SizedBox(height: 50,),
 GestureDetector(
  onTap: (){
Get.to(()=>MyProfilePage()); 
  },
   child: Padding(
    padding: EdgeInsets.all(20),
     child: Row(
   mainAxisAlignment: MainAxisAlignment.start,
           children: [
           
     Icon(Icons.person, color: Colors.white, ),
     SizedBox(width: 5,),
     Padding(
      padding: EdgeInsets.only(top: 10),
       child: Text(
         'Profile',
         style: TextStyle(
             color: Colors.white,
             fontSize: 20,
             fontFamily: 'Inter',
             fontWeight: FontWeight.w300,
             height: 0.07,
             letterSpacing: -1,
         ),
      ),
     )
       
         
     
             
     
             
     
           ],
     
         ),
   ),
 ),

GestureDetector(
  onTap: (){
    Get.offAll(Signin());
  },
  child:   Container(
  
    height: 42,
  
    margin:  EdgeInsets.only(left: 24, right: 24),
  
    decoration: ShapeDecoration(
  
                color:  Colors.transparent,
  
              shape: RoundedRectangleBorder(
  
                borderRadius: BorderRadius.only(
  
                  topRight: Radius.circular(5),
  
                  bottomRight: Radius.circular(5),
  
                ),
  
              ),),
  
    child:   Row(
  
     
  
  
  
    
  
          children: [
  
          
  
    Icon(Icons.logout, color: Color(0xFFFF666F), ),
  
    SizedBox(width: 5,),
  
    Text(
  
      'Log out',
  
      style: TextStyle(
  
          color: Color(0xFFFF666F),
  
          fontSize: 20,
  
          fontFamily: 'Inter',
  
          fontWeight: FontWeight.w300,
  
          height: 0.07,
  
          letterSpacing: -1,
  
      ),
  
  )
  
      
  
        
  
    
  
            
  
    
  
            
  
    
  
          ],
  
    
  
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



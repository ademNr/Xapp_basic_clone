
import 'package:facebook_clone_front/features/feed/controllers/user_controller.dart';
import 'package:facebook_clone_front/features/profile/views/my_profile_page.dart';
import 'package:facebook_clone_front/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class InfoCard extends StatefulWidget {


  InfoCard({
    Key? key,
 
  }) : super(key: key);

  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {

 UserController userController = Get.put(UserController()); 


  @override
  Widget build(BuildContext context) {
    return ListTile(
     
      leading: GestureDetector(
        onTap: () {
        
      
        },
        child: GestureDetector(
          onTap: (){Get.to(()=>MyProfilePage()); },
          child: Container(
            width: 56,
            height: 56,
            child: ClipOval(
              
              
              
              child:
              
              
               userController.user!.photo == null ||
                      userController.user!.photo.toString() == ""
                  ? Image.asset(
                      "lib/assets/profile.png",
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      userController.user!.photo.toString(),
                      fit: BoxFit.fill,
                    ),
            ),
          ),
        ),
      ),
      title: GestureDetector(
        onTap: (){Get.to(()=>MyProfilePage()); },
        child: Text(
         "${userController.user?.username}",
          style: const TextStyle(color: Colors.white),
        ),
      ),  
      subtitle: GestureDetector(
        onTap: (){Get.to(()=>MyProfilePage()); },
        child: Text(
          "${userController.user?.email}",
          style: const TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}

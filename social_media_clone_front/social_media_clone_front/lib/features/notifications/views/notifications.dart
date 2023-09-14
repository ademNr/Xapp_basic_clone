import 'package:flutter/material.dart';

import '../../sidebar/sidebar.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
     drawer: Drawer(
          child: SideBar(),
          backgroundColor: Colors.black,
        ),
        appBar: AppBar(
          title: Text("notifications", style : TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400, fontFamily: 'inter')),
            leading: GestureDetector(onTap :(){_scaffoldKey.currentState?.openDrawer();} ,child : Image.asset("lib/assets/menu.png")),
          backgroundColor: Colors.black,
          
        
          // The elevation value of the app bar when scroll view has
          // scrolled underneath the app bar.
          scrolledUnderElevation: 4.0,
          shadowColor: Theme.of(context).shadowColor,
          
        ),
     
      body: Center(child: 
      Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Image.asset("lib/assets/search2.gif", scale : 3),
        SizedBox(height: 30,),
        Text("Nothing for now", style: TextStyle(color: Colors.white.withOpacity(0.8)),)
      ]),)
    );
  }
}

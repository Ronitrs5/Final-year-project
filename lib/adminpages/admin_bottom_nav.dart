import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:major_project/adminpages/admin_community.dart';
import 'package:major_project/adminpages/admin_main_page.dart';

class AdminBottomNavPage extends StatefulWidget {
  const AdminBottomNavPage({super.key});

  @override
  State<AdminBottomNavPage> createState() => _AdminBottomNavPageState();
}

class _AdminBottomNavPageState extends State<AdminBottomNavPage> {


  int _selectedIndex = 0;

  List<Widget> tabItems = [
    const AdminMainPage(),
    AdminCommunityPage()

  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        // backgroundColor: Colors.grey,
        body:  Center(
          child: tabItems[_selectedIndex],
        ),
        bottomNavigationBar: FlashyTabBar(
          // animationCurve: Curves.linear,
          animationCurve: Curves.easeIn,
          selectedIndex: _selectedIndex,
          height: 55,
          animationDuration: Duration(milliseconds: 350),
          showElevation: false,
          shadows: [
            BoxShadow(
                color: Colors.transparent
            )
          ],
          iconSize: 25,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              icon: Icon(Icons.home_rounded, color: Colors.grey,size: 25,),
              title: Text('Events', style: TextStyle(color: Colors.black),),
            ),

            FlashyTabBarItem(
              icon: Icon(Icons.school_rounded, color: Colors.grey,size: 25,),
              title: Text('Communities', style: TextStyle(color: Colors.black)),
            )




          ],
        ),
      ),
    );
  }
}

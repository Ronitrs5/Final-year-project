import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:major_project/adminpages/admin_community.dart';
import 'package:major_project/adminpages/admin_main_page.dart';
import 'package:major_project/adminpages/admin_scholarship_benefits.dart';

class AdminBottomNavPage extends StatefulWidget {
  const AdminBottomNavPage({super.key});

  @override
  State<AdminBottomNavPage> createState() => _AdminBottomNavPageState();
}

class _AdminBottomNavPageState extends State<AdminBottomNavPage> {


  int _selectedIndex = 0;

  List<Widget> tabItems = [
    const AdminMainPage(),
    const AdminScholarshipTabbar(),
    const AdminCommunityPage(),


  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
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
          animationDuration: const Duration(milliseconds: 350),
          showElevation: false,
          shadows: [
            const BoxShadow(
                color: Colors.transparent
            )
          ],
          iconSize: 25,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              icon: const Icon(Icons.home_rounded, color: Colors.grey,size: 25,),
              title: const Text('Events', style: TextStyle(color: Colors.black),),
            ),

            FlashyTabBarItem(
              icon: const Icon(Icons.currency_pound_rounded, color: Colors.grey,size: 25,),
              title: const Text('Scholarship Benefit', style: TextStyle(color: Colors.black)),
            ),

            FlashyTabBarItem(
              icon: const Icon(Icons.school_rounded, color: Colors.grey,size: 25,),
              title: const Text('Communities', style: TextStyle(color: Colors.black)),
            ),




          ],
        ),
      ),
    );
  }
}

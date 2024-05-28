import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/pages/beta_page.dart';
import 'package:major_project/sidebar/chatbot/chatbot.dart';
import 'package:major_project/sidebar/community/community_info.dart';
import 'package:major_project/sidebar/events/majoreventdir/major_technical.dart';
import 'package:major_project/sidebar/profile.dart';
import 'package:major_project/sidebar/scholarship/scholarship_tabbar.dart';

class WaterBottomNav extends StatefulWidget {
  const WaterBottomNav({super.key});

  @override
  State<WaterBottomNav> createState() => _WaterBottomNavState();
}

class _WaterBottomNavState extends State<WaterBottomNav> {

  int _selectedIndex = 0;

  List<Widget> tabItems = [
    const MajorTechnicalEvent(),
    const ScholarshipTabbar(),
    // CommunityPage(),
    const ChatBotPage(),
    const ProfilePageNew(),

  ];

  @override
  void initState() {
    super.initState();
  }

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
          backgroundColor: color_bottom_navbar,
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
              title: Text('Events', style: TextStyle(color: Colors.white),),
            ),

            FlashyTabBarItem(
              icon: Icon(Icons.my_library_books_outlined, color: Colors.grey,size: 25,),
              title: Text('Information', style: TextStyle(color: Colors.white)),
            ),

            // FlashyTabBarItem(
            //   icon: Icon(Icons.groups_rounded, color: Colors.grey,size: 25,),
            //   title: Text('Groups', style: TextStyle(color: Colors.white)),
            // ),

            FlashyTabBarItem(
              icon: Image.asset('assets/images/icon_aquarius.png', color: Colors.grey, height: 25, width: 25,),
              title: Text('Aquarius', style: TextStyle(color: Colors.white)),
            ),

            FlashyTabBarItem(
              icon: Icon(Icons.person, color: Colors.grey,size: 25,),
              title: Text('Profile', style: TextStyle(color: Colors.white)),
            ),

          ],
        ),
      ),
    );
  }
}

//
// import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:major_project/colors/colors.dart';
// import 'package:major_project/pages/beta_page.dart';
// import 'package:major_project/sidebar/chatbot/chatbot.dart';
// import 'package:major_project/sidebar/community/community_info.dart';
// import 'package:major_project/sidebar/events/majoreventdir/major_technical.dart';
// import 'package:major_project/sidebar/profile.dart';
// import 'package:major_project/sidebar/scholarship/scholarship_tabbar.dart';
//
// class WaterBottomNav extends StatefulWidget {
//   const WaterBottomNav({super.key});
//
//   @override
//   State<WaterBottomNav> createState() => _WaterBottomNavState();
// }
//
// class _WaterBottomNavState extends State<WaterBottomNav> {
//   int _selectedIndex = 0;
//   late PageController _pageController;
//
//   List<Widget> tabItems = [
//     const MajorTechnicalEvent(),
//     const ScholarshipTabbar(),
//     // CommunityPage(),
//     const ChatBotPage(),
//     const ProfilePageNew(),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: _selectedIndex);
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     _pageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 350),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//         systemNavigationBarIconBrightness: Brightness.dark,
//       ),
//       child: Scaffold(
//         body: PageView(
//           controller: _pageController,
//           onPageChanged: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//           children: tabItems,
//         ),
//         bottomNavigationBar: FlashyTabBar(
//           animationCurve: Curves.easeIn,
//           selectedIndex: _selectedIndex,
//           backgroundColor: color_bottom_navbar,
//           height: 55,
//           animationDuration: Duration(milliseconds: 350),
//           showElevation: false,
//           shadows: [
//             BoxShadow(color: Colors.transparent)
//           ],
//           iconSize: 25,
//           onItemSelected: _onItemTapped,
//           items: [
//             FlashyTabBarItem(
//               icon: Icon(Icons.home_rounded, color: Colors.grey, size: 25),
//               title: Text('Events', style: TextStyle(color: Colors.white)),
//             ),
//             FlashyTabBarItem(
//               icon: Icon(Icons.my_library_books_outlined, color: Colors.grey, size: 25),
//               title: Text('Information', style: TextStyle(color: Colors.white)),
//             ),
//             FlashyTabBarItem(
//               icon: Image.asset('assets/images/icon_aquarius.png', color: Colors.grey, height: 25, width: 25),
//               title: Text('Aquarius', style: TextStyle(color: Colors.white)),
//             ),
//             FlashyTabBarItem(
//               icon: Icon(Icons.person, color: Colors.grey, size: 25),
//               title: Text('Profile', style: TextStyle(color: Colors.white)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//

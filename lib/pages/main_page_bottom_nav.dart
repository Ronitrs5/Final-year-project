import 'package:flutter/material.dart';
import 'package:major_project/pages/beta_page.dart';
import 'package:major_project/sidebar/chatbot/chatbot.dart';
import 'package:major_project/sidebar/events/majoreventdir/major_technical.dart';

class MainPageBottomNav extends StatefulWidget {
  final String userUid;

  const MainPageBottomNav({Key? key, required this.userUid}) : super(key: key);

  @override
  State<MainPageBottomNav> createState() => _MainPageBottomNavState();
}

class _MainPageBottomNavState extends State<MainPageBottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MajorTechnicalEvent(),
    const ChatBotPage(),
    // ProfilePage()
    const BetaPage()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.smart_toy_outlined),
              label: 'Aquarius AI',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.person),
            //   label: 'Profile',
            // ),

            BottomNavigationBarItem(
              icon: Icon(Icons.build),
              label: 'Beta',
            ),
          ],
          backgroundColor: const Color(0xff242028), // Set your desired background color here
          selectedItemColor: Colors.white, // Set your desired selected item color
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_selectedIndex == 1) {
      return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Do you want to leave?'),
          content: const Text('Leaving the chat will clear all the messages!'),
          actions: <Widget>[

            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),

          ],
        ),
      ) ?? false;
    }
    return true;
  }


  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      _onWillPop().then((canNavigate) {
        if (canNavigate) {
          setState(() {
            _selectedIndex = index;
          });
        }
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:major_project/adminpages/admin_main_page.dart';
import 'package:major_project/classes/auth_service.dart';
import 'package:major_project/classes/provider.dart';
import 'package:major_project/pages/main_page_bottom_nav.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:major_project/pages/start_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:major_project/pages/water_bottom_nav.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'adminpages/admin_bottom_nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthService _authService = AuthService();


  // const MyApp({Key? key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Horizon',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: AuthWrapper(),
      home: FutureBuilder<String?>(
        future: _authService.getUserType(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            String? userType = snapshot.data;
            if (userType == 'admin') {
              return const AdminBottomNavPage();
            } else if (userType == 'customer') {
              return const WaterBottomNav();
            } else {
              return const HomePage();
            }
          }
          return const CircularProgressIndicator();
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state while checking authentication status
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle error
          return Text('Error: ${snapshot.error}');
        } else {
          User? user = snapshot.data;

          // Determine whether to show LoginPage or MainPageBottomNav
          if (user == null) {
            return const HomePage();
          } else {
            return FutureBuilder<Map<String, dynamic>>(
              future: fetchUserData(user.uid),
              builder: (context, userDataSnapshot) {
                if (userDataSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  // Loading state while fetching user data
                  return const CircularProgressIndicator(color: Colors.black,);
                } else if (userDataSnapshot.hasError) {
                  // Handle error
                  return Text('Error: ${userDataSnapshot.error}');
                } else {
                  return WaterBottomNav();
                  // return MainPageBottomNav(userUid: user.uid);
                }
              },
            );
          }
        }
      },
    );
  }

  Future<Map<String, dynamic>> fetchUserData(String uid) async {


    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('students_registration_data').doc(uid).get();

    if (snapshot.exists) {
      return snapshot.data() ?? {};
    } else {
      return {};
    }
  }
}

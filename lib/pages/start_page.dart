import 'package:flutter/material.dart';
import 'package:major_project/pages/admin.dart';
import 'package:major_project/pages/login.dart';
import 'package:major_project/pages/signup.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: DefaultTabController(
          length: 3, // Number of tabs
          child: Column(
            children: [
              // TabBar
              TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black54,
                tabs: [
                  Tab(text: 'Register'),
                  Tab(text: 'Login'),
                  Tab(text: 'Admin'),
                ],
                indicatorColor: Colors.black,
              ),
              // TabBarView
              Expanded(
                child: TabBarView(
                  children: [
                    SignUpPage(),
                    LoginPage(),
                    AdminLoginPage()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

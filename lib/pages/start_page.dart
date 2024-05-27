import 'package:flutter/material.dart';
import 'package:major_project/adminpages/admin.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/pages/login.dart';
import 'package:major_project/pages/signup.dart';
import 'package:major_project/sidebar/events/majoreventdir/major_technical.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundAppbar,
      resizeToAvoidBottomInset: false,
      body: const SafeArea(
        child: DefaultTabController(
          length: 3, // Number of tabs
          child: Column(
            children: [
              // TabBar
              TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white60,
                tabs: [
                  Tab(text: 'Register',),
                  Tab(text: 'Login'),
                  Tab(text: 'Admin'),
                ],
                indicatorColor: Colors.white,
                dividerColor: Colors.transparent,
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

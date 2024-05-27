import 'package:flutter/material.dart';
import 'package:major_project/adminpages/admin_major_event.dart';
import 'package:major_project/adminpages/admin_panel.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  static const int numTabs = 2;

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: numTabs,
      child: Scaffold(

        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              // TabBar
              TabBar(
                tabs: [
                  Tab(text: 'Major Event'),
                  Tab(text: 'Sub events'),
                ],
              ),
              // TabBarView
              Expanded(
                child: TabBarView(
                  children: [
                    AdminMajorEvent(),
                    AdminPanelPage(),

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

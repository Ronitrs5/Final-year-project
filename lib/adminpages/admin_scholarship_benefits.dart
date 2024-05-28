import 'package:flutter/material.dart';
import 'package:major_project/adminpages/admin_benefits.dart';
import 'package:major_project/adminpages/admin_major_event.dart';
import 'package:major_project/adminpages/admin_panel.dart';
import 'package:major_project/adminpages/admin_scholarship.dart';

class AdminScholarshipTabbar extends StatefulWidget {
  const AdminScholarshipTabbar({super.key});

  @override
  State<AdminScholarshipTabbar> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminScholarshipTabbar> {
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
                  Tab(text: 'Scholarships'),
                  Tab(text: 'ID benefits'),
                ],
              ),
              // TabBarView
              Expanded(
                child: TabBarView(
                  children: [
                    AdminScholarship(),
                    AdminBenefits(),

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

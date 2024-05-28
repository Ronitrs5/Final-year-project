import 'package:flutter/material.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/sidebar/community/community_info.dart';
import 'package:major_project/sidebar/events/majoreventdir/major_technical.dart';
import 'package:major_project/sidebar/scholarship/id_benefits.dart';
import 'package:major_project/sidebar/scholarship/scholarship.dart';

class ScholarshipTabbar extends StatefulWidget {
  const ScholarshipTabbar({super.key});

  @override
  State<ScholarshipTabbar> createState() => _ScholarshipTabbarState();
}

class _ScholarshipTabbarState extends State<ScholarshipTabbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundAppbar,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: DefaultTabController(
          length: 3, // Number of tabs
          child: Column(
            children: [
              // TabBar
              TabBar(
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: [

                  Tab(
                    child: Text(
                      'Communities',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Namun',
                          letterSpacing: 0.5
                      ),
                    ),
                  ),
                  
                  Tab(
                    child: Text(
                      'Scholarships',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Namun',
                          letterSpacing: 0.5

                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'ID benefits',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Namun',
                        letterSpacing: 0.5
                      ),
                    ),
                  ),


                ],
                indicatorColor: Colors.white,
              ),
              // TabBarView
              Expanded(
                child: TabBarView(
                  children: [

                    CommunityPage(),
                    Scholarship(), // Content of Scholarships tab
                    IDBenefits(),

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

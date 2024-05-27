import 'package:flutter/material.dart';
import 'package:major_project/sidebar/events/majoreventdir/major_technical.dart';

class EventFragment extends StatefulWidget {
  const EventFragment({super.key});

  @override
  State<EventFragment> createState() => _EventFragmentState();
}

class _EventFragmentState extends State<EventFragment> {
  static const int numTabs = 1;

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
                  Tab(text: 'Technical Events'),
                ],
              ),
              // TabBarView
              Expanded(
                child: TabBarView(
                  children: [
                    MajorTechnicalEvent(),

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

import 'package:flutter/material.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/sidebar/events/technical.dart';
import 'package:major_project/sidebar/chatbot/chatbot.dart';

import '../sidebar/events/nontechnical.dart';

bool night_mode= false;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: night_mode ? main_bk_night : main_bk_day,
      appBar: AppBar(
        iconTheme: IconThemeData(color: night_mode ? text_day : text_night,),
        backgroundColor: night_mode ? main_bk_night : main_bk_day,
        title: Text("Hello Ronit",
          style: TextStyle(
            color: night_mode ? text_day : text_night,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              setState(() {
                night_mode= !night_mode;
              });
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: night_mode? const Icon(Icons.nightlight_outlined, color: Colors.white,) : const Icon(Icons.brightness_high),

            ),
          )
        ],
      ),
      drawer: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
        child: Drawer(
          backgroundColor: night_mode ? main_bk_night : main_bk_day ,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: night_mode? header_night : header_day,
                ),
                padding: const EdgeInsetsDirectional.all(20.0),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/images/student.png' ), // Replace with your image
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Ronit Savadimath\nBE - IT\n407B052",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              // Add other menu items here

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Event Section",
                  style: TextStyle(
                  color: night_mode? text_day: text_night,
                 ) ,
                ),
              ),

              ListTile(
                leading: const Icon(Icons.military_tech),
                title: Text('Technical Events',
                  style: TextStyle(
                    color: night_mode? text_day: text_night,
                  ) ,
                ),
                onTap: () {
                  // Implement the action when Information is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TechnicalEvent()),
                    // MaterialPageRoute(builder: (context)=>DescPage())
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.event),
                title: Text('Non-Technical Events',
                  style: TextStyle(
                    color: night_mode? text_day: text_night,
                  ) ,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NonTechnicalEvents()),
                  );
                },
              ),

              const Divider(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Career Section",
                  style: TextStyle(
                    color: night_mode? text_day: text_night,
                  ) ,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.smart_toy_outlined),
                title: Text('Aquarius Chat-Bot',
                  style: TextStyle(
                    color: night_mode? text_day: text_night,
                  ) ,
                ),
                onTap: () {
                  // Implement the action when Information is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatBotPage()),
                    // MaterialPageRoute(builder: (context)=>DescPage())
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.map),
                title: Text('Roadmap',
                  style: TextStyle(
                    color: night_mode? text_day: text_night,
                  ) ,
                ),
                onTap: () {
                  // Implement the action when Information is tapped
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const WasteCollectionPage()),
                  //   // MaterialPageRoute(builder: (context)=>DescPage())
                  // );
                },
              ),

              const Divider(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Information Section",
                  style: TextStyle(
                    color: night_mode? text_day: text_night,
                  ) ,
                ),
              ),




              ExpansionTile(
                leading: const Icon(Icons.school),
                trailing: const Icon(Icons.keyboard_arrow_down),
                title: Text(
                  'Benefits and scholarships',
                  style: TextStyle(
                    color: night_mode ? text_day : text_night,
                  ),
                ),
                children: [
                  // Add your list items here
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: ListTile(
                      title: Text('‣ Student ID benefits',
                        style: TextStyle(
                          color: night_mode? text_day: text_night,
                        ) ,
                      ),
                      onTap: (){
                      },
                      // onTap for Event 1
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: ListTile(
                      title: Text('‣ Government scholarships',
                        style: TextStyle(
                          color: night_mode? text_day: text_night,
                        ) ,
                      ),
                      // onTap for Event 2
                      onTap: (){
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: ListTile(
                      title: Text('‣ Private scholarships',
                        style: TextStyle(
                          color: night_mode? text_day: text_night,
                        ) ,
                      ),
                      // onTap for Event 2
                      onTap: (){
                      },
                    ),
                  ),
                  // Add more list items as needed
                ],

              ),



              ListTile(
                leading: const Icon(Icons.book),
                title: Text('Bookstore Information',
                  style: TextStyle(
                    color: night_mode? text_day: text_night,
                  ) ,
                ),
                onTap: () {
                  // Implement the action when Home is tapped
                  // Navigator.push(
                  //   context,
                  //   // MaterialPageRoute(builder: (context) => const SearchAssessment()),
                  // );
                },
              ),


              ListTile(
                leading: const Icon(Icons.fastfood),
                title: Text('Mess Information',
                  style: TextStyle(
                    color: night_mode? text_day: text_night,
                  ) ,
                ),
                onTap: () {
                  // Implement the action when Home is tapped
                  // Navigator.push(
                  //   context,
                  //   // MaterialPageRoute(builder: (context) => const NewRegistrationPage()),
                  // );
                },
              ),

              ListTile(
                leading: const Icon(Icons.tour),
                title: Text('Campus Tour',
                  style: TextStyle(
                    color: night_mode? text_day: text_night,
                  ) ,
                ),
                onTap: () {
                  // Implement the action when New Registration is tapped
                  // Navigator.push(
                  //   // context,
                  //   // MaterialPageRoute(builder: (context) => const PropertyDetails()),
                  // );
                },
              ),
              const Divider(),

            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Align(child: Text("Your college",
                style: TextStyle(
                  fontSize: 18,
                  color: night_mode? text_day: text_night,
                ),
              ),
                alignment: Alignment.bottomLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Card(
                color: Colors.blueGrey[400],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset("assets/images/university.webp"),
                      const Text("Sinhgad College of Engineering",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16

                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            const Divider(),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Align(child: Text("Your profile",
                style: TextStyle(
                    fontSize: 18,
                    color: night_mode? text_day: text_night,
                ),
              ),
                alignment: Alignment.bottomLeft,
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Card(
                      color: Colors.blue[100],
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                        child: Column(
                          children: [
                            Image.asset("assets/images/student.png", width: 150,),
                            const Text("Ronit Savadimath",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16

                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Card(
                      color: Colors.blue[100],
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset("assets/images/curriculum.png", width: 80,),
                            ),
                            const Text("Information Technology",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16

                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),


            ),

            const Divider(),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Align(child: Text("Alumni network",
                style: TextStyle(
                    fontSize: 18,
                    color: night_mode? text_day: text_night,
                ),
              ),
                alignment: Alignment.bottomLeft,
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Card(
                      color: Colors.purple[100],
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Image.asset("assets/images/alumni.png", width: 100,),
                            ),
                            const Text("Alumni Reviews",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Card(
                      color: Colors.purple[100],
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Image.asset("assets/images/connection.png", width: 100,),
                            ),
                            const Text("Connect with alumni",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

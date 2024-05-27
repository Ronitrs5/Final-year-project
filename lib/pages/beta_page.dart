import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/pages/start_page.dart';
import 'package:major_project/sidebar/events/majoreventdir/major_technical.dart';
bool theme = false;

class BetaPage extends StatefulWidget {
  const BetaPage({super.key});

  @override
  State<BetaPage> createState() => _BetaPageState();
}

class _BetaPageState extends State<BetaPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
      print("User signed out");
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff242028),
      appBar: AppBar(
        backgroundColor: backgroundAppbar,
        title: const Text("Beta", style: TextStyle(color: Colors.white),),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              // Show confirmation dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.red[900],
                    title: const Text('Logout', style: TextStyle(color: Colors.white),),
                    content: const Text('Are you sure you want to logout?', style: TextStyle(color: Colors.white70)),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('No', style: TextStyle(color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {
                          _signOut(); // Call your logout method
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('Yes', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          ),

        ],
      ),
      body: const Column(
        children: [
          Align(alignment: Alignment.topLeft,child: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Text("Features under development", style: TextStyle(fontSize: 15, color: Colors.green, fontWeight: FontWeight.bold),),
          )),

          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                color: Color(0xff342c3c),
                child: Column(
                  children: [

                    SizedBox(height: 8,),

                    Text("• Aquarius AI •", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                    Text("We are constantly feeding data to the chat-bot. Training and testing of the chat-bot is still development.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(thickness: 1,),
                    ),

                    Text("• Notifications •", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                    Text("One of the core features of this applications is to notify you whenever a new event was registered so that you will not miss"
                        " any opportunity. Push notifications is under development.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70),),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(thickness: 1,),
                    ),

                    Text("• Mess and bookstore •", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                    Text("Information about all the messes and bookstores within the campus is under development.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70),),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Divider(thickness: 1,),
                    // ),
                    //
                    // Text("• Student ID benefits & Scholarships •", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    // Text("A section about information of the benefits of your student ID and any government or private scholarship is under development.", textAlign: TextAlign.center,),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Divider(thickness: 1,),
                    // ),

                    SizedBox(height: 8,)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

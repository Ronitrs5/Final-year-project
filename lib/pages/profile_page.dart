import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:major_project/pages/login.dart';
import 'package:major_project/pages/signup.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> userData;

  String userID = student_ID;
  String userIDl = student_IDl;

  @override
  void initState() {
    super.initState();
    userData = fetchUserData();
  }

  Future<Map<String, dynamic>> fetchUserData() async {


    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('students_registration_data')
        .doc(userID != "" ? student_ID : student_IDl)
        .get();

    if (snapshot.exists) {
      // If the document exists, return the entire map of data
      return snapshot.data() ?? {}; // Return an empty map if data is null
    } else {
      // If the document doesn't exist, handle accordingly
      return {}; // Return an empty map
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Profile'),
      //   automaticallyImplyLeading: false,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.green,
                      Colors.blue
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/student.png",
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),

            FutureBuilder<Map<String, dynamic>>(
              future: userData,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Colors.black,
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Access user data using the keys
                  String userName =
                      snapshot.data?['student_name'] ?? 'Default Name';

                  // Display the user's name
                  return Text('$userName',textAlign: TextAlign.center,);
                }
              },
            ),


            FutureBuilder<Map<String, dynamic>>(
              future: userData,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Colors.black,
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Access user data using the keys
                  String userName =
                      snapshot.data?['student_email'] ?? 'Default Name';

                  // Display the user's name
                  return Text('$userName', textAlign: TextAlign.center,);
                }
              },
            ),


            FutureBuilder<Map<String, dynamic>>(
              future: userData,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Colors.black,
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Access user data using the keys
                  String userName =
                      snapshot.data?['student_branch'] ?? 'Default Name';

                  // Display the user's name
                  return Text('$userName Engineering', textAlign: TextAlign.center,);
                }
              },
            ),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(thickness: 1,),
            )
          ],
        ),
      ),
    );
  }
}


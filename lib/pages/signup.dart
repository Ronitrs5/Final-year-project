import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/pages/main_page_bottom_nav.dart';
import 'package:major_project/pages/water_bottom_nav.dart';
import 'package:major_project/sidebar/events/majoreventdir/major_technical.dart';
import 'package:shared_preferences/shared_preferences.dart';

String student_ID = "";

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isPasswordVisible = false;
  bool _isRegistering = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController tec_fullname = TextEditingController();
  TextEditingController tec_email = TextEditingController();
  TextEditingController tec_password = TextEditingController();
  String branch = "";


  Future<void> _register() async {
    try {
      setState(() {
        _isRegistering = true;
      });

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: tec_email.text,
        password: tec_password.text,
      );

      await _firestore.collection('students_registration_data').doc(userCredential.user!.uid).set({
        'student_email': tec_email.text,
        'student_password': tec_password.text,
        'student_branch' : branch,
        'student_name' : tec_fullname.text,
        'student_phone' : '',
        'student_address' : '',
        'student_cid' : '',
        'student_college' :'',


        // Add other user data fields as needed
      });

      FirebaseMessaging.instance.subscribeToTopic('event_notification_all');

      // Store the UID in a variable for later use
      String userUid = userCredential.user!.uid;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userType', 'customer');
      prefs.setBool('night', true);
      student_ID = userUid;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WaterBottomNav())
      );


    } catch (e) {
      print('Error registering user: $e');

      String errorMessage = e.toString();
      int startIndex = errorMessage.indexOf("]") + 1; // Find the index after the closing bracket
      String mainErrorMessage = errorMessage.substring(startIndex).trim();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mainErrorMessage,   style: const TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      setState(() {
        _isRegistering = false; // Hide progress indicator
      });
    }
  }



  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: backgroundAppbar,
    ));

    return SafeArea(
      child: Scaffold(
        backgroundColor: color_bottom_navbar,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 100,),
                Image.asset("assets/images/icon_even_horizon.png",
                  width: 100,
                  height: 100,
                ),


                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Text("Welcome to", style: TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'Namun'),),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: 'NamunGothic',
                        fontSize: 28,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                      children: [
                        TextSpan(
                          text: 'E',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue
                          ),
                        ),
                        TextSpan(
                          text: 'vent ',
                          style: TextStyle(fontSize: 20)
                        ),
                        TextSpan(
                          text: 'H',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                              color: Colors.blue

                          ),
                        ),
                        TextSpan(
                          text: 'orizon',
                            style: TextStyle(fontSize: 20)
                        ),
                      ],
                    ),
                  ),
                ),



                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: TextField(
                    controller: tec_fullname,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.grey[700],
                    cursorWidth: 1.5,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent, // Set the color of the border when the TextField is selected
                          ),
                        ),
                        floatingLabelStyle: TextStyle(color: Colors.grey[700]),
                        labelText: 'Enter full name',
                        prefixIcon: const Icon(Icons.person),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            )
                        )
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: TextField(
                    controller: tec_email,
                    cursorColor: Colors.grey[700],
                    cursorWidth: 1.5,
                    style: const TextStyle(color: Colors.white),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        floatingLabelStyle: TextStyle(color: Colors.grey[700]),
                        labelText: 'Email address',
                        prefixIcon: const Icon(Icons.mail),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            )
                        )),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        floatingLabelStyle: TextStyle(color: Colors.grey[700]),
                        prefixIcon: const Icon(Icons.stream),
                        contentPadding: const EdgeInsets.all(16),
                        labelText: 'Branch',
                      ),icon: const Icon(Icons.arrow_drop_down_outlined),
                      style: const TextStyle(color: Colors.white),
                      dropdownColor: Colors.black,

                      items: const [
                        DropdownMenuItem(value: 'Computer Science', child: Text('Computer Science',)),
                        DropdownMenuItem(value: 'Information Technology', child: Text('Information Technology')),
                        DropdownMenuItem(value: 'Mechanical', child: Text('Mechanical')),
                        DropdownMenuItem(value: 'Civil', child: Text('Civil')),
                        DropdownMenuItem(value: 'Biotechnology', child: Text('Biotechnology')),
                        DropdownMenuItem(value: 'Electronics and Telecommunication', child: Text('Electronics and Telecommunication')),
                        DropdownMenuItem(value: 'Production', child: Text('Production')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          branch = value!;
                        });
                      }  // Handle dropdown value change
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: TextField(
                    controller: tec_password,
                    cursorColor: Colors.grey[700],
                    cursorWidth: 1.5,
                    style: const TextStyle(color: Colors.white),
                    textInputAction: TextInputAction.done,
                    obscureText: !_isPasswordVisible, // Toggle password visibility
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      floatingLabelStyle: TextStyle(color: Colors.grey[700]),
                      labelText: 'Create password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },

                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white54,
                      ),
                      onPressed: _isRegistering ? null : () => _register(),
                      child: _isRegistering
                          ? Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Container(width: 20, height: 20 ,child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,)),
                          )
                          : const Text(
                        "Register",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
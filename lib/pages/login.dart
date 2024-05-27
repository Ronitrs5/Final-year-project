import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/pages/forgot_password_page.dart';
import 'package:major_project/pages/main_page_bottom_nav.dart';
import 'package:major_project/pages/water_bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sidebar/events/majoreventdir/major_technical.dart';

String student_IDl = "";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  bool _isPasswordVisible = false;
  bool _isRegistering = false;
  TextEditingController tec_login_gmail = TextEditingController();
  TextEditingController tec_login_password = TextEditingController();

  double _left = 0.0;
  double _top = 0.0;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser() async {
    try {
      setState(() {
        _isRegistering = true;
      });

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: tec_login_gmail.text.trim(),
        password: tec_login_password.text.trim(),
      );

      FirebaseMessaging.instance.subscribeToTopic('event_notification_all');

      String userUid = userCredential.user!.uid;
      student_IDl = userUid;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userType', 'customer');
      prefs.setBool('night', false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WaterBottomNav()),
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
        _isRegistering = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Change the status bar color to your desired color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: backgroundAppbar, // Set your desired color

    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundScaffold,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(height: 42,),
                // GestureDetector(
                //   onTap: (){
                //     // Navigator.pushReplacement(
                //     //   context,
                //     //   MaterialPageRoute(builder: (context) => const MainPageBottomNav(userUid: "")),
                //     // );
                //   },
                //   child: Image.asset("assets/images/icon_even_horizon.png",
                //     width: 100,
                //     height: 100,
                //   ),
                // ),

                // GestureDetector(
                //   onTap: _animateImage,
                //   child: RotationTransition(
                //     turns: Tween(begin: 0.0, end: 0.0).animate(_controller),
                //     child: SlideTransition(
                //       position: Tween(begin: Offset.zero, end: Offset(5.0, 0.0)).animate(_controller),
                //       child: Image.asset(
                //         "assets/images/icon_even_horizon.png",
                //         width: 100,
                //         height: 100,
                //       ),
                //     ),
                //   ),
                // ),

                GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      _left += details.delta.dx;
                      _top += details.delta.dy;
                    });
                  },
                  
                  child: Transform.translate(
                    offset: Offset(_left, _top),
                    child: Image.asset(
                      "assets/images/icon_even_horizon.png",
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Text("Welcome back to", style: TextStyle(color: Colors.grey, fontSize: 14, fontFamily: 'Namun'),),
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
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
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
                    controller: tec_login_gmail,
                    // focusNode: usernameFocus,
                    // onEditingComplete: () {
                    //   FocusScope.of(context).requestFocus(passwordFocus);
                    // },
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.grey[700],
                    cursorWidth: 1.5,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: 'Email address',
                        prefixIcon: const Icon(Icons.email),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent, // Set the color of the border when the TextField is selected
                          ),
                        ),
                        floatingLabelStyle: TextStyle(color: Colors.grey[700]),

                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ))),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: TextField(
                    controller: tec_login_password,
                    // focusNode: passwordFocus,
                    // onEditingComplete: () {
                    //   // Additional logic when pressing done/next on the keyboard
                    // },
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.grey[700],
                    cursorWidth: 1.5,
                    textInputAction: TextInputAction.done,
                    obscureText: !_isPasswordVisible, // Toggle password visibility
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent, // Set the color of the border when the TextField is selected
                        ),
                      ),
                      floatingLabelStyle: TextStyle(color: Colors.grey[700]),
                      labelText: 'Password',
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
                      // errorText: isPasswordEmpty
                      //     ? 'Please enter password'
                      //     : null,
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
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white54,                      ),
                      onPressed: _isRegistering ? null : () => loginUser(),
                      child: _isRegistering
                          ? Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Container(width: 20, height: 20 ,child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,)),
                          )
                          : const Text(
                        "Login",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),

                // Text("Forgot Password?")
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                //   child: SizedBox(
                //     width: double.infinity,
                //     child: ElevatedButton(
                //       onPressed: (){
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(builder: (context) => Forgot),
                //         );
                //       },
                //       style: ElevatedButton.styleFrom(
                //           backgroundColor: Colors.transparent,
                //           elevation: 0
                //       ),
                //       child: const Text("Forgot password?",
                //         style: TextStyle(
                //             color: Colors.white70
                //         ),
                //       ),
                //
                //     ),
                //   ),
                // ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
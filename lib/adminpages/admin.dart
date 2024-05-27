import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:major_project/adminpages/admin_bottom_nav.dart';
import 'package:major_project/adminpages/admin_main_page.dart';
import 'package:major_project/classes/auth_service.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/sidebar/events/majoreventdir/major_technical.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  bool _isPasswordVisible = false;
  TextEditingController adminLogin = TextEditingController();
  TextEditingController adminPassword = TextEditingController();


  bool isPasswordVisible = false;

  final AuthService _authService = AuthService();
  Future<void> _signIn(BuildContext context) async {
    String id = adminLogin.text;
    String pass = adminPassword.text;

    bool success = await _authService.signIn(id, pass);
    try {
      if (success) {
        print("SUCCESS");
        FirebaseMessaging.instance.subscribeToTopic('adminNotification');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdminBottomNavPage()),
        );
      } else {
        // Handle authentication failure
        print("FAILED");
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wrong ID or password')));
      }
    }
    catch (e){
      print("ERROR");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong')));
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

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
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
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
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
                            color: Colors.deepOrange

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

              const Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 16),
                child: Text("Admin login", style: TextStyle(color: Colors.grey, fontSize: 14),),
              ),


              Row(
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            controller: adminLogin,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent, // Set the color of the border when the TextField is selected
                                  ),
                                ),
                                floatingLabelStyle: TextStyle(color: Colors.grey[700]),
                                labelText: 'Admin ID',
                                prefixIcon: const Icon(Icons.credit_card),
                                // border: OutlineInputBorder(),
                                // errorText: isUsernameEmpty
                                //     ? 'Please enter username'
                                //     : null,
                                errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ))),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: TextField(
                            controller: adminPassword,
                            // focusNode: passwordFocus,
                            // onEditingComplete: () {
                            //   // Additional logic when pressing done/next on the keyboard
                            // },
                            style: const TextStyle(color: Colors.white),
                            textInputAction: TextInputAction.done,
                            obscureText:
                            !_isPasswordVisible, // Toggle password visibility
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent, // Set the color of the border when the TextField is selected
                                ),
                              ),
                              floatingLabelStyle: TextStyle(color: Colors.grey[700]),
                              labelText: 'Admin Password',
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
                              // border: const OutlineInputBorder(),
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
                                backgroundColor: Colors.white54,
                              ),
                              onPressed: () {
                                _signIn(context);
                              },
                              child: const Text(
                                "Admin login",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Image.asset('assets/images/man_leaning.png', width: 150,)
                ],
              )
            ],
          ),
        ),
          ),
      ),
    );
  }
}

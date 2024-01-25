import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:major_project/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {

    // Change the status bar color to your desired color
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Set your desired color

    ));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(height: 42,),
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blue[100]
                  ),
                    child: Image.asset("assets/images/college.png",
                      width: 100,
                      height: 100,
                    ),
                ),


                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 16),
                  child: Text("Welcome back",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      letterSpacing: 4
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: TextField(
                    // controller: usernameController,
                    // focusNode: usernameFocus,
                    // onEditingComplete: () {
                    //   FocusScope.of(context).requestFocus(passwordFocus);
                    // },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: 'Student ID',
                        prefixIcon: Icon(Icons.credit_card),
                        border: OutlineInputBorder(),
                        // errorText: isUsernameEmpty
                        //     ? 'Please enter username'
                        //     : null,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ))),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: TextField(
                    // controller: passwordController,
                    // focusNode: passwordFocus,
                    // onEditingComplete: () {
                    //   // Additional logic when pressing done/next on the keyboard
                    // },
                    textInputAction: TextInputAction.done,
                    obscureText: !_isPasswordVisible, // Toggle password visibility
                    decoration: InputDecoration(
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
                      border: const OutlineInputBorder(),
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
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MainPage()),
                        );
                      },

                      child: const Text("Login",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),

                // Text("Forgot Password?")
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: (){},
                      child: const Text("Forgot password?",
                        style: TextStyle(
                            color: Colors.blueAccent
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0
                      ),

                    ),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                //   child: Container(
                //     width: double.infinity,
                //     child: ElevatedButton(onPressed: (){},
                //       child: Text("New student?",
                //         style: TextStyle(
                //             color: Colors.blueAccent
                //         ),
                //       ),
                //       style: ElevatedButton.styleFrom(
                //           backgroundColor: Colors.white,
                //           elevation: 0
                //       ),
                //
                //     ),
                //   ),
                // ),
                //
                //
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                //   child: Container(
                //     width: double.infinity,
                //     child: ElevatedButton(onPressed: (){},
                //       child: Text("Admin login",
                //         style: TextStyle(
                //             color: Colors.blueAccent
                //         ),
                //       ),
                //       style: ElevatedButton.styleFrom(
                //           backgroundColor: Colors.grey[200],
                //           elevation: 0
                //       ),
                //
                //     ),
                //   ),
                // ),



                // Padding(
                //   padding: const EdgeInsets.all(75.0),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text("Take me to ", style: TextStyle(
                //             fontSize: 18
                //           ),
                //           ),
                //
                //           Container(
                //               padding: EdgeInsets.all(16),
                //               child: Image.asset("assets/images/college_tour.png", width: 30,),
                //               decoration: BoxDecoration(
                //                   color: Colors.blue[100],
                //                   borderRadius: BorderRadius.circular(50)
                //               )
                //           ),
                //
                //           Text(" campus tour", style: TextStyle(
                //               fontSize: 18
                //           ),
                //           ),
                //         ],
                //       ),
                //       // SizedBox(height: 16),
                //
                //     ],
                //   ),
                // ),

                // Padding(
                //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                //   child: Container(
                //     width: double.infinity,
                //     child: ElevatedButton(
                //       onPressed: (){},
                //       style: ElevatedButton.styleFrom(
                //         elevation: 0,
                //         backgroundColor: Colors.white
                //       ),
                //       child: Text("Report!",
                //         style: TextStyle(
                //           color: Colors.red,
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

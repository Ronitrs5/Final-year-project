import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:major_project/pages/admin_panel.dart';
import 'package:major_project/pages/main_page.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {

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
                Image.asset("assets/images/icon_admin.png",
                  width: 100,
                  height: 100,
                ),


                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 16),
                  child: Text("Admin Login",
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
                        labelText: 'Admin ID',
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
                          MaterialPageRoute(builder: (context) => const AdminPanelPage()),
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}

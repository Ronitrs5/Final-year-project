import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:major_project/classes/auth_service.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/pages/start_page.dart';
import 'package:major_project/sidebar/contribute.dart';

import 'package:major_project/sidebar/events/majoreventdir/major_technical.dart';
import 'package:major_project/theme/style_card_title.dart';
import 'package:major_project/widgets/profile_edit_textfields.dart';
import 'package:major_project/widgets/profile_retrieve_widget.dart';
import 'package:major_project/widgets/profile_setting_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs_lite.dart' as lite;
class ProfilePageNew extends StatefulWidget {
  const ProfilePageNew({super.key});

  @override
  State<ProfilePageNew> createState() => _ProfilePageNewState();
}

class _ProfilePageNewState extends State<ProfilePageNew> {
  bool editMode = false;
  bool isLoading = false;
  String userName = "";
  String userBranch = "";
  bool nightMode = true;



  TextEditingController TEC_phone = TextEditingController();
  TextEditingController TEC_address = TextEditingController();
  TextEditingController TEC_collegeid = TextEditingController();
  TextEditingController TEC_college = TextEditingController();

  AuthService authService = AuthService();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _signOut() async {
    try {
      await _firebaseAuth.signOut();
      authService.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
      print("User signed out");
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  Future<void> _launchURLInDefaultBrowserOnAndroid(BuildContext context, String url) async {
    try {
      await launchUrl(
        Uri.parse(url),
        customTabsOptions: CustomTabsOptions(
          colorSchemes: CustomTabsColorSchemes.defaults(
            toolbarColor: backgroundAppbar,
            navigationBarColor: backgroundAppbar,
          ),
          urlBarHidingEnabled: true,
          showTitle: true,
          browser: const CustomTabsBrowserConfiguration(
            prefersDefaultBrowser: true,

          ),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  Future<String?> fetchName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      DocumentSnapshot<Map<String, dynamic>> userDocSnapshot =
          await FirebaseFirestore.instance
              .collection('students_registration_data')
              .doc(user!.uid)
              .get();

      if (userDocSnapshot.exists) {
        String res = userDocSnapshot.get('student_name');

        // setState(() {
        //   TEC_name.text = res;
        // });

        return res;
      } else {
        print('User document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching name: $e');
      return null;
    }
  }

  Future<String?> fetchBranch() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      DocumentSnapshot<Map<String, dynamic>> userDocSnapshot =
          await FirebaseFirestore.instance
              .collection('students_registration_data')
              .doc(user!.uid)
              .get();

      if (userDocSnapshot.exists) {
        String res = userDocSnapshot.get('student_branch');

        // setState(() {
        //   TEC_name.text = res;
        // });

        return res;
      } else {
        print('User document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching name: $e');
      return null;
    }
  }

  Future<Map<String?, dynamic>> fetchDetails() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      DocumentSnapshot<Map<String, dynamic>> userDocSnapshot =
          await FirebaseFirestore.instance
              .collection('students_registration_data')
              .doc(user!.uid)
              .get();

      Map<String?, dynamic> res = {}; // Make keys nullable as well

      if (userDocSnapshot.exists) {
        res = userDocSnapshot.data() ?? {}; // Handle null data from snapshot
        return res;
      } else {
        print('User document does not exist');
        return res;
      }
    } catch (e) {
      print('Error fetching name: $e');
      return {};
    }
  }

  Future<void> updateStudentProfile() async {
    User? user = FirebaseAuth.instance.currentUser;

    setState(() {
      editMode = true;
      isLoading = true;
    });
    if (user != null) {
      try {
        String phone = TEC_phone.text.trim();
        String address = TEC_address.text.trim();
        String cid = TEC_collegeid.text.trim();
        String college = TEC_college.text.trim();

        await FirebaseFirestore.instance
            .collection('students_registration_data')
            .doc(user.uid)
            .update({
          'student_phone': '+91-$phone',
          'student_address': address,
          'student_cid': cid,
          'student_college':college,
          // Add more fields if needed
        });

        setState(() {
          editMode = false;
          isLoading = false;
        });

        ScaffoldMessenger.of(context).
        showSnackBar(SnackBar(content: Text("Data updated", style: TextStyle(color: Colors.black),), behavior: SnackBarBehavior.floating, backgroundColor: Colors.white,));
        print('Data uploaded to Firestore successfully!');
      } catch (error) {
        // Error handling
        setState(() {
          editMode = false;
          isLoading = false;
        });
        ScaffoldMessenger.of(context).
        showSnackBar(SnackBar(content: Text("Something went wrong", style: TextStyle(color: Colors.black),), behavior: SnackBarBehavior.floating, backgroundColor: Colors.white,));
        print('Error uploading data to Firestore: $error');
      }
    }else{
      setState(() {
        editMode = false;
        isLoading = false;
      });
      ScaffoldMessenger.of(context).
      showSnackBar(SnackBar(content: Text("Something went wrong", style: TextStyle(color: Colors.black),), behavior: SnackBarBehavior.floating, backgroundColor: Colors.white,));
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _initAsync();
  // }
  //
  // Future<void> _initAsync() async {
  //   _loadThemePreference();
  // }
  //
  // Future<void> _loadThemePreference() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   bool isNightMode = sharedPreferences.getBool('night') ?? true;
  //   print('isNightMode : $isNightMode');
  //   setState(() {
  //     nightMode = isNightMode;
  //     print('NightMode: $nightMode');
  //   });
  // }
  //
  // Future<void> _toggleThemePreference(bool value) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   await sharedPreferences.setBool('night', value);
  //   setState(() {
  //     nightMode = value;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundScaffold,
      appBar: AppBar(
              backgroundColor: backgroundAppbar,
              title: Text(
                editMode? "Editing profile...":
                "Profile",
                style: CustomTextStyles.style_appbar,
              ),
              automaticallyImplyLeading: false,
              actions: [
                
                // GestureDetector(onTap: (){_signOut();},child: Icon(Icons.logout)),

                Visibility(
                  visible: !editMode,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          editMode = true;
                        });
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      )),
                ),

                Visibility(
                  visible: editMode && !isLoading,
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          editMode = false;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Changes were not saved",
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: Colors.white,
                          behavior: SnackBarBehavior.floating,
                        ));
                      },
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      )),
                ),

                Visibility(
                  visible: editMode,
                  child: SizedBox(
                    width: 32,
                  ),
                ),

                Visibility(
                  visible: editMode,
                  child: GestureDetector(
                    onTap: (){
                      if(TEC_phone.text.trim().isEmpty && TEC_address.text.trim().isEmpty && TEC_collegeid.text.trim().isEmpty){
                        ScaffoldMessenger.of(context).
                        showSnackBar(SnackBar(content: Text("All fields cannot be empty", style: TextStyle(color: Colors.black),), behavior: SnackBarBehavior.floating, backgroundColor: Colors.white,));
                        return;
                      }else{
                        updateStudentProfile();
                      }
                    },
                    child: isLoading ? Container(width: 20,height: 20,child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,)) : Icon(
                      Icons.done_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [


            Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                  child: GestureDetector(
                    onTap: (){
                      if(editMode) {
                        ScaffoldMessenger.of(context).
                        showSnackBar(SnackBar(content: Text("Coming soon",
                          style: TextStyle(color: Colors.black),),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.white,));
                      }
                    },
                    child: Container(
                        width: !editMode ? null : 150,
                        height: !editMode ? null : 150,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: !editMode ? color_eventcard: Colors.transparent,
                          borderRadius: BorderRadius.circular(120),
                          border:
                              editMode ? Border.all(color: Colors.grey) : null,
                        ),
                        child: !editMode
                            ? Icon(
                                Icons.person,
                                size: 80,
                          color: Colors.grey[800],
                              )
                            : Center(
                                child: Text(
                                "Click to choose photo",
                                style: TextStyle(color: Colors.white, fontFamily: 'Namun'),
                                  textAlign: TextAlign.center,

                              ))),
                  ),
                )
            ),
            SizedBox(
              height: 16,
            ),
            Visibility(
              visible: !editMode,
              child: Column(
                children: [
                  FutureBuilder<Map<String?, dynamic>>(
                    future: fetchDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Shimmer.fromColors(
                            baseColor: backgroundAppbar,
                            highlightColor: Colors.grey[900]!,
                            child: Container(
                              decoration: BoxDecoration(
                                color: backgroundAppbar,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: 100.0,
                              height: 30.0,
                            ),
                          )
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        String? name = snapshot
                            .data?['student_name']; // Handle potential null data
                        String? email = snapshot
                            .data?['student_email']; // Handle potential null data
                        return Center(
                          child: Column(
                            children: [
                              Text(
                                name ?? '',
                                style:
                                    TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: 'Namun'),
                              ),
                              Text(
                                email ?? '',
                                style:
                                    TextStyle(fontSize: 14.0, color: Colors.white, fontFamily: 'Namun'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Expanded(
                        //   child: SizedBox(
                        //     width: 50, // Adjust the width of the container as needed
                        //     child: Divider(
                        //       color: Colors.grey, // Adjust color as needed
                        //       thickness: 1, // Adjust thickness as needed
                        //       endIndent: 10, // Adjust endIndent as needed
                        //     ),
                        //   ),
                        // ),


                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: color_eventcard
                      ),
                      child: Column(
                        children: [

                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text(
                                'Additional information',
                                style: CustomTextStyles.style_setting_titles,
                              ),
                            ),
                          ),

                          Divider(
                            color: Colors.grey[300]!, // Adjust color as needed
                            thickness: 0.1, // Adjust thickness as needed
                             // Adjust indent as needed
                          ),

                          SizedBox(height: 4,),

                          ProfileRetrieveWidget(label: "College", data: 'student_college', icon: Icons.school_rounded,),
                          SizedBox(height: 16,),
                          ProfileRetrieveWidget(label: "Branch", data: 'student_branch', icon: Icons.assignment_rounded,),
                          SizedBox(height: 16,),
                          ProfileRetrieveWidget(label: "Phone number", data: 'student_phone', icon: Icons.phone_iphone_rounded,),
                          SizedBox(height: 16,),
                          ProfileRetrieveWidget(label: "Address", data: 'student_address', icon: Icons.location_on,),
                          SizedBox(height: 16,),
                          ProfileRetrieveWidget(label: "College ID", data: 'student_cid', icon: Icons.credit_card_rounded,),
                          SizedBox(height: 4,),
                        ],
                      ),
                    ),
                  ),



                  SizedBox(height: 16,),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: color_eventcard
                      ),
                      child: Column(
                        children: [

                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text(
                                'App',
                                style: CustomTextStyles.style_setting_titles,
                              ),
                            ),
                          ),

                          Divider(
                            color: Colors.grey[300]!, // Adjust color as needed
                            thickness: 0.1, // Adjust thickness as needed
                            // Adjust indent as needed
                          ),

                          GestureDetector(

                              onTap: (){

                                ScaffoldMessenger.of(context).
                                showSnackBar(SnackBar(content: Text('Themes coming soon', style: TextStyle(color: Colors.black),), backgroundColor: Colors.white, behavior: SnackBarBehavior.floating,));
                                // showDialog(
                                //   context: context,
                                //   builder: (BuildContext context) {
                                //     return AlertDialog(
                                //       backgroundColor: nightMode ? Colors.white : Colors.black,
                                //       title: Text(nightMode? 'Switch to light mode?' : 'Switch to dark mode?',
                                //         style: TextStyle(color: nightMode? Colors.black : Colors.white, fontFamily: 'Namun'),),
                                //       content: Text('Are you sure you want to switch theme?', style: TextStyle(color: nightMode? Colors.black : Colors.white,  fontFamily: 'Namun')),
                                //       actions: <Widget>[
                                //         TextButton(
                                //           onPressed: () {
                                //             Navigator.of(context).pop(); // Close the dialog
                                //           },
                                //           child:  Text('No', style: TextStyle(color: nightMode? Colors.black : Colors.white,  fontFamily: 'Namun')),
                                //         ),
                                //         TextButton(
                                //           onPressed: () {
                                //             _toggleThemePreference(!nightMode);
                                //             Navigator.of(context).pop(); // Close the dialog
                                //           },
                                //           child:  Text('Yes', style: TextStyle(color: nightMode? Colors.black : Colors.white,  fontFamily: 'Namun')),
                                //         ),
                                //       ],
                                //     );
                                //   },
                                // );
                              },

                              child: ProfileSettingWidget(text: nightMode? 'Dark mode' : 'Light mode', icon: nightMode? Icons.dark_mode_rounded : Icons.light_mode_rounded,)
                          ),

                          GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ContrbutePage()),
                                );
                              },
                              child: ProfileSettingWidget(text: 'Contribute', icon: Icons.people_alt_rounded,)
                          ),


                          GestureDetector(
                              onTap: (){_launchURLInDefaultBrowserOnAndroid(context, 'https://www.termsfeed.com/live/0390989a-87cf-40ed-93a9-5004d38038e3');
                              },
                              child: ProfileSettingWidget(text: 'Privacy policy', icon: Icons.library_books_rounded,)
                          ),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: color_eventcard
                      ),
                      child: Column(
                        children: [

                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text(
                                'Settings',
                                style: CustomTextStyles.style_setting_titles,
                              ),
                            ),
                          ),

                          Divider(
                            color: Colors.grey[300]!, // Adjust color as needed
                            thickness: 0.1, // Adjust thickness as needed
                            // Adjust indent as needed
                          ),


                          GestureDetector(
                              onTap: (){
                                ScaffoldMessenger.of(context).
                                showSnackBar(SnackBar(content: Text("This section will be available once the app is live on PlayStore",
                                    style: TextStyle(color: Colors.black)), behavior: SnackBarBehavior.floating, backgroundColor: Colors.white,));
                              },
                              child: ProfileSettingWidget(text: 'Rate us', icon: Icons.star_rate_rounded)
                          ),
                          GestureDetector(
                              onTap: (){
                                ScaffoldMessenger.of(context).
                                showSnackBar(SnackBar(content: Text("This section will be available once the app is live on PlayStore",
                                    style: TextStyle(color: Colors.black)), behavior: SnackBarBehavior.floating, backgroundColor: Colors.white,));
                              },
                              child: ProfileSettingWidget(text: 'Share app', icon: Icons.share_rounded,)),


                          GestureDetector(
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: const Text('Sign out', style: TextStyle(color: Colors.black, fontFamily: 'Namun'),),
                                      content: const Text('Are you sure you want to sign out?', style: TextStyle(color: Colors.black, fontFamily: 'Namun')),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Close the dialog
                                          },
                                          child: const Text('No', style: TextStyle(color: Colors.black, fontFamily: 'Namun')),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _signOut(); // Call your logout method
                                            Navigator.of(context).pop(); // Close the dialog
                                          },
                                          child: const Text('Yes', style: TextStyle(color: Colors.black, fontFamily: 'Namun')),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: ProfileSettingWidget(text: 'Sign out', icon: Icons.power_settings_new_rounded,)
                          ),
                          GestureDetector(
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: const Text('Delete data ', style: TextStyle(color: Colors.black, fontFamily: 'Namun'),),
                                      content: const Text('Deleting your data may take up to 48 hours and this is validated by your department HOD.'
                                          '\nAre you sure you want to request for deleting your data?', style: TextStyle(color: Colors.black, fontFamily: 'Namun')),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Close the dialog
                                          },
                                          child: const Text('No', style: TextStyle(color: Colors.black, fontFamily: 'Namun')),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context).
                                            showSnackBar(SnackBar(content: Text("Request sent for data deletion",
                                              style: TextStyle(color: Colors.black, fontFamily: 'Namun'),), behavior: SnackBarBehavior.floating, backgroundColor: Colors.white,));
                                            _signOut(); // Call your logout method
                                            Navigator.of(context).pop(); // Close the dialog
                                          },
                                          child: const Text('Yes', style: TextStyle(color: Colors.black, fontFamily: 'Namun')),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: ProfileSettingWidget(text: 'Delete data', icon: Icons.delete_rounded,)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16,),

            Visibility(
              visible: editMode,
                child: Column(
                  children: [

                    ProfileEditTextFields(TEC: TEC_phone, text: 'Phone number', icon: Icons.call_rounded),
                    ProfileEditTextFields(TEC: TEC_address, text: 'Address', icon: Icons.location_on_rounded),
                    ProfileEditTextFields(TEC: TEC_college, text: 'College', icon: Icons.school_rounded),
                    ProfileEditTextFields(TEC: TEC_collegeid, text: 'College ID', icon: Icons.credit_card_rounded),


                    Align(alignment: Alignment.bottomCenter,child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset('assets/images/boy_book.png', width: 150, height: 150,),
                    )),


                  ],
                ),
            ),


          ],
        ),
      ),
    );
  }

}

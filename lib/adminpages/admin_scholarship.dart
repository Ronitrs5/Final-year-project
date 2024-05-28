import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:major_project/classes/auth_service.dart';
import 'package:major_project/pages/start_page.dart';
import 'package:http/http.dart' as http;

class AdminScholarship extends StatefulWidget {
  const AdminScholarship({super.key});

  @override
  State<AdminScholarship> createState() => _AdminCommunityPageState();
}

class _AdminCommunityPageState extends State<AdminScholarship> {
  static const String fcmServerKey = "AAAAq3gzGJc:APA91bGIjXLTpqoS8wn4jzZ2Vmk68C7ETDVNwwJJNmP8bQf_uruCD8CYrCiBAwI7W07VJ_WDW6MEqXoJo1r3rJ2npSUqn2fJrB_QeCvwz0wZ4v-1VH5janO-xq4y0RKV38rZvjgjkFL_";

  static Future<void> sendPushMessage(String title, String body) async {
    try {
      print("trying started");
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$fcmServerKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'title': title,
              'body': body,
            },
            'notification': <String, dynamic>{
              'title': title,
              'body': body,
              'android_channel': 'acdaa',
            },
            'condition': "'event_notification_all' in topics",
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Success NOTI");
      } else {
        print("Failed NOTI");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Something went wrong with NOTIFICATION: $e');
      }
    }
  }

  String active = "";
  String type = "";
  bool isPublishing = false;
  TextEditingController TEC_title = TextEditingController();
  TextEditingController TEC_no_people = TextEditingController();
  TextEditingController TEC_desc = TextEditingController();
  TextEditingController TEC_link = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          // title, image, no of people, desc, available

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextField(
                      controller: TEC_title,
                      textInputAction: TextInputAction.next,
                      maxLines: null, // Set maxLines to null for multiline input
                      decoration: const InputDecoration(
                          labelText: 'Scholarship title',
                          prefixIcon: Icon(Icons.title),
                          border: OutlineInputBorder(),
                          // errorText: isUsernameEmpty
                          //     ? 'Please enter username'
                          //     : null,
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              )
                          )
                      ),
                    ),
                  ),



                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          floatingLabelStyle: TextStyle(color: Colors.grey[700]),
                          prefixIcon: const Icon(Icons.filter_list_alt),
                          contentPadding: const EdgeInsets.all(16),
                          labelText: 'Scholarship type',
                        ),icon: const Icon(Icons.arrow_drop_down_outlined),
                        style: const TextStyle(color: Colors.black),
                        dropdownColor: Colors.white,

                        items: const [
                          DropdownMenuItem(value: 'Government', child: Text('Government',)),
                          DropdownMenuItem(value: 'Private', child: Text('Private',)),


                        ],
                        onChanged: (value) {
                          setState(() {
                            type = value!;
                          });
                        }
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextField(
                      controller: TEC_desc,
                      textInputAction: TextInputAction.next,
                      maxLines: null, // Set maxLines to null for multiline input
                      decoration: const InputDecoration(
                          labelText: 'Eligibility',
                          prefixIcon: Icon(Icons.description_rounded),
                          border: OutlineInputBorder(),
                          // errorText: isUsernameEmpty
                          //     ? 'Please enter username'
                          //     : null,
                          errorBorder: OutlineInputBorder(
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
                      controller: TEC_link,
                      textInputAction: TextInputAction.next,
                      maxLines: null, // Set maxLines to null for multiline input
                      decoration: const InputDecoration(
                          labelText: 'Registration link',
                          prefixIcon: Icon(Icons.link),
                          border: OutlineInputBorder(),
                          // errorText: isUsernameEmpty
                          //     ? 'Please enter username'
                          //     : null,
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              )
                          )
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),



          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: isPublishing ? null : (){

                  uploadCommunity();

                },
                child: isPublishing ? Container(width: 20, height: 20,child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2,)) :Text(
                  "Publish scholarship",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future<void> uploadCommunity() async {
    try {
      setState(() {
        isPublishing = true;
      });

      String title = TEC_title.text.trim();
      String description = TEC_desc.text.trim();

      if(title.isEmpty || description.isEmpty  || type == ""){
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("All fields are mandatory", style: TextStyle(color: Colors.white),), backgroundColor: Colors.black, behavior: SnackBarBehavior.floating,));
        return;
      }


      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference events = firestore.collection('scholarship');

      DocumentReference docRef = await events.add({
        'title': title,
        'desc': description,
        'type': type,
        'url': TEC_link.text.trim(),
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Scholarship was uploaded", style: TextStyle(color: Colors.white),), backgroundColor: Colors.black, behavior: SnackBarBehavior.floating,));

      sendPushMessage("$title is here for you", "Check the eligibility and grab the scholarship now!");

      setState(() {
        isPublishing = false;
      });

    } catch (e) {
      setState(() {
        isPublishing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error adding event data to Firestore: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
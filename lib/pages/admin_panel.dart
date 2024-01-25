import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {


  String eventType = "";

  TextEditingController tec_title = new TextEditingController();
  TextEditingController tec_description = new TextEditingController();
  TextEditingController tec_venue = new TextEditingController();
  TextEditingController tec_date = new TextEditingController();
  TextEditingController tec_fees = new TextEditingController();
  TextEditingController tec_number = new TextEditingController();
  TextEditingController tec_link = new TextEditingController();
  TextEditingController tec_deadline = new TextEditingController();
  TextEditingController tec_extra = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel",style: TextStyle(color: Colors.white),),
          automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            const Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Text("Enter details of the event"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                controller: tec_title,
                // focusNode: usernameFocus,
                // onEditingComplete: () {
                //   FocusScope.of(context).requestFocus(passwordFocus);
                // },
                textInputAction: TextInputAction.next,
                maxLines: null, // Set maxLines to null for multiline input
                decoration: const InputDecoration(
                    labelText: 'Event title',
                    prefixIcon: Icon(Icons.title),
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
                
                controller: tec_description,
                // focusNode: usernameFocus,
                // onEditingComplete: () {
                //   FocusScope.of(context).requestFocus(passwordFocus);
                // },
                textInputAction: TextInputAction.next,
                maxLines: null,
                decoration: const InputDecoration(
                    labelText: 'Event description',

                    prefixIcon: Icon(Icons.description),
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
                controller: tec_venue,

                textInputAction: TextInputAction.next,
                maxLines: null, // Set maxLines to null for multiline input
                decoration: const InputDecoration(
                  labelText: 'Event venue',
                  prefixIcon: Icon(Icons.place),
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                controller: tec_date,

                textInputAction: TextInputAction.next,
                maxLines: null, // Set maxLines to null for multiline input
                decoration: const InputDecoration(
                  labelText: 'Event date and time',
                  prefixIcon: Icon(Icons.date_range),
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: TextField(
                      controller: tec_fees,

                      textInputAction: TextInputAction.next,
                      maxLines: null, // Set maxLines to null for multiline input
                      decoration: const InputDecoration(
                        labelText: 'Fees',
                        prefixIcon: Icon(Icons.currency_rupee),
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                    child: TextField(
                      controller: tec_number,

                      textInputAction: TextInputAction.next,
                      maxLines: null, // Set maxLines to null for multiline input
                      decoration: const InputDecoration(
                        labelText: 'Contact number',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.safety_divider),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    contentPadding: EdgeInsets.all(16),
                    labelText: 'Event type',
                  ),icon: const Icon(Icons.arrow_drop_down_outlined),

                  items: const [
                    DropdownMenuItem(value: 'Technical Event', child: Text('Technical Event',)),
                    DropdownMenuItem(value: 'Non-Technical Event', child: Text('Non-Technical Event')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      eventType=value!;
                    });
                  }  // Handle dropdown value change
              ),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: Divider(thickness: 1,),
            ),

            const Text("Registration details"),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                controller: tec_link,

                textInputAction: TextInputAction.next,
                maxLines: null, // Set maxLines to null for multiline input
                decoration: const InputDecoration(
                  labelText: 'Registration link',
                  prefixIcon: Icon(Icons.link),
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                controller: tec_deadline,

                textInputAction: TextInputAction.next,
                maxLines: null, // Set maxLines to null for multiline input
                decoration: const InputDecoration(
                  labelText: 'Registration deadline',
                  prefixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                controller: tec_extra,

                textInputAction: TextInputAction.next,
                maxLines: null, // Set maxLines to null for multiline input
                decoration: const InputDecoration(
                  labelText: 'Additional details',
                  prefixIcon: Icon(Icons.more),
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
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
                    setEventData();
                  },

                  child: const Text("Publish event",
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
    );
  }

  Future<void> setEventData() async {
    try {
      String title = tec_title.text.toString();
      String description = tec_description.text;
      String venue = tec_venue.text;
      String date = tec_date.text;
      String fees = tec_fees.text;
      String number = tec_number.text;
      String link = tec_link.text;
      String deadline = tec_deadline.text;
      String extra = tec_extra.text;

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference events = firestore.collection('events');

      await events.add({
        'title': title,
        'description': description,
        'venue': venue,
        'date': date,
        'fees': fees,
        'number': number,
        'eventType': eventType,
        'registrationLink': link,
        'registrationDeadline': deadline,
        'additionalDetails': extra,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Event published'),
          duration: Duration(seconds: 2),
        ),
      );
      print('Event data added to Firestore successfully!');
    } catch (e) {
      print('Error adding event data to Firestore: $e');
    }
  }
}


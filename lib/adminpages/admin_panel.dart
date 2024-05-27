import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;


class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {

  File? _image;
  List<String> eventTitles = []; // List to store retrieved titles
  bool isPublishing = false;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
      }
    });
  }
  @override
  void initState() {
    super.initState();
    // Fetch titles when the widget is initialized
    fetchEventTitles();
  }

  void fetchEventTitles() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference events = firestore.collection('majorevent');

      QuerySnapshot querySnapshot = await events.get();
      List<String> titles = [];

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        // Assuming 'title' is the field in your Firestore documents
        String title = documentSnapshot['title'] ?? '';
        titles.add(title);
      }

      // Update the state with the retrieved titles
      setState(() {
        eventTitles = titles;
      });
    } catch (e) {
    }
  }

  String eventType = "";
  String majorEvent = "";

  TextEditingController tec_title = TextEditingController();
  TextEditingController tec_description = TextEditingController();
  TextEditingController tec_venue = TextEditingController();
  TextEditingController tec_date = TextEditingController();
  TextEditingController tec_fees = TextEditingController();
  TextEditingController tec_number = TextEditingController();
  TextEditingController tec_link = TextEditingController();
  TextEditingController tec_deadline = TextEditingController();
  TextEditingController tec_extra = TextEditingController();

  static const String fcmServerKey = "AAAAq3gzGJc:APA91bGIjXLTpqoS8wn4jzZ2Vmk68C7ETDVNwwJJNmP8bQf_uruCD8CYrCiBAwI7W07VJ_WDW6MEqXoJo1r3rJ2npSUqn2fJrB_QeCvwz0wZ4v-1VH5janO-xq4y0RKV38rZvjgjkFL_";

  static Future<void> sendPushMessage(String title, String body) async {
    try {
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
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print('Something went wrong with NOTIFICATION: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Admin Panel",style: TextStyle(color: Colors.white),),
      //     automaticallyImplyLeading: false,
      //   backgroundColor: Colors.blue,
      //   actions: [
      //     IconButton(onPressed: (){
      //       Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(builder: (context) => AdminEditPage()),
      //       );
      //     }, icon: Icon(Icons.list, color: Colors.white,))
      //   ],
      // ),

      body: Column(
        children: [

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Text("Enter details of the event"),
                  ),


                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: DropdownButtonFormField<String>(
                      value: null, // Set initial value to null
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.stream),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        contentPadding: EdgeInsets.all(16),
                        labelText: 'Major event',
                      ),
                      icon: const Icon(Icons.arrow_drop_down_outlined),
                      items: eventTitles.map((title) {
                        return DropdownMenuItem(
                          value: title,
                          child: Text(title),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          majorEvent = value!;
                        });
                      },
                    ),
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
                      textInputAction: TextInputAction.newline,
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
                      textInputAction: TextInputAction.newline,
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
                    child: GestureDetector(
                      onTap: _getImage,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey, // Color of the border
                            style: BorderStyle.solid, // Style of the border
                            width: 1, // Width of the border
                          ),
                        ), // Show the selected image if not null
                        width: double.infinity,
                        height: 300,
                        child: _image == null
                            ? const Center(child: Text("Click to add image"))
                            : Image.file(_image!),
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
                onPressed: isPublishing ? null : () {
                  setEventData();
                },
                child: isPublishing
                    ? Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2,)),
                )
                    : const Text(
                  "Publish event",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }


// Future<void> setEventData() async {
//   try {
//
//     setState(() {
//       isPublishing = true;
//     });
//
//     String title = tec_title.text.toString();
//     String description = tec_description.text;
//     String venue = tec_venue.text;
//     String date = tec_date.text;
//     String fees = tec_fees.text;
//     String number = tec_number.text;
//     String link = tec_link.text;
//     String deadline = tec_deadline.text;
//     String extra = tec_extra.text;
//
//     // Ensure _image is not null before proceeding
//     if (_image != null) {
//       int quality = 50; // Initial quality setting
//       int maxFileSize = 100 * 640; // 100kb in bytes
//
//       Uint8List compressedUint8List;
//
//       do {
//         // Compress the image
//         List<int> compressedImage = await FlutterImageCompress.compressWithList(
//           _image!.readAsBytesSync(),
//           quality: quality,
//         );
//
//         // Decode the compressed image using the image package
//         img.Image? decodedImage = img.decodeImage(Uint8List.fromList(compressedImage));
//
//         // Encode the image to PNG format (or any other format supported by putData)
//         List<int> encodedImage = img.encodePng(decodedImage!);
//
//         compressedUint8List = Uint8List.fromList(encodedImage);
//
//         // Adjust the quality for the next iteration
//         quality -= 5;
//
//       } while (compressedUint8List.lengthInBytes > maxFileSize && quality >= 0);
//
//       final Reference storageReference = FirebaseStorage.instance
//           .ref()
//           .child('event_images')
//           .child('image_${DateTime.now().millisecondsSinceEpoch}.png');
//
//       await storageReference.putData(compressedUint8List);
//       final String imageUrl = await storageReference.getDownloadURL();
//
//       // Store event data in Firestore, including the image URL
//       FirebaseFirestore firestore = FirebaseFirestore.instance;
//       CollectionReference events = firestore.collection('subevent');
//
//       DocumentReference docRef = await events.add({
//         'title': title,
//         'description': description,
//         'venue': venue,
//         'date': date,
//         'fees': fees,
//         'number': number,
//         'eventType': eventType,
//         'registrationLink': link,
//         'registrationDeadline': deadline,
//         'additionalDetails': extra,
//         'majorEvent': majorEvent,
//         'imageUrl': imageUrl, // Store the image URL in Firestore
//       });
//
//       String docId = docRef.id;
//       sendPushMessage("$title is waiting for you to register.", "Under: $majorEvent. Tap to see more information");
//
//       setState(() {
//         isPublishing = false;
//       });
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(title),
//             content: const Text('Event has been published. Do you want to clear all the data from above input fields?'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   setState(() {
//                     tec_title.clear();
//                     tec_description.clear();
//                     tec_venue.clear();
//                     tec_date.clear();
//                     tec_fees.clear();
//                     tec_number.clear();
//                     tec_link.clear();
//                     tec_deadline.clear();
//                     tec_extra.clear();
//                     _image == null;
//                   });
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('Yes'),
//               ),
//
//               TextButton(onPressed: (){Navigator.of(context).pop();}, child: const Text("No"))
//             ],
//           );
//         },
//       );
//
//
//     } else {
//       setState(() {
//         isPublishing = false;
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.red,
//           content: Text('No image selected'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//
//     }
//   } catch (e) {
//     setState(() {
//       isPublishing = false;
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         backgroundColor: Colors.red,
//         content: Text('Error adding event data to Firestore: $e'),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
// }

  Future<void> setEventData() async {
    try {
      setState(() {
        isPublishing = true;
      });

      String title = tec_title.text.toString();
      String description = tec_description.text;
      String venue = tec_venue.text;
      String date = tec_date.text;
      String fees = tec_fees.text;
      String number = tec_number.text;
      String link = tec_link.text;
      String deadline = tec_deadline.text;
      String extra = tec_extra.text;

      if (_image != null) {
        final Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('event_images')
            .child('image_${DateTime.now().millisecondsSinceEpoch}.png');

        await storageReference.putFile(_image!);
        final String imageUrl = await storageReference.getDownloadURL();

        FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference events = firestore.collection('subevent');

        DocumentReference docRef = await events.add({
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
          'majorEvent': majorEvent,
          'imageUrl': imageUrl,
        });

        String docId = docRef.id;
        sendPushMessage("$title is waiting for you to register.", "Under: $majorEvent. Tap to see more information");

        setState(() {
          isPublishing = false;
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: const Text('Event has been published. Do you want to clear all the data from above input fields?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      tec_title.clear();
                      tec_description.clear();
                      tec_venue.clear();
                      tec_date.clear();
                      tec_fees.clear();
                      tec_number.clear();
                      tec_link.clear();
                      tec_deadline.clear();
                      tec_extra.clear();
                      _image == null;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes'),
                ),
                TextButton(onPressed: (){Navigator.of(context).pop();}, child: const Text("No"))
              ],
            );
          },
        );
      } else {
        setState(() {
          isPublishing = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('No image selected'),
            duration: Duration(seconds: 2),
          ),
        );
      }
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


  Future<void> sendNotification(String eventId, String title, String description) async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      // Get the FCM token for each user and send a notification
      QuerySnapshot users = await FirebaseFirestore.instance.collection('students_registration_data').get();

      for (QueryDocumentSnapshot user in users.docs) {
        String token = user['fcmToken'];

        if (token != null && token.isNotEmpty) {
          // Customize the notification payload as needed
          await messaging.sendMessage(
            to: token,
            data: {
              'eventId': eventId,
              'title': 'New Event: $title',
              'body': description,
            },
          );
        }
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  //
  // Future<void> setEventData() async {
  //   try {
  //
  //     setState(() {
  //       isPublishing = true;
  //     });
  //
  //     String title = tec_title.text.toString();
  //     String description = tec_description.text;
  //     String venue = tec_venue.text;
  //     String date = tec_date.text;
  //     String fees = tec_fees.text;
  //     String number = tec_number.text;
  //     String link = tec_link.text;
  //     String deadline = tec_deadline.text;
  //     String extra = tec_extra.text;
  //
  //     // Ensure _image is not null before proceeding
  //     if (_image != null) {
  //       int quality = 50; // Initial quality setting
  //       int maxFileSize = 100 * 640; // 100kb in bytes
  //
  //       Uint8List compressedUint8List;
  //
  //       do {
  //         // Compress the image
  //         List<int> compressedImage = await FlutterImageCompress.compressWithList(
  //           _image!.readAsBytesSync(),
  //           quality: quality,
  //         );
  //
  //         // Decode the compressed image using the image package
  //         img.Image? decodedImage = img.decodeImage(Uint8List.fromList(compressedImage));
  //
  //         // Encode the image to PNG format (or any other format supported by putData)
  //         List<int> encodedImage = img.encodePng(decodedImage!);
  //
  //         compressedUint8List = Uint8List.fromList(encodedImage);
  //
  //         // Adjust the quality for the next iteration
  //         quality -= 5;
  //
  //       } while (compressedUint8List.lengthInBytes > maxFileSize && quality >= 0);
  //
  //       final Reference storageReference = FirebaseStorage.instance
  //           .ref()
  //           .child('event_images')
  //           .child('image_${DateTime.now().millisecondsSinceEpoch}.png');
  //
  //       await storageReference.putData(compressedUint8List);
  //       final String imageUrl = await storageReference.getDownloadURL();
  //
  //       // Store event data in Firestore, including the image URL
  //       FirebaseFirestore firestore = FirebaseFirestore.instance;
  //       CollectionReference events = firestore.collection('subevent');
  //
  //       await events.add({
  //         'title': title,
  //         'description': description,
  //         'venue': venue,
  //         'date': date,
  //         'fees': fees,
  //         'number': number,
  //         'eventType': eventType,
  //         'registrationLink': link,
  //         'registrationDeadline': deadline,
  //         'additionalDetails': extra,
  //         'majorEvent': majorEvent,
  //         'imageUrl': imageUrl, // Store the image URL in Firestore
  //       });
  //
  //
  //       setState(() {
  //         isPublishing = false;
  //       });
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: Text(title),
  //             content: const Text('Event has been published. Do you want to clear all the data from above input fields?'),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   setState(() {
  //                     tec_title.clear();
  //                     tec_description.clear();
  //                     tec_venue.clear();
  //                     tec_date.clear();
  //                     tec_fees.clear();
  //                     tec_number.clear();
  //                     tec_link.clear();
  //                     tec_deadline.clear();
  //                     tec_extra.clear();
  //                     _image == null;
  //                   });
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text('Yes'),
  //               ),
  //
  //               TextButton(onPressed: (){Navigator.of(context).pop();}, child: const Text("No"))
  //             ],
  //           );
  //         },
  //       );
  //
  //     } else {
  //       setState(() {
  //         isPublishing = false;
  //       });
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           backgroundColor: Colors.red,
  //           content: Text('No image selected'),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isPublishing = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text('Error adding event data to Firestore: $e'),
  //         duration: const Duration(seconds: 2),
  //       ),
  //     );
  //   }
  // }



  // Future<String> uploadImageToFirestore() async {
  //   try {
  //     final picker = ImagePicker();
  //     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //     if (pickedFile == null) {
  //       print('No image selected');
  //       return ''; // Return an empty string if no image is selected
  //     }
  //
  //     File imageFile = File(pickedFile.path);
  //
  //     // Check the file size
  //     int maxSizeAllowed = 500 * 1024; // 500 KB in bytes
  //     int fileSize = imageFile.lengthSync();
  //
  //     if (fileSize > maxSizeAllowed) {
  //       print('Image size exceeds the maximum allowed size of 500 KB');
  //       return ''; // Return an empty string if the size is too large
  //     }
  //
  //     final firebaseStorageRef =
  //     FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.png');
  //
  //     await firebaseStorageRef.putFile(imageFile);
  //
  //     // Get the download URL of the uploaded image
  //     String imageUrl = await firebaseStorageRef.getDownloadURL();
  //     return imageUrl;
  //   } catch (e) {
  //     print('Error uploading image to Firestore: $e');
  //     return ''; // Return an empty string if there's an error
  //   }
  // }

  //
  //
  // Future<String> uploadImageToFirestore() async {
  //   try {
  //     if (_image != null) {
  //       int quality = 50; // Initial quality setting
  //       int maxFileSize = 100 * 640; // 100kb in bytes
  //
  //       Uint8List compressedUint8List;
  //
  //       do {
  //         // Compress the image
  //         List<int> compressedImage = await FlutterImageCompress.compressWithList(
  //           _image!.readAsBytesSync(),
  //           quality: quality,
  //         );
  //
  //         // Decode the compressed image using the image package
  //         img.Image? decodedImage = img.decodeImage(Uint8List.fromList(compressedImage)!);
  //
  //         // Encode the image to PNG format (or any other format supported by putData)
  //         List<int> encodedImage = img.encodePng(decodedImage!);
  //
  //         compressedUint8List = Uint8List.fromList(encodedImage);
  //
  //         // Adjust the quality for the next iteration
  //         quality -= 5;
  //
  //       } while (compressedUint8List.lengthInBytes > maxFileSize && quality >= 0);
  //
  //       final Reference storageReference = FirebaseStorage.instance
  //           .ref()
  //           .child('major_event_images')
  //           .child('image_${DateTime.now().millisecondsSinceEpoch}.png');
  //
  //       await storageReference.putData(compressedUint8List);
  //       final String imageUrl = await storageReference.getDownloadURL();
  //
  //       FirebaseFirestore firestore = FirebaseFirestore.instance;
  //       CollectionReference events = firestore.collection('majorevent');
  //
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           backgroundColor: Colors.green,
  //           content: Text('Major Event Published'),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //       print('Event saved to Firestore');
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           backgroundColor: Colors.red,
  //           content: Text('No image selected'),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     print('Error saving event: $e');
  //   }
  // }



}


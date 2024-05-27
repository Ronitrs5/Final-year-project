import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class AdminMajorEvent extends StatefulWidget {
  const AdminMajorEvent({super.key});

  @override
  State<AdminMajorEvent> createState() => _AdminMajorEventState();
}

class _AdminMajorEventState extends State<AdminMajorEvent> {
  String departmentInCharge = "";
  String majorEventType = "";
  File? _image;
  bool isLoading = false;



  TextEditingController tec_major_event_title = TextEditingController();

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
              'android_channel': 'acd',
              'icon': 'assets/images/food1.png',
            },
            'condition': "'event_notification_all' in topics",
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Success");
      } else {
        print("Failed");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Something went wrong with NOTIFICATION: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: TextField(
                        controller: tec_major_event_title,
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
                      child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.stream),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            contentPadding: EdgeInsets.all(16),
                            labelText: 'Department in charge',
                          ),icon: const Icon(Icons.arrow_drop_down_outlined),

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
                              // roadSize=value!;
                              departmentInCharge = value!;
                            });
                          }  // Handle dropdown value change
                      ),
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
                            DropdownMenuItem(value: 'Both', child: Text('Both')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              majorEventType=value!;
                            });
                          }  // Handle dropdown value change
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
                  onPressed: isLoading ? null : () {
                    saveEventToFirestore();
                  },
                  child: isLoading
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

  void saveEventToFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    String eventTitle = tec_major_event_title.text.trim(); // Replace with actual title

    try {
      setState(() {
        isLoading = true;
      });
      if (_image != null) {
        final Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('major_event_images')
            .child('image_${DateTime.now().millisecondsSinceEpoch}.png');

        await storageReference.putFile(_image!);
        final String imageUrl = await storageReference.getDownloadURL();

        FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference events = firestore.collection('majorevent');

        await events.add({
          'title': eventTitle,
          'departmentInCharge': departmentInCharge,
          'majorEventType': majorEventType,
          'majorImageUrl': imageUrl,
          // Add more fields as needed
        });

        sendPushMessage(eventTitle, "Deparment of $departmentInCharge has published a new event");
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Major Event Published'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        setState(() {
          isLoading = false;
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
        isLoading = false;
      });
    }
  }


// void saveEventToFirestore() async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //   String eventTitle = tec_major_event_title.text.trim(); // Replace with actual title
  //
  //   try {
  //     setState(() {
  //       isLoading = true;
  //     });
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
  //           .child('major_event_images')
  //           .child('image_${DateTime.now().millisecondsSinceEpoch}.png');
  //
  //       await storageReference.putData(compressedUint8List);
  //       final String imageUrl = await storageReference.getDownloadURL();
  //
  //       FirebaseFirestore firestore = FirebaseFirestore.instance;
  //       CollectionReference events = firestore.collection('majorevent');
  //
  //       await events.add({
  //         'title': eventTitle,
  //         'departmentInCharge': departmentInCharge,
  //         'majorEventType': majorEventType,
  //         'majorImageUrl': imageUrl,
  //         // Add more fields as needed
  //       });
  //
  //       sendPushMessage(eventTitle, "Deparment of $departmentInCharge has published a new event");
  //       setState(() {
  //         isLoading = false;
  //       });
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           backgroundColor: Colors.green,
  //           content: Text('Major Event Published'),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           backgroundColor: Colors.red,
  //           content: Text('No image selected'),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }
  //
}
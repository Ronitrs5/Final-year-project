import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/sidebar/events/majoreventdir/major_technical.dart';
import 'package:major_project/theme/style_card_title.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class SubEventsPage extends StatelessWidget {
  final String majorEventTitle;

  const SubEventsPage({required this.majorEventTitle, Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundScaffold,
      appBar: AppBar(
        backgroundColor: backgroundAppbar,
        title: Text('$majorEventTitle', style: CustomTextStyles.style_appbar,),
        iconTheme: const IconThemeData(color: Colors.white),

      ),
      body: FutureBuilder(
        future: getTechnicalEventData(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black,),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            List<Map<String, dynamic>> technicalEvents = snapshot.data!;
            if (technicalEvents.isEmpty) {
              return const Center(
                child: Text("No events listed.", style: TextStyle(color: Colors.white),),
              );
            } else {
              return ListView.builder(
                itemCount: technicalEvents.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> event = technicalEvents[index];
                  return TechnicalEventCard(event: event);
                },
              );
            }
          }
        },
      ),
    );
  }
  Future<List<Map<String, dynamic>>> getTechnicalEventData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference events = firestore.collection('subevent');

    // Query only technical events
    QuerySnapshot querySnapshot =
    await events.where('majorEvent', isEqualTo: '$majorEventTitle').get();

    List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
        .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
        .toList();

    return technicalEventData;
  }
}

class TechnicalEventCard extends StatelessWidget {
  final Map<String, dynamic> event;
  TechnicalEventCard({required this.event});

  Future<String> fetchImage() async {
    String eventTitle = event['imageUrl'];

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference events = firestore.collection('majorevent');

      QuerySnapshot querySnapshot =
      await events.where('title', isEqualTo: eventTitle).get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs[0]['majorImageUrl'];
      } else {
        print('No event found with title: $eventTitle');
        return '';
      }
    } catch (e) {
      print('Error fetching image: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            // Navigate to a new page with event details when tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailsPage(event: event),
              ),
            );
          },
          child: Card(
            // color: Color(0xff27222c),
            color: color_eventcard,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: const BorderSide(
                color: Color(0xff2b2631),
                width: 1.0,
              ),
            ),
            margin: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                    child: Text("${event['title']}", style: CustomTextStyles.style_card_title),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Divider(thickness: 1,color: Colors.white10,),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Text("• Venue: ${event['venue']}", style: CustomTextStyles.style_card_desc),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                    child: Text("• Date: ${event['date']}",style: CustomTextStyles.style_card_desc),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 0, 4),
                        child: Text("View details", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),),
                      ),
                      Icon(Icons.navigate_next, color: Colors.blueAccent,)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(4.0),
        //   child: Divider(thickness: 1,color: Colors.white10,),
        // ),


      ],
    );
  }
}

// Color _generateRandomColor() {
//   Random random = Random();
//   return Color.fromARGB(
//     255,
//     random.nextInt(256),
//     random.nextInt(256),
//     random.nextInt(256),
//   );
// }

class EventDetailsPage extends StatelessWidget {
  final Map<String, dynamic> event;
  EventDetailsPage({required this.event});

  Future<String> fetchImage() async{
    String eventTitle = event['title'];

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference events = firestore.collection('subevent');

      QuerySnapshot querySnapshot =
       await events.where('title', isEqualTo: eventTitle).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one document with the given title
        return querySnapshot.docs[0]['imageUrl'];
      } else {
        print('No event found with title: $eventTitle');
        return '';
      }
    } catch (e) {
      print('Error fetching image: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundScaffold,
      appBar: AppBar(
        backgroundColor: backgroundAppbar,
        title: Text("${event['title']}", style: CustomTextStyles.style_appbar,),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder<String>(
                      future: fetchImage(),  // Wrap the existing result in Future.value
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          // While waiting for the result, show a loading indicator or a placeholder image
                          return const CircularProgressIndicator(); // Replace with your loading indicator or placeholder image
                        } else if (snapshot.hasError) {
                          // If there's an error fetching the image, log the error and show a placeholder image
                          print("Error fetching image: ${snapshot.error}");
                          return const Text("");
                        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                          // If no image URL is retrieved, show a placeholder image
                          return const Text("");
                        } else {
                          // If an image URL is retrieved, display the image using Image.network
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(snapshot.data!),
                            ),
                          );
                        }
                      },
                    ),



                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.green,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                color: Colors.green[100]
                            ),

                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text("About event", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'Namun'),),
                            )
                        ),
                      ),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                    child: Text("Venue:", style: CustomTextStyles.style_card_title,),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        // border: Border.all(
                        //   color: Colors.grey, // You can choose the color of the border
                        //   width: 1.0, // You can choose the width of the border
                        // ),
                        // borderRadius: const BorderRadius.all(Radius.circular(8.0)), // You can choose the border radius
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("${event['venue']}", style: CustomTextStyles.style_card_desc),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16,),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Text("Event date:", style: CustomTextStyles.style_card_title),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        // border: Border.all(
                        //   color: Colors.grey, // You can choose the color of the border
                        //   width: 1.0, // You can choose the width of the border
                        // ),
                        // borderRadius: const BorderRadius.all(Radius.circular(8.0)), // You can choose the border radius
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("${event['date']}", style:CustomTextStyles.style_card_desc),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16,),


                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                    child: Text("Details:", style: CustomTextStyles.style_card_title),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color_eventcard,
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)), // You can choose the border radius
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("${event['description']}", style:CustomTextStyles.style_card_desc),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16,),


                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                    child: Text("Additional information:", style: CustomTextStyles.style_card_title),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration:  BoxDecoration(
                        color: color_eventcard,
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)), // You can choose the border radius
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("${event['additionalDetails']}", style:CustomTextStyles.style_card_desc),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(thickness: 1,),
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.green,
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                color: Colors.green[100]
                            ),

                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text("Registration details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'Namun'),),
                            )
                        ),
                      ),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                    child: Text("Contact:", style: CustomTextStyles.style_card_title),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                        child: Container(
                          decoration: const BoxDecoration(
                            // border: Border.all(
                            //   color: Colors.grey, // You can choose the color of the border
                            //   width: 1.0, // You can choose the width of the border
                            // ),
                            // borderRadius: const BorderRadius.all(Radius.circular(8.0)), // You can choose the border radius
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text("${event['number']}", style: CustomTextStyles.style_card_desc),
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       String num = event['number'];
                          //       _makingPhoneCall();
                          //     },
                          //     child: Icon(Icons.call, color: Colors.grey[700]),
                          //   ),
                          // ),

                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: "${event['number']}"));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('"${event['number']}" copied to clipboard.'),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: Icon(Icons.content_copy, color: Colors.grey[700],),
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Divider(thickness: 1,),
                  // ),

                  const SizedBox(height: 16,),


                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                    child: Text("Event fees:", style: CustomTextStyles.style_card_title),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        // border: Border.all(
                        //   color: Colors.grey, // You can choose the color of the border
                        //   width: 1.0, // You can choose the width of the border
                        // ),
                        // borderRadius: const BorderRadius.all(Radius.circular(8.0)), // You can choose the border radius
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("₹${event['fees']}", style: CustomTextStyles.style_card_desc),
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Divider(thickness: 1,),
                  // ),

                  const SizedBox(height: 16,),


                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                    child: Text("Registration link:", style: CustomTextStyles.style_card_title),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                          child: Container(
                            decoration: const BoxDecoration(
                              // border: Border.all(
                              //   color: Colors.grey, // You can choose the color of the border
                              //   width: 1.0, // You can choose the width of the border
                              // ),
                              // borderRadius: const BorderRadius.all(Radius.circular(8.0)), // You can choose the border radius
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text("${event['registrationLink']}", style: TextStyle(color: Colors.blue,fontFamily: 'Namun'),),
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: "${event['registrationLink']}"));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              // content: Text('"${event['registrationLink']}" copied to clipboard.'),
                              content: Text('Link copied to clipboard.'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.green,

                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: Icon(Icons.content_copy, color: Colors.grey[700],),
                        ),
                      ),
                    ],
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Divider(thickness: 1,),
                  // ),

                  const SizedBox(height: 16,),


                  const Padding(
                    padding: EdgeInsets.fromLTRB(18, 0, 8, 0),
                    child: Text("Registration deadline:", style: CustomTextStyles.style_card_title),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        // border: Border.all(
                        //   color: Colors.grey, // You can choose the color of the border
                        //   width: 1.0, // You can choose the width of the border
                        // ),
                        // borderRadius: const BorderRadius.all(Radius.circular(8.0)), // You can choose the border radius
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("${event['registrationDeadline']}", style: CustomTextStyles.style_card_desc),
                      ),
                    ),
                  ),



                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white
                ),
                onPressed: () async{
                  // launchURL("${event['registrationLink']}");

                  try {
                    await launch("${event['registrationLink']}", forceSafariVC: false, forceWebView: false);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("The URL doesn't exist"),
                          duration: Duration(seconds: 2),
                        ));
                  }
                },

                child: const Text("Register",
                  style: TextStyle(
                      color: Colors.black,
                    fontFamily: 'Namun',
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void launchURL(String url) async {
    try {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}

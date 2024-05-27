import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';


class AdminEditPage extends StatefulWidget {
  const AdminEditPage({super.key});

  @override
  State<AdminEditPage> createState() => _AdminEditPageState();
}

class _AdminEditPageState extends State<AdminEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit events"),
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
                child: Text("No events listed."),
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
    CollectionReference events = firestore.collection('events');

    // Query only technical events
    QuerySnapshot querySnapshot =
    await events.get();

    List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
        .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
        .toList();

    return technicalEventData;
  }
}

class TechnicalEventCard extends StatelessWidget {
  final Map<String, dynamic> event;

  const TechnicalEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: Colors.grey[300]!,
            width: 1.0,
          ),
        ),
        margin: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                child: Text("${event['title']}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Divider(thickness: 1,),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text("• Venue: ${event['venue']}"),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
                child: Text("• Date: ${event['date']}"),
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
    );
  }
}

class EventDetailsPage extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventDetailsPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${event['title']}"),

        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.edit))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        child: Text("About event", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                      )
                  ),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text("Details:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // You can choose the color of the border
                    width: 1.0, // You can choose the width of the border
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)), // You can choose the border radius
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("${event['description']}"),
                ),
              ),
            ),

            const SizedBox(height: 16,),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Divider(thickness: 1,),
            // ),

            const Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text("Venue:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // You can choose the color of the border
                    width: 1.0, // You can choose the width of the border
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)), // You can choose the border radius
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("${event['venue']}"),
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Divider(thickness: 1,),
            // ),

            const SizedBox(height: 16,),

            const Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text("Event date:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // You can choose the color of the border
                    width: 1.0, // You can choose the width of the border
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)), // You can choose the border radius
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("${event['date']}"),
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Divider(thickness: 1,),
            // ),

            const SizedBox(height: 16,),

            const Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text("Additional information:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // You can choose the color of the border
                    width: 1.0, // You can choose the width of the border
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)), // You can choose the border radius
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("${event['additionalDetails']}"),
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
                        child: Text("Registration details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                      )
                  ),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text("Contact:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // You can choose the color of the border
                    width: 1.0, // You can choose the width of the border
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)), // You can choose the border radius
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("${event['number']}"),
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Divider(thickness: 1,),
            // ),

            const SizedBox(height: 16,),

            const Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text("Event fees:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // You can choose the color of the border
                    width: 1.0, // You can choose the width of the border
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)), // You can choose the border radius
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("₹${event['fees']}"),
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Divider(thickness: 1,),
            // ),

            const SizedBox(height: 16,),

            const Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text("Registration link:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // You can choose the color of the border
                          width: 1.0, // You can choose the width of the border
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)), // You can choose the border radius
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("${event['registrationLink']}", style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: "${event['registrationLink']}"));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('"${event['registrationLink']}" copied to clipboard.'),
                        duration: const Duration(seconds: 2),
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
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Text("Registration deadline:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // You can choose the color of the border
                    width: 1.0, // You can choose the width of the border
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)), // You can choose the border radius
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("${event['registrationDeadline']}"),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(thickness: 1,),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black
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
  void launchURL(String url) async {
    try {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } catch (e) {
    }
  }
}

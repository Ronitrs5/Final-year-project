import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:major_project/sidebar/events/subeventdir/sub_event_technical.dart';
import 'package:major_project/theme/style_card_title.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transformable_list_view/transformable_list_view.dart';

import '../../../colors/colors.dart';

// Color backgroundScaffold = const Color(0xff242028);
// Color backgroundScaffold = Colors.black;
// Color backgroundAppbar = const Color(0xff242021);

class MajorTechnicalEvent extends StatefulWidget {
  const MajorTechnicalEvent({Key? key}) : super(key: key);

  @override
  State<MajorTechnicalEvent> createState() => _MajorTechnicalEventState();
}

class _MajorTechnicalEventState extends State<MajorTechnicalEvent> {
  final TextEditingController _searchController = TextEditingController();
  List<EventCard> _allEventCards = [];
  List<EventCard> _filteredEventCards = [];

  bool searchMode = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Call a function to retrieve data from Firestore
    _retrieveDataFromFirestore();
  }

  void _retrieveDataFromFirestore() {
    // Retrieve data from Firestore
    FirebaseFirestore.instance.collection('majorevent').get().then((snapshot) {
      List<EventCard> eventCards =
          snapshot.docs.map((DocumentSnapshot document) {
        String title = document['title'] ?? '';
        String departmentInCharge = document['departmentInCharge'] ?? '';
        setState(() {
          isLoading = false;
        });
        return EventCard(
          title: title,
          departmentInCharge: departmentInCharge,
        );
      }).toList();

      setState(() {
        _allEventCards = eventCards;
        _filteredEventCards = eventCards;
      });
    });
  }

  void _filterEventCards(String query) {
    List<EventCard> filteredEventCards = _allEventCards.where((eventCard) {
      final titleLower = eventCard.title.toLowerCase();
      final deptInChargeLower = eventCard.departmentInCharge.toLowerCase();
      final queryLower = query.toLowerCase();

      return titleLower.contains(queryLower) ||
          deptInChargeLower.contains(queryLower);
    }).toList();

    setState(() {
      _filteredEventCards = filteredEventCards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundScaffold,
      appBar: AppBar(
        backgroundColor: backgroundAppbar,
        title: searchMode
            ? TextField(
                autofocus: true,
                controller: _searchController,
                onChanged: _filterEventCards,
                decoration: InputDecoration(
                  hintText: 'Search events',
                  hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Namun'),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white, fontFamily: 'Namun'),
              )
            : Text(
                'Events',
                style: CustomTextStyles.style_appbar,
              ),
        actions: [
          GestureDetector(
              onTap: () {
                setState(() {
                  searchMode = !searchMode;
                });

                if (!searchMode && _searchController.text.isNotEmpty) {
                  _searchController.clear();
                  _retrieveDataFromFirestore();
                }
              },
              child: Icon(
                searchMode ? Icons.close_rounded : Icons.search_rounded,
                color: Colors.white,
              )),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: Stack(
        children: [
          Visibility(
            visible: isLoading,
            child:  Padding(
              padding: const EdgeInsets.all(16.0),
              child: Shimmer.fromColors(
                baseColor: color_eventcard,
                highlightColor: color_bottom_navbar,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: color_eventcard,

                          borderRadius: BorderRadius.circular(8)
                      ),
                      width: double.infinity,
                      height: 100.0,

                    ),

                    SizedBox(height: 16,),

                    Container(
                      decoration: BoxDecoration(
                          color: color_eventcard,

                          borderRadius: BorderRadius.circular(8)
                      ),
                      width: double.infinity,
                      height: 100.0,

                    ),

                    SizedBox(height: 16,),

                    Container(
                      decoration: BoxDecoration(
                          color: color_eventcard,

                          borderRadius: BorderRadius.circular(8)
                      ),
                      width: double.infinity,
                      height: 100.0,

                    ),

                    SizedBox(height: 16,),

                    Container(
                      decoration: BoxDecoration(
                          color: color_eventcard,

                          borderRadius: BorderRadius.circular(8)
                      ),
                      width: double.infinity,
                      height: 100.0,

                    ),

                    SizedBox(height: 16,),

                    Container(
                      decoration: BoxDecoration(
                          color: color_eventcard,

                          borderRadius: BorderRadius.circular(8)
                      ),
                      width: double.infinity,
                      height: 100.0,

                    ),


                  ],
                ),
              ),
            ),
          ),
          // ListView(
          //   children: _filteredEventCards,
          // ),

          TransformableListView.builder(
            getTransformMatrix: getTransformMatrix,
            itemBuilder: (context, index) {
              if (index < _filteredEventCards.length) {
                return _filteredEventCards[index];
              } else {
                return null; // Return null if index exceeds the length of _filteredEventCards
              }
            },
            itemCount: _filteredEventCards.length,
          ),

        ],
      ),
    );
  }

  Matrix4 getTransformMatrix(TransformableListItem item) {
    /// final scale of child when the animation is completed
    const endScaleBound = 0.6;

    /// 0 when animation completed and [scale] == [endScaleBound]
    /// 1 when animation starts and [scale] == 1
    final animationProgress = item.visibleExtent / item.size.height;

    /// result matrix
    final paintTransform = Matrix4.identity();

    /// animate only if item is on edge
    if (item.position != TransformableListItemPosition.middle) {
      final scale = endScaleBound + ((1 - endScaleBound) * animationProgress);

      paintTransform
        ..translate(item.size.width / 2)
        ..scale(scale)
        ..translate(-item.size.width / 2);
    }

    return paintTransform;
  }
}

class EventCard extends StatefulWidget {
  final String title;
  final String departmentInCharge;

  const EventCard(
      {required this.title, required this.departmentInCharge, Key? key})
      : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {

  Future<String> fetchImage() async {
    String eventTitle = widget.title;
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference events = firestore.collection('majorevent');

      QuerySnapshot querySnapshot =
          await events.where('title', isEqualTo: eventTitle).get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs[0]['majorImageUrl'];
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color_eventcard,
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SubEventsPage(majorEventTitle: widget.title),
                  ),
                );
              },
              child: FutureBuilder<String>(
                future: Future<String>.value(
                    fetchImage()
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.connectionState == ConnectionState.active) {
                    // While waiting for the result, show a loading indicator or a placeholder image
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Shimmer.fromColors(
                            baseColor: color_eventcard,
                            highlightColor: color_bottom_navbar,
                            child: Container(
                              decoration: BoxDecoration(
                                color: color_eventcard,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              width: 200.0,
                              height: 100.0,

                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Shimmer.fromColors(
                            baseColor: color_eventcard,
                            highlightColor: color_bottom_navbar,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: color_eventcard,

                                  borderRadius: BorderRadius.circular(8)
                              ),
                              width: 200.0,
                              height: 100.0,

                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Shimmer.fromColors(
                            baseColor: color_eventcard,
                            highlightColor: color_bottom_navbar,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: color_eventcard,

                                  borderRadius: BorderRadius.circular(8)
                              ),
                              width: 200.0,
                              height: 100.0,

                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(snapshot.data!),
                        ),
                      ),
                    );

                  }
                },
              ),
            ),


            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SubEventsPage(majorEventTitle: widget.title),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: CustomTextStyles.style_card_title
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Department of ',
                        style: TextStyle(color: Colors.grey, fontFamily: 'Namun'),
                      ),
                      Text(
                        widget.departmentInCharge,
                        style: CustomTextStyles.style_card_desc)
                    ],
                  ),

                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsets.fromLTRB(8, 8, 0, 4),
                  //       child: Text(
                  //         "View all events",
                  //         style: TextStyle(
                  //             color: Colors.blueAccent,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //     Icon(
                  //       Icons.navigate_next,
                  //       color: Colors.blueAccent,
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}

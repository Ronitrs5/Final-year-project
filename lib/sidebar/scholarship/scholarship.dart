import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:lottie/lottie.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/sidebar/events/majoreventdir/major_technical.dart';
import 'package:major_project/theme/style_card_title.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transformable_list_view/transformable_list_view.dart';

class Scholarship extends StatefulWidget {
  const Scholarship({super.key});

  @override
  State<Scholarship> createState() => _ScholarshipState();
}

class _ScholarshipState extends State<Scholarship> {
  bool gov = false;
  bool pri = true;

  int size = 0;
  bool isLoading = true;

  Future<int> getLength() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference events = firestore.collection('scholarship');

    if(pri && gov) {
      QuerySnapshot querySnapshot = await events
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();
      return technicalEventData.length;
    }else if (gov){
      QuerySnapshot querySnapshot = await events
          .where('type', isEqualTo: 'Government')
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return technicalEventData.length;
    }else if(pri){
      QuerySnapshot querySnapshot = await events
          .where('type', isEqualTo: 'Private')
          .get();
      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return technicalEventData.length;
    }else{
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> getScholarship() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference events = firestore.collection('scholarship');

    if(pri && gov) {
      QuerySnapshot querySnapshot = await events
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      // ScaffoldMessenger.of(context).
      // showSnackBar(SnackBar(content: Text("Showing results for private and govenment scholarships", style: TextStyle(color: Colors.black),),
      //   backgroundColor: Colors.white, behavior: SnackBarBehavior.floating, duration: Duration(seconds: 2),));

      return technicalEventData;
    }else if (gov){
      QuerySnapshot querySnapshot = await events
          .where('type', isEqualTo: 'Government')
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();


      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text("Showing results for govenment scholarships", style: TextStyle(color: Colors.black),),
      //     backgroundColor: Colors.white, behavior: SnackBarBehavior.floating, duration: Duration(seconds: 2)));
      return technicalEventData;
    }else if(pri){
      QuerySnapshot querySnapshot = await events
          .where('type', isEqualTo: 'Private')
          .get();
      // ScaffoldMessenger.of(context).
      // showSnackBar(SnackBar(content: Text("Showing results for private scholarships", style: TextStyle(color: Colors.black),),
      //     backgroundColor: Colors.white, behavior: SnackBarBehavior.floating, duration: Duration(seconds: 2)));
      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return technicalEventData;
    }else{
      List<Map<String, dynamic>> emptyList = [];
      return emptyList;
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundScaffold,
      body:
          Column(
          children: [
            Container(
              color: backgroundAppbar,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          gov = !gov;
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: gov? Colors.white : Colors.transparent,
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 0.5
                              )
                          ),
                          child: Text("Government", style: TextStyle(color: gov? Colors.black :Colors.white, fontFamily: 'Namun'),
                          )
                      ),
                    ),


                    GestureDetector(
                      onTap: (){
                        setState(() {
                          pri = !pri;
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: pri ? Colors.white : Colors.transparent,
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 0.5
                              )
                          ),
                          child: Text("Private", style: TextStyle(color: pri? Colors.black :Colors.white, fontFamily: 'Namun'),
                          )
                      ),
                    ),

                  ],
                ),
              ),
            ),

            Container(
              color: backgroundAppbar,
              child: FutureBuilder<int>(
                future: getLength(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for the future to complete
                    return Visibility(visible: false,child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // If an error occurred
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // If the future completed successfully
                    return Center(
                      child: Text("Showing ${snapshot.data} results", style: TextStyle(color: Colors.white, fontFamily: 'Namun'),),
                    );
                  }
                },
              ),
            ),

            Divider(thickness: 0.5,color: Colors.grey[800],),





            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: getScholarship(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
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
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Something went wrong while retrieving information', style: TextStyle(color: Colors.white),),
                      );
                    } else {
                      List<Map<String, dynamic>> scholarshipData = snapshot.data ?? [];
                      return scholarshipData.isEmpty ? Center(child: Text("No scholarships found for this filter", style: TextStyle(color: Colors.white),)) :
                      ListView.builder(
                        itemCount: scholarshipData.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data = scholarshipData[index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
                            child: GestureDetector(

                              onTap: (){

                                _launchURLInDefaultBrowserOnAndroid(context, data['url']);

                              },

                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: color_eventcard,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Align(alignment: AlignmentDirectional.centerStart,
                                          child: Text(data['title'] ?? '', style: CustomTextStyles.style_card_title,)),

                                      SizedBox(height: 8,),

                                      Align(alignment: AlignmentDirectional.centerStart,child: Text("Eligibility: ${data['desc']}" ?? '', style: CustomTextStyles.style_card_desc,)),
                                      SizedBox(height: 8,),

                                      Align(alignment: AlignmentDirectional.centerStart,child: Text("Type: ${data['type']}" ?? '', style: CustomTextStyles.style_card_desc,)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            )
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

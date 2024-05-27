import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/sidebar/events/majoreventdir/major_technical.dart';
import 'package:major_project/theme/style_card_title.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transformable_list_view/transformable_list_view.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  String technical = "";
  String ngo = "";
  String cultural = "s";


  Future<int> getLength() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference events = firestore.collection('community');

    if(technical == "s" && ngo == "s" && cultural == "s") {
      QuerySnapshot querySnapshot = await events
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();


      return technicalEventData.length;
    }else if (technical == "s" && ngo == "s"){
      QuerySnapshot querySnapshot = await events
          .where('type', whereIn: ['Non-governmental organization (NGO)', 'Technical group'])
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return technicalEventData.length;

    }else if(technical == "s" && cultural == "s"){
      QuerySnapshot querySnapshot = await events
          .where('type', whereIn: ['Cultural group', 'Technical group'])
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return technicalEventData.length;
    }else if(ngo == "s" && cultural == "s"){
      QuerySnapshot querySnapshot = await events
          .where('type', whereIn: ['Cultural group', 'Non-governmental organization (NGO)'])
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return technicalEventData.length;
    }else if(technical == "s"){
      QuerySnapshot querySnapshot = await events
          .where('type', isEqualTo: "Technical group")
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return technicalEventData.length;
    }else if(cultural == "s"){
      QuerySnapshot querySnapshot = await events
          .where('type', isEqualTo: "Cultural group")
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return technicalEventData.length;
    }else if(ngo == "s"){
      QuerySnapshot querySnapshot = await events
          .where('type', isEqualTo: "Non-governmental organization (NGO)")
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return technicalEventData.length;
    }else{
      List<Map<String, dynamic>> emptyList = [];
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> getCommunities() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference events = firestore.collection('community');

    if(technical == "s" && ngo == "s" && cultural == "s") {
      QuerySnapshot querySnapshot = await events
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();


      return technicalEventData;
    }else if (technical == "s" && ngo == "s"){
      QuerySnapshot querySnapshot = await events
          .where('type', whereIn: ['Non-governmental organization (NGO)', 'Technical group'])
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return technicalEventData;

    }else if(technical == "s" && cultural == "s"){
      QuerySnapshot querySnapshot = await events
          .where('type', whereIn: ['Cultural group', 'Technical group'])
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return technicalEventData;
    }else if(ngo == "s" && cultural == "s"){
      QuerySnapshot querySnapshot = await events
          .where('type', whereIn: ['Cultural group', 'Non-governmental organization (NGO)'])
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return technicalEventData;
    }else if(technical == "s"){
      QuerySnapshot querySnapshot = await events
          .where('type', isEqualTo: "Technical group")
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return technicalEventData;
    }else if(cultural == "s"){
      QuerySnapshot querySnapshot = await events
          .where('type', isEqualTo: "Cultural group")
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return technicalEventData;
    }else if(ngo == "s"){
      QuerySnapshot querySnapshot = await events
          .where('type', isEqualTo: "Non-governmental organization (NGO)")
          .get();

      List<Map<String, dynamic>> technicalEventData = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return technicalEventData;
    }else{
      List<Map<String, dynamic>> emptyList = [];
      return emptyList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundScaffold,

      appBar: AppBar(
        backgroundColor: backgroundAppbar,
        title: Text('Communities and groups', style: CustomTextStyles.style_appbar,),
        automaticallyImplyLeading: false,
      ),

      body: Column(
        children: [
          Padding (
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      if(technical == ""){
                        technical = "s";
                      }else{
                        technical = "";
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: technical == "s" ? Colors.white : Colors.transparent,
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5)
                    ),
                      child: Text("Technical", style: TextStyle(color: technical == "s"? Colors.black :Colors.white, fontFamily: 'Namun'),
                      )
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    setState(() {
                      if(cultural == ""){
                        cultural = "s";
                      }else{
                        cultural = "";
                      }
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: cultural == "s" ? Colors.white : Colors.transparent,
                          border: Border.all(
                              color: Colors.grey,
                              width: 0.5
                          )
                      ),
                      child: Text("Cultural", style: TextStyle(color: cultural == "s"? Colors.black :Colors.white, fontFamily: 'Namun'),
                      )
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    setState(() {
                      if(ngo == ""){
                        ngo = "s";
                      }else{
                        ngo = "";
                      }
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ngo == "s" ? Colors.white : Colors.transparent,
                          border: Border.all(
                              color: Colors.grey,
                              width: 0.5
                          )
                      ),
                      child: Text("NGO", style: TextStyle(color: ngo == "s"? Colors.black :Colors.white, fontFamily: 'Namun'),
                      )
                  ),
                ),
              ],
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
                future: getCommunities(),
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
                    return scholarshipData.isEmpty ? Center(child: Text("No communities found for this filter", style: TextStyle(color: Colors.white),)) :
                    // ListView.builder(
                    //   itemCount: scholarshipData.length,
                    //   itemBuilder: (context, index) {
                    //     Map<String, dynamic> data = scholarshipData[index];
                    //     return Padding(
                    //       padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    //       child: GestureDetector(
                    //         onTap: (){
                    //           // _launchURLInDefaultBrowserOnAndroid(context, data['url']);
                    //         },
                    //
                    //         child: Card(
                    //           color: Colors.black87,
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Column(
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               children: [
                    //                 Align(alignment: AlignmentDirectional.centerStart,child: Text(data['title'] ?? '', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                    //                 SizedBox(height: 16,),
                    //                 Align(alignment: AlignmentDirectional.centerStart,child: Text("Type: ${data['type']}" ?? '', style: TextStyle(color: Colors.grey),)),
                    //                 SizedBox(height: 16,),
                    //                 Align(alignment: AlignmentDirectional.centerStart,child: Text("Registration: ${data['status']}" ?? '', style: TextStyle(color: Colors.grey),)),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // );

                    TransformableListView.builder(
                      getTransformMatrix: getTransformMatrix,
                      itemCount: scholarshipData.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = scholarshipData[index];
                        return GestureDetector(
                          onTap: (){
                            // _launchURLInDefaultBrowserOnAndroid(context, data['url']);
                          },

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                    Align(alignment: AlignmentDirectional.centerStart,child: Text(data['title'] ?? '', style: CustomTextStyles.style_card_title,)),
                                    SizedBox(height: 8,),
                                    Align(alignment: AlignmentDirectional.centerStart,child: Text("Type: ${data['type']}" ?? '', style:CustomTextStyles.style_card_desc,)),
                                    Align(alignment: AlignmentDirectional.centerStart,child: Text("Registration: ${data['status']}" ?? '', style: CustomTextStyles.style_card_desc,),),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:lottie/lottie.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/sidebar/events/majoreventdir/major_technical.dart';
import 'package:major_project/theme/style_card_title.dart';
import 'package:shimmer/shimmer.dart';

import '../contribute.dart';

class IDBenefits extends StatefulWidget {
  const IDBenefits({super.key});

  @override
  State<IDBenefits> createState() => _IDBenefitsState();
}

class _IDBenefitsState extends State<IDBenefits> {


  Future<List<Map<String, dynamic>>> getIDBenefits() async {

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference events = firestore.collection('idbenefits');


      QuerySnapshot querySnapshot = await events
          .get();

      List<Map<String, dynamic>> list = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();


      return list;
    }catch(e){
      return [{}];
    }

  }

  Future<int> getLength() async {

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference events = firestore.collection('idbenefits');


      QuerySnapshot querySnapshot = await events
          .get();

      List<Map<String, dynamic>> list = querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();


      return list.length;
    }catch(e){
      return 0;
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

      body: Column(
        children: [

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
                    child: Visibility(visible: snapshot.data != 0,child: Text("Showing ${snapshot.data} results", style: TextStyle(color: Colors.white, fontFamily: 'Namun'),)),
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
                future: getIDBenefits(),
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
                    return scholarshipData.isEmpty ?

                    Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("No ID benefits listed", style: TextStyle(color: Colors.white60),),

                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ContrbutePage()));
                              },
                              child: Container(
                                  child: Column(
                                    children: [
                                      Text("Contribute to add", style: TextStyle(color: Colors.blue[700]),

                                      ),
                                      Icon(Icons.add_box_rounded, color: Colors.blue[700],)
                                    ],
                                  )
                              ),
                            ),

                          ],
                        )
                    )

                        :
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
                                    Align(alignment: AlignmentDirectional.centerStart,child: Text(data['title'] ?? '', style: CustomTextStyles.style_card_title)),

                                    SizedBox(height: 8,),

                                    Align(alignment: AlignmentDirectional.centerStart,child: Text("Eligibility: ${data['desc']}" ?? '', style: CustomTextStyles.style_card_desc)),

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
}

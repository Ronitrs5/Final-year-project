import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/theme/style_card_title.dart';
import 'package:shimmer/shimmer.dart';

import '../sidebar/events/majoreventdir/major_technical.dart';

class ProfileRetrieveWidget extends StatefulWidget {
  String label;
  String data;
  IconData icon;

  ProfileRetrieveWidget({Key? key, required this.label, required this.data, required this.icon}) : super(key: key);

  @override
  State<ProfileRetrieveWidget> createState() => _ProfileRetrieveWidgetState();
}

class _ProfileRetrieveWidgetState extends State<ProfileRetrieveWidget> {
  @override
  Widget build(BuildContext context) {

    Future<Map<String?, dynamic>> fetchDetails() async {
      try {
        User? user = FirebaseAuth.instance.currentUser;

        DocumentSnapshot<Map<String, dynamic>> userDocSnapshot =
        await FirebaseFirestore.instance
            .collection('students_registration_data')
            .doc(user!.uid)
            .get();

        Map<String?, dynamic> res = {}; // Make keys nullable as well

        if (userDocSnapshot.exists) {
          res = userDocSnapshot.data() ?? {}; // Handle null data from snapshot
          return res;
        } else {
          print('User document does not exist');
          return res;
        }
      } catch (e) {
        print('Error fetching name: $e');
        return {};
      }
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: FutureBuilder<Map<String?, dynamic>>(
            future: fetchDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Shimmer.fromColors(
                    baseColor: backgroundAppbar,
                    highlightColor: Colors.grey[900]!,
                    child: Container(
                      decoration: BoxDecoration(
                        color: backgroundAppbar,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 100.0,
                      height: 30.0,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                String   email = snapshot
                    .data?[widget.data]; // Handle potential null data
                return Row(
                  children: [

                    Icon(widget.icon, color: Colors.white,),
                    SizedBox(width: 8,),
                    Text(
                      email == "" ? "-" : email,
                      style: CustomTextStyles.style_setting_data,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/sidebar/events/majoreventdir/major_technical.dart';
import 'package:major_project/theme/style_card_title.dart';
import 'package:major_project/widgets/contribution_event_widget.dart';

class ContrbutePage extends StatefulWidget {
  const ContrbutePage({super.key});

  @override
  State<ContrbutePage> createState() => _ContrbutePageState();
}

class _ContrbutePageState extends State<ContrbutePage> {
  bool isLoading = false;
  String contribution = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundScaffold,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: backgroundAppbar,
        title: Text(
          "Want to contribute?",
          style: CustomTextStyles.style_appbar,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                "We highly encourage your valuable contributions to enhance the overall experience of the app, which has been developed by students from our college. "
                "Just make sure that the contributions must be authentic. All contributions are reviewed and processed by the HOD of your department.",
                style: TextStyle(color: Colors.white, fontFamily: 'Namun'),
                textAlign: TextAlign.center,

              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(thickness: 0.5, color: Colors.grey[800],),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    floatingLabelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.list),
                    contentPadding: const EdgeInsets.all(16),
                    labelText: 'Region of contribution',
                  ),
                  icon: const Icon(Icons.arrow_drop_down_outlined),
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: Colors.black,
                  items: const [
                    DropdownMenuItem(
                        value: 'SCH',
                        child: Text(
                          'Scholarship',
                        )),
                    DropdownMenuItem(
                        value: 'BEN', child: Text('Student ID benefits')),
                    DropdownMenuItem(
                        value: 'OTH', child: Text('Events of other colleges')),
                    DropdownMenuItem(
                        value: 'OWN', child: Text('Create your own event')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      contribution = value!;
                    });
                  } // Handle dropdown value change
                  ),
            ),
            Visibility(
              visible: contribution == 'OTH' || contribution == 'OWN',
              child: Column(
                children: [
                  ContributionEventWidget(
                      text: "Is it a technical or nontechnical event?",
                      icon: Icons.question_mark_rounded),
                  ContributionEventWidget(
                      text: "What is the venue of the event?",
                      icon: Icons.location_on),
                  ContributionEventWidget(
                      text: "Official link of the event",
                      icon: Icons.link_rounded),
                ],
              ),
            ),

            Visibility(
              visible: contribution == "SCH",
                child: Column(
              children: [
                ContributionEventWidget(text: "Government or Private scholarship?", icon: Icons.question_mark_rounded),
                ContributionEventWidget(text: "Official link of the scholarship", icon: Icons.link_rounded),
              ],
            )),

            Visibility(
                visible: contribution == "BEN",
                child: Column(
                  children: [
                    ContributionEventWidget(text: "Which company / software / organization", icon: Icons.question_mark_rounded),
                    ContributionEventWidget(text: "Applicable for both genders?", icon: Icons.transgender),
                    ContributionEventWidget(text: "Official link of the scholarship", icon: Icons.link_rounded),
                  ],
                )),


            Visibility(
                visible: contribution != '',
                child: ContributionEventWidget(
                    text: "Addtional Information", icon: Icons.note_rounded)),
            Visibility(
              visible: contribution != "",
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    // onPressed: isLoading ? null : sendPasswordResetEmail,
                    onPressed: () {

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Submit'),
                            content: Text('You are about to send this data to your college!'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),

                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Send'),
                              ),
                            ],
                          );
                        },
                      );

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 0,
                    ),
                    child: isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(4.0),
                            child:
                                CircularProgressIndicator(color: Colors.black),
                          )
                        : const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                            ),
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
}

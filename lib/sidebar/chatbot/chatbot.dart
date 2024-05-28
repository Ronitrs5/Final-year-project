import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
import 'package:major_project/colors/colors.dart';
import 'package:major_project/sidebar/chatbot/Messages.dart';
import 'package:major_project/sidebar/events/majoreventdir/major_technical.dart';
import 'package:major_project/theme/style_card_title.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  late DialogFlowtter dialogFlowtter;
  TextEditingController chatbottec = new TextEditingController();
  List<Map<String, dynamic>> messages = [];
  bool vis = true;
  bool isLoading = false;


  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xff554e6b),
      // resizeToAvoidBottomInset: false,
      backgroundColor: backgroundScaffold,
      // appBar: AppBar(
      //   title: const Text(
      //     "Aquarius AI",
      //     style: CustomTextStyles.style_appbar,
      //   ),
      //   // backgroundColor: const Color(0xff554e6b),
      //   backgroundColor: backgroundAppbar,
      //   automaticallyImplyLeading: false,
      //   iconTheme: IconThemeData(color: Colors.white),
      //   // actions: [
      //   //   IconButton(
      //   //       onPressed: () {
      //   //         _showPopup(context);
      //   //       },
      //   //       icon: const Icon(Icons.info_outline)),
      //   // ],
      // ),

      body:

      // Stack(
      //   children: [

          Column(
          children: [

            Visibility(
              visible: vis ? true : false,
              child: Column(
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    child: Image.asset("assets/images/icon_aquarius.png",
                        width: 100, height: 100, color: Colors.white),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: backgroundAppbar),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "How can I assist you today?",
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: "AlfaSlabOne",
                          color: Colors.grey[300]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                chatbottec.text = "College placements";
                              });
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: color_eventcard,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  "College placements",
                                  style: CustomTextStyles.style_card_desc,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                chatbottec.text = "Companies hiring from college";
                              });
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: color_eventcard,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  "Companies",
                                  style: CustomTextStyles.style_card_desc,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                chatbottec.text = "Placement help";
                              });
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: color_eventcard,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  "Placement help",
                                  style: CustomTextStyles.style_card_desc,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                chatbottec.text = "Job Interview Process";
                              });
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: color_eventcard,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  "Interviews",
                                  style: CustomTextStyles.style_card_desc,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

              ),
            ),
            Expanded(child: MessagesScreen(messages: messages)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: chatbottec,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter your query',
                        hintStyle: TextStyle(
                            color: Colors.grey[500]), // Customize hint text color if needed

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.1), // Border color and width
                          borderRadius: BorderRadius.circular(8.0), // Border radius
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.1), // Border color and width
                          borderRadius: BorderRadius.circular(8.0), // Border radius
                        ),

                        // You can customize other properties of InputDecoration as needed
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: isLoading ? null :() {
                        sendMessage(chatbottec.text);
                      },
                      icon: isLoading
                          ?

                      Lottie.asset('assets/anims/loading_dots.json', width: 30, height: 30)
                      // Container(
                      //         width: 18,
                      //         height: 18,
                      //         child: CircularProgressIndicator(
                      //           color: Colors.white,
                      //           strokeWidth: 2,
                      //         ))
                          :
                      Icon(
                              Icons.send_rounded,
                              color: Colors.grey[500],
                            )
                  )
                ],
              ),
            )
          ],
        ),

    //       Visibility(visible: isLoading,child: Center(child: Lottie.asset('assets/anims/loading_dots.json', width: 100, height: 100),)),
    // ]
    //   )
    );
  }

  sendMessage(String text) async {
    if (text.trim().isEmpty) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Question cannot be empty',
          style: TextStyle(color: Colors.black),
        ),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
      ));
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text.trim()])), true);
        vis = false;
        isLoading = true;
        chatbottec.clear();
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));

      if (response.message == null) {
        setState(() {
          isLoading = false;
        });
        return;
      } else {
        setState(() {
          addMessage(response.message!);
          // speak(response.message.toString());
          vis = false;
          isLoading = false;
        });
      }
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundScaffold,
          title: const Text('Note', style: TextStyle(color: Colors.white)),
          content: const SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Card(
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "You are talking to a chatbot, so verify any important information before concluding.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                  child: Card(
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "This chatbot is currently under training on Savitribai Phule Pune University curriculum's data.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70),
                        ),
                      )),
                ),
                // Padding(
                //   padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                //   child: Card(
                //       color: Colors.black,
                //       child: Padding(
                //     padding: EdgeInsets.all(8.0),
                //     child: Text(
                //       "Do not send any abusive messages. Actions will be taken if found guilty.",
                //       textAlign: TextAlign.center,
                //       style: TextStyle(color: Colors.white70),
                //     ),
                //   )),
                // ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                  child: Card(
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Currently it has very limited knowledge(405 KB).",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70),
                        ),
                      )),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                // Close the popup when the "Close" button is pressed
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

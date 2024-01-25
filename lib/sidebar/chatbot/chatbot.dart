import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:major_project/sidebar/chatbot/Messages.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Aquarius AI"),
        // backgroundColor: const Color(0xff554e6b),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                _showPopup(context);
              },
              icon: const Icon(Icons.info_outline)),
        ],
      ),

      body: Column(
        children: [
          Visibility(
            visible: vis ? true : false,
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/icon_aquarius.png",
                      width: 100,
                      height: 100,color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey[600]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "How can I assist you today?",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: "AlfaSlabOne",
                        color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: MessagesScreen(messages: messages)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius:
                    BorderRadius.circular(12.0), // Adjust the radius as needed
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: chatbottec,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Enter your query',
                        hintStyle: TextStyle(
                            color: Colors.grey[
                                800]), // Customize hint text color if needed
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        // You can customize other properties of InputDecoration as needed
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        sendMessage(chatbottec.text);
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.grey[800],
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Query cannot be empty'),
        duration: Duration(seconds: 1),
      ));
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
        vis = false;
        chatbottec.clear();
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));

      if (response.message == null)
        return;
      else {
        setState(() {
          addMessage(response.message!);
          vis = false;
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
          title: const Text('Note'),
          content: const SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Card(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "You are talking to a chatbot, so verify any important information before concluding.",
                      textAlign: TextAlign.center,
                    ),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                  child: Card(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "This chatbot is trained on Savitribai Phule Pune University curriculum.",
                      textAlign: TextAlign.center,
                    ),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                  child: Card(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Do not send any abusive messages. Actions will be taken if found guilty.",
                      textAlign: TextAlign.center,
                    ),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                  child: Card(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Feel free to ask any questions / doubts regarding your degree's curriculum.",
                      textAlign: TextAlign.center,
                    ),
                  )),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
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

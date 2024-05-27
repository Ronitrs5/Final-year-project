import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  const MessagesScreen({super.key, required this.messages});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return ListView.separated(itemBuilder: (context, index){
      return Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: widget.messages[index]['isUserMessage'] ? MainAxisAlignment.end : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(8),
                  topRight: const Radius.circular(8),
                  bottomRight: Radius.circular(widget.messages[index]['isUserMessage'] ? 0 : 8),
                  topLeft: Radius.circular(widget.messages[index]['isUserMessage'] ? 8 : 0),
                ),

                color: widget.messages[index]['isUserMessage'] ? Colors.blueGrey : Colors.blueGrey[200],
              ),
              constraints: BoxConstraints(maxWidth: w * 2 / 3),
              child: Text(widget.messages[index]['message'].text.text[0], style: TextStyle(color: widget.messages[index]['isUserMessage'] ? Colors.white : Colors.black, fontFamily: 'Namun'),),
            )
          ],
        ),
      );
    }, separatorBuilder: (_ , i) => const Padding(padding: EdgeInsets.only(top: 10)), itemCount: widget.messages.length);
  }
}

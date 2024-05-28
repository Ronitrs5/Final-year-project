import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../colors/colors.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  const MessagesScreen({super.key, required this.messages});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  final FlutterTts flutterTts = FlutterTts();
  Flushbar? _flushbar;

  bool isSpeaking = false;

  Widget _buildDancingDots() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -10.0, end: 10.0),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: child,
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('.'),
          SizedBox(width: 5),
          Text('.'),
          SizedBox(width: 5),
          Text('.'),
        ],
      ),
    );
  }

  void speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);

    setState(() {
      isSpeaking = true;
    });

    flutterTts.setCompletionHandler(() {
      _flushbar?.dismiss();
      setState(() {
        isSpeaking = false;
      });
    });

    flutterTts.speak(text);

    _flushbar = Flushbar(
      message: 'Aquarius is speaking...',
      duration: null,
      mainButton: TextButton(
        onPressed: () {

          setState(() {
            isSpeaking = false;
          });
          flutterTts.stop();
          _flushbar?.dismiss();
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16)
          ),
          child: Text(
            'Stop',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      backgroundColor: Colors.blue,
      borderRadius: BorderRadius.circular(16), // Rounded corners
      flushbarPosition: FlushbarPosition.TOP,
      isDismissible: false,
    )..show(context);
  }

  @override
  void dispose() {
    flutterTts.stop(); // Stop TTS when page is disposed
    _flushbar?.dismiss(); // Dismiss Flushbar if it's showing
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return ListView.separated(itemBuilder: (context, index){
      return widget.messages[index]['isUserMessage'] ? Container(
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

                color: widget.messages[index]['isUserMessage'] ? Colors.blueGrey : color_eventcard,
              ),
              constraints: BoxConstraints(maxWidth: w * 2 / 3),
              child: Text(widget.messages[index]['message'].text.text[0], style: TextStyle(color: widget.messages[index]['isUserMessage'] ? Colors.white : Colors.white, fontFamily: 'Namun'),),
            )
          ],
        ),
      ):
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
            child: GestureDetector(
              onTap: (){
                // final player = AudioPlayer();
                // player.play('anims/ai_voice.mp3');

                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('sadadsd')));

                // speak()

                String response = widget.messages[index]['message'].text.text[0].toString().trim();

                if(!isSpeaking){
                  speak(response);
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                  Text('Let aquarius speak the ongoing response or press stop', style: TextStyle(color: Colors.black),),
                    backgroundColor: Colors.white, behavior: SnackBarBehavior.floating, duration: Duration(seconds: 2),));
                }

              },
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                  child: Image.asset('assets/images/icon_aquarius.png', width: 25, height: 25,color: Colors.black,)),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(4, 0, 4, 4),
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

                    color: widget.messages[index]['isUserMessage'] ? Colors.blueGrey : color_eventcard,
                  ),
                  constraints: BoxConstraints(maxWidth: w * 2 / 3),
                  child: Text(widget.messages[index]['message'].text.text[0], style: TextStyle(color: widget.messages[index]['isUserMessage'] ? Colors.white : Colors.white, fontFamily: 'Namun'),),
                )
              ],
            ),
          ),
        ],
      );
    }, separatorBuilder: (_ , i) => const Padding(padding: EdgeInsets.only(top: 10)), itemCount: widget.messages.length);
  }
}



import 'package:flutter/material.dart';

class ContributionEventWidget extends StatefulWidget {

  String text;
  IconData icon;

  ContributionEventWidget({Key? key, required this.text, required this.icon}) : super(key: key);

  @override
  State<ContributionEventWidget> createState() => _ContributionEventWidgetState();
}

class _ContributionEventWidgetState extends State<ContributionEventWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextField(
        // controller: tec_forgot_email,
        cursorColor: Colors.grey,
        style: const TextStyle(color: Colors.white),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            floatingLabelStyle: TextStyle(color: Colors.grey),
            labelText: widget.text,
            prefixIcon: Icon(widget.icon),
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey, // Set the color of the border when the TextField is selected
              ),
            ),

            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ))),
      ),
    );
  }
}

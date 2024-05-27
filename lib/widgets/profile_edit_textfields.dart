import 'package:flutter/material.dart';

class ProfileEditTextFields extends StatefulWidget {
  TextEditingController TEC;
  String text;
  IconData icon;
  ProfileEditTextFields({Key? key, required this.TEC, required this.text, required this.icon}) : super(key: key);

  @override
  State<ProfileEditTextFields> createState() => _ProfileEditTextFieldsState();
}

class _ProfileEditTextFieldsState extends State<ProfileEditTextFields> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: TextField(

        controller: widget.TEC,
        keyboardType: TextInputType.text,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.grey[700],
        cursorWidth: 1.5,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            labelText: widget.text,
            labelStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(widget.icon, color: Colors.grey,),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            floatingLabelStyle:
            TextStyle(color: Colors.grey,),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
        ),
      ),
    );
  }
}

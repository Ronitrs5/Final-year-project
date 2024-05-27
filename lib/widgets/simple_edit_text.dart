import 'package:flutter/material.dart';

class SimpleEditText extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  const SimpleEditText({super.key, required this.controller, required this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextField(
        controller: controller,
        cursorColor: Colors.grey[700],
        cursorWidth: 1.5,
        style: const TextStyle(color: Colors.white),
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            floatingLabelStyle: TextStyle(color: Colors.grey[700]),
            labelText: 'Email address',
            prefixIcon: const Icon(Icons.mail),
            ),
      ),
    );
  }
}

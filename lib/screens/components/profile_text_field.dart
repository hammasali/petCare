import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String labelText;
  ProfileTextField({this.labelText = ""});
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: '$labelText',
        // suffixIcon: Icon(
        //   Icons.check_circle,
        //   color: Colors.green,
        //   size: 14,
        // ),
      ),
    );
  }
}

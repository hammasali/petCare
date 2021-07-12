import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_care/core/constants.dart';

class SearchBox extends StatefulWidget {
  final TextEditingController editingController;

  SearchBox(this.editingController);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: TextField(
        onChanged: (value) {
          setState(() {});
        },
        controller: widget.editingController,
        decoration: InputDecoration(
          hintText: 'Near me',
          prefixIcon: Icon(FontAwesomeIcons.search),
          contentPadding: EdgeInsets.symmetric(vertical: 4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black12,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}

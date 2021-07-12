import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectLocationScreen extends StatelessWidget {
  static const String routeName = '/select_location';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDECEB5),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          color: Color(0xFFDECEB5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: Colors.blue[900],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: Colors.blue[900],
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Map',
                        style: TextStyle(color: Colors.blue[900]),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Veterinary',
                    prefixIcon: Icon(FontAwesomeIcons.search, size: 15),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black12,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Location',
                    prefixIcon: Icon(FontAwesomeIcons.mapMarkerAlt, size: 15),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black12,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.locationArrow,
                    size: 18,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Current Location',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.mapMarkedAlt,
                    size: 18,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Select search area on a map',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(color: Colors.white),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.mapMarkerAlt,
                    size: 18,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Twin Towers',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

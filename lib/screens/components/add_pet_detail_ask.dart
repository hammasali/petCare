import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_care/core/constants.dart';


class AddPetDetailAsk extends StatefulWidget {

  @override
  _AddPetDetailAskState createState() => _AddPetDetailAskState();
}

class _AddPetDetailAskState extends State<AddPetDetailAsk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: Color(0xFFDECEB5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            print("Tapped");
                          },
                          child: Image.asset("assets/images/Cross.png"),
                        ),
                      ),
                      Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 6,
                        child: Text(
                          "Add Pet Detail",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF070821),
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Column(
                        children: [
                          SizedBox(height: 20.0,),
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.solidCircle,size: 10.0,),
                              SizedBox(width: 20,),
                              Text("Faster check-in at appointment.", style: TextStyle(fontSize: 20),),
                            ],
                          ),
                          SizedBox(height: 16.0,),
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.solidCircle,size: 10.0,),
                              SizedBox(width: 20,),
                              Text("Schedule of vaccination, haircuts,\ninspection  etc.", style: TextStyle(fontSize: 20),),
                            ],
                          ),
                          SizedBox(height: 16.0,),
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.solidCircle,size: 10.0,),
                              SizedBox(width: 20,),
                              Text("Reminder of the upcoming events\nwith your pets.", style: TextStyle(fontSize: 20),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height:  MediaQuery.of(context).size.height * 0.08,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 1.2,horizontal: MediaQuery.of(context).size.width * 0.13),
                          decoration: BoxDecoration(
                            color: Color(0xFF6F91D1),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add,size: 16.0,color: Colors.white, ),
                                SizedBox(width: 2.0,),
                                Text("Add", style: TextStyle(color: Colors.white,fontSize: 21, fontWeight: FontWeight.bold, ),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 1.2,horizontal: MediaQuery.of(context).size.width * 0.11),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("No, later", style: TextStyle(color: Colors.black,fontSize: 21, fontWeight: FontWeight.bold, ),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

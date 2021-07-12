import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClinicContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage("assets/images/profile_placeholder.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Demo Clinic',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Clinic Type',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: 4,
                        minRating: 1,
                        itemSize: 14,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      Text(
                        '125 Reviews',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                '10 years of experience',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(width: 20),
              Icon(
                FontAwesomeIcons.mapMarker,
                size: 15,
                color: Colors.blue[700],
              ),
              Text('1.5 km'),
              SizedBox(width: 10),
              Icon(
                FontAwesomeIcons.moneyBill,
                size: 15,
                color: Colors.blue[700],
              ),
              SizedBox(width: 4),
              Text('\$20'),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_care/core/Dummy/dummy_model.dart';

class ProfileContainer extends StatelessWidget {
  final DummyModel dummy;

  ProfileContainer(this.dummy);

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
                    image: AssetImage(dummy.profilePhoto),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dummy.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    dummy.specialist,
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
                        itemBuilder: (context, _) =>
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      Text(
                        '${dummy.rating} Reviews',
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
                "${dummy.experience} years of experience",
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
              Text(dummy.distance),
              SizedBox(width: 10),
              Icon(
                FontAwesomeIcons.moneyBill,
                size: 15,
                color: Colors.blue[700],
              ),
              SizedBox(width: 4),
              Text('\$${dummy.pay}'),
            ],
          )
        ],
      ),
    );
  }
}

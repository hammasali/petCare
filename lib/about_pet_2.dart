import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';

class AboutPet2 extends StatefulWidget {
  static const String routeName = '/about_pet2';
  const AboutPet2({Key? key}) : super(key: key);

  @override
  _AboutPet2State createState() => _AboutPet2State();
}

class _AboutPet2State extends State<AboutPet2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.67,
                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //   fit: BoxFit.fill,
                        //   image: AssetImage("assets/images/dog_pix.jpg"),
                        // )),
                        child: Stack(
                          children: [
                            CarouselSlider(
                                slideIndicator: CircularSlideIndicator(
                                    padding: EdgeInsets.only(bottom: 20),
                                    itemSpacing: 10.0,
                                    indicatorBackgroundColor: Colors.white,
                                    currentIndicatorColor: const Color(0xfffd705e),
                                    indicatorRadius: 4),
                                children: [
                                  Image.asset(
                                    "assets/images/dog_pix.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                  Image.asset(
                                    "assets/images/dog_pix.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                  Image.asset(
                                    "assets/images/dog_pix.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ]),
                            Positioned(
                              top: 20,
                              left: 20,
                              child: Image.asset(
                                "assets/images/back.png",
                                alignment: Alignment.topLeft,
                                height: 40,
                              ),
                            ),
                            Positioned(
                              left: 26,
                              bottom: 60,
                              child: Text(
                                "Lovely Doo - 1yr",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                            ),
                            Positioned(
                              left: 26,
                              bottom: 40,
                              child: Text(
                                "William Scot",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.29,
                        color: Color(0xFFDECEB5),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 34.0, bottom: 16.0),
                                child: Text(
                                  "About",
                                  style: TextStyle(
                                      color: Color(0xFF272727),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: Text(
                                  "The Coton de Tulear originated on the island of Madagascar and is related to the Bichon Frise and the Maltese.\nThe Coton loves being with people and dislikes being separated from them.   The Coton de Tulear originated on the island of Madagascar and is related to the Bichon Frise and the Maltese.\nThe Coton loves being with people and dislikes being separated from them.",
                                  style: TextStyle(
                                    height: 1.6,
                                    color: Color(0xFF272727),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.637,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Image.asset(
                      "assets/images/dog_group.png",
                      height: 50.0,
                    ),
                  ),
                ),
                Positioned(
                  right: 10.0,
                  top: MediaQuery.of(context).size.height * 0.614,
                  child: Image.asset(
                    "assets/images/heart_plus.png",
                    height: 26.0,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

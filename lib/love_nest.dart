import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoveNest extends StatefulWidget {
  static const String routeName = '/love_nest';
  const LoveNest({Key? key}) : super(key: key);

  @override
  _LoveNestState createState() => _LoveNestState();
}

class _LoveNestState extends State<LoveNest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: Text(
          'Love Nest',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.all(12),
            child: GestureDetector(
              child: Image.asset(
                "assets/images/nav_dog.png",
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 1.0,
          height: MediaQuery.of(context).size.height * 1.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/images/dog1.jpg",
                  ))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Expanded(flex: 2,child: Image.asset("assets/images/love_nest_top_pic.png",height: 30,) ),
                Expanded(flex: 6, child: SizedBox(),),
                Expanded(flex: 2,child: Image.asset("assets/images/love_nest_top_pic_2.png",height: 30,) ),
              ],),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
              Container(
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.height * 0.64,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.64,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  "assets/images/before.png",
                                )))),
                    Positioned(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.60,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/images/after.png",
                                  )))),
                    ),
                    Positioned(
                      bottom: 0.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.6,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  "assets/images/dog1.jpg",
                                ))),
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0.0,
                              top: 0.0,
                              child: Image.asset(
                                "assets/images/love_corner.png",
                                height: 70,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter: new ColorFilter.mode(
                                    Colors.black12.withOpacity(0.01),
                                    BlendMode.lighten),
                                image: AssetImage(
                                  "assets/images/bottom_fade.png",
                                ))),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      bottom: 34,
                      child: Text(
                        "Lovely Doo - 1yr",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      bottom: 20,
                      child: Text(
                        "William Scot",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                    Positioned(
                        right: 46.0,
                        bottom: 20,
                        child: Image.asset(
                          "assets/images/layers.png",
                          height: 20.0,
                        )),
                    Positioned(
                      right: 32.0,
                      bottom: 22,
                      child: Text(
                        "2",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/refresh_white.png",
                      height: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/divider.png",
                      height: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/info.png",
                      height: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/divider.png",
                      height: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/heart_white.png",
                      height: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/divider.png",
                      height: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/star_white.png",
                      height: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/divider.png",
                      height: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/double_heart_white.png",
                      height: 30,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

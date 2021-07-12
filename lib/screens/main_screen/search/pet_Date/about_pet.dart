import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/business_logic/chat_bloc/chat_bloc.dart';
import 'package:pet_care/core/constants.dart';
import 'package:pet_care/core/routes.dart';
import 'package:pet_care/core/svg.dart';

class AboutDog extends StatefulWidget {
  static const String routeName = '/about_dog';
  final AboutPetArgs args;

  const AboutDog({Key? key, required this.args}) : super(key: key);

  @override
  _AboutDogState createState() => _AboutDogState();
}

class _AboutDogState extends State<AboutDog> {
  ChatBloc _chatBloc = ChatBloc();

  @override
  void dispose() {
    super.dispose();
    _chatBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                          Hero(
                            tag: widget.args.heroTag.toString(),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      widget.args.profilePhoto.toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    widget.args.profilePhoto.toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    widget.args.profilePhoto.toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ]),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Image.asset(
                          "assets/images/back.png",
                          alignment: Alignment.topLeft,
                          height: 40,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 26,
                      bottom: 40,
                      child: Text(
                        '${widget.args.name} - ${widget.args.size}cm',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                    Positioned(
                      left: 26,
                      bottom: 20,
                      child: Text(
                        widget.args.breed.toString(),
                        style: TextStyle(
                            color: Colors.grey,
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
                            left: 20.0, top: 20.0, bottom: 16.0),
                        child: Text(
                          "About",
                          style: TextStyle(
                              color: Color(0xFF272727),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Text(
                          "The Coton de Tulear originated on the island of Madagascar and is related to the Bichon Frise and the Maltese.\nThe Coton loves being with people and dislikes being separated from them. The Coton de Tulear originated on the island of Madagascar",
                          style: TextStyle(
                            color: Color(0xFF272727),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => _showDialog5(),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "assets/images/reload.png",
                                  height: 50,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () => _showDialog4(),
                                child: Image.asset(
                                  "assets/images/double_heart.png",
                                  height: 50,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () => _showDialog2(),
                                child: Image.asset(
                                  "assets/images/heart.png",
                                  height: 50,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () => _showDialog3(),
                                child: Image.asset(
                                  "assets/images/star.png",
                                  height: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog2() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: SizedBox.expand(child: actionDialog2()),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  actionDialog2() {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            height: 300,
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: kDefaultBackgroundColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      shadowColor: kDefaultBackgroundColor,
                      color: kDefaultBackgroundColor,
                      child: Text(
                        widget.args.name.toString(),
                        style: GoogleFonts.laila(
                          textStyle: TextStyle(
                            fontSize: 30,
                            color: const Color(0xff181818),
                            height: 0.5507246520854993,
                          ),
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Material(
                        shadowColor: kDefaultBackgroundColor,
                        color: kDefaultBackgroundColor,
                        child: Text(
                          'Size : ${widget.args.size}cm',
                          style: GoogleFonts.laila(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: const Color(0xff181818),
                              height: 0.5507246520854993,
                            ),
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Material(
                        shadowColor: kDefaultBackgroundColor,
                        color: kDefaultBackgroundColor,
                        child: Text(
                          'Your request successfully send\n '
                          '\n            love request\n'
                          '\n \n     ${DateFormat.yMMMMEEEEd().format(DateTime.now())}',
                          style: GoogleFonts.laila(
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: const Color(0xff181818),
                              height: 0.5507246520854993,
                            ),
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            height: 80,
                            color: Color(0xfffD705E),
                            child: Material(
                              color: Color(0xfffD705E),
                              child: Center(
                                child: Text(
                                  'Okay',
                                  style: GoogleFonts.laila(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                      color: const Color(0xffffffff),
                                    ),
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
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
        Positioned(
          top: 150.0,
          left: 50.0,
          right: 50.0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0x66fd705e),
                ),
              ),
              Container(
                width: 125.0,
                height: 125.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0x99fd705e),
                ),
              ),
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0xfffd705e),
                ),
              ),
              Container(
                width: 50.0,
                height: 50.0,
                child: SvgPicture.string(
                  logo,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDialog3() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: SizedBox.expand(child: actionDialog3()),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  actionDialog3() {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            height: 300,
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: kDefaultBackgroundColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      shadowColor: kDefaultBackgroundColor,
                      color: kDefaultBackgroundColor,
                      child: Text(
                        widget.args.name.toString(),
                        style: GoogleFonts.laila(
                          textStyle: TextStyle(
                            fontSize: 30,
                            color: const Color(0xff181818),
                            height: 0.5507246520854993,
                          ),
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Material(
                        shadowColor: kDefaultBackgroundColor,
                        color: kDefaultBackgroundColor,
                        child: Text(
                          'Size : ${widget.args.size}cm',
                          style: GoogleFonts.laila(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: const Color(0xff181818),
                              height: 0.5507246520854993,
                            ),
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Material(
                        shadowColor: kDefaultBackgroundColor,
                        color: kDefaultBackgroundColor,
                        child: Text(
                          'Hurrryy !! You bookmarked em\' \n '
                          '\n \n     ${DateFormat.yMMMMEEEEd().format(DateTime.now())}',
                          style: GoogleFonts.laila(
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: const Color(0xff181818),
                              height: 0.5507246520854993,
                            ),
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            height: 80,
                            color: Color(0xfffD705E),
                            child: Material(
                              color: Color(0xfffD705E),
                              child: Center(
                                child: Text(
                                  'Okay',
                                  style: GoogleFonts.laila(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                      color: const Color(0xffffffff),
                                    ),
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
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
        Positioned(
          top: 150.0,
          left: 50.0,
          right: 50.0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0x66fd705e),
                ),
              ),
              Container(
                width: 125.0,
                height: 125.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0x99fd705e),
                ),
              ),
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0xfffd705e),
                ),
              ),
              Container(
                width: 50.0,
                height: 50.0,
                child: SvgPicture.string(
                  logo,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDialog4() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: SizedBox.expand(child: actionDialog4()),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  actionDialog4() {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            height: 300,
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: kDefaultBackgroundColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      shadowColor: kDefaultBackgroundColor,
                      color: kDefaultBackgroundColor,
                      child: Text(
                        widget.args.name.toString(),
                        style: GoogleFonts.laila(
                          textStyle: TextStyle(
                            fontSize: 30,
                            color: const Color(0xff181818),
                            height: 0.5507246520854993,
                          ),
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Material(
                        shadowColor: kDefaultBackgroundColor,
                        color: kDefaultBackgroundColor,
                        child: Text(
                          'Size : ${widget.args.size}cm',
                          style: GoogleFonts.laila(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: const Color(0xff181818),
                              height: 0.5507246520854993,
                            ),
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Material(
                        shadowColor: kDefaultBackgroundColor,
                        color: kDefaultBackgroundColor,
                        child: Text(
                          'Congratulations.. You send love & hugs\n '
                          '\n \n     ${DateFormat.yMMMMEEEEd().format(DateTime.now())}',
                          style: GoogleFonts.laila(
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: const Color(0xff181818),
                              height: 0.5507246520854993,
                            ),
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            height: 80,
                            color: Color(0xfffD705E),
                            child: Material(
                              color: Color(0xfffD705E),
                              child: Center(
                                child: Text(
                                  'Okay',
                                  style: GoogleFonts.laila(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                      color: const Color(0xffffffff),
                                    ),
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
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
        Positioned(
          top: 150.0,
          left: 50.0,
          right: 50.0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0x66fd705e),
                ),
              ),
              Container(
                width: 125.0,
                height: 125.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0x99fd705e),
                ),
              ),
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0xfffd705e),
                ),
              ),
              Container(
                width: 50.0,
                height: 50.0,
                child: SvgPicture.string(
                  logo,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _showDialog5() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: SizedBox.expand(child: actionDialog5()),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  actionDialog5() {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            height: 300,
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: kDefaultBackgroundColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      shadowColor: kDefaultBackgroundColor,
                      color: kDefaultBackgroundColor,
                      child: Text(
                        widget.args.name.toString(),
                        style: GoogleFonts.laila(
                          textStyle: TextStyle(
                            fontSize: 30,
                            color: const Color(0xff181818),
                            height: 0.5507246520854993,
                          ),
                        ),
                        textHeightBehavior:
                            TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Material(
                        shadowColor: kDefaultBackgroundColor,
                        color: kDefaultBackgroundColor,
                        child: Text(
                          'Size : ${widget.args.size}cm',
                          style: GoogleFonts.laila(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: const Color(0xff181818),
                              height: 0.5507246520854993,
                            ),
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Material(
                        shadowColor: kDefaultBackgroundColor,
                        color: kDefaultBackgroundColor,
                        child: Text(
                          'Do you want to send love message?\n '
                          '\n \n     ${DateFormat.yMMMMEEEEd().format(DateTime.now())}',
                          style: GoogleFonts.laila(
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: const Color(0xff181818),
                              height: 0.5507246520854993,
                            ),
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ///=============== BLOC ========================
                      BlocConsumer<ChatBloc, ChatState>(
                        bloc: BlocProvider.of<ChatBloc>(context),
                        listener: (context, state) {
                          if (state is ChatSuccessful)
                            Navigator.of(context).pop();
                        },
                        builder: (context, state) {
                          if (state is ChatLoading)
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(kDefaultPadding),
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 1.1,
                                ),
                              ),
                            );
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => BlocProvider.of<ChatBloc>(context)
                                  .add(SendMessageEvent(
                                      name: widget.args.name.toString(),
                                      uid: widget.args.uid,
                                      message: 'Hi beautiful!')),
                              child: Container(
                                height: 80,
                                color: Color(0xfffD705E),
                                child: Material(
                                  color: Color(0xfffD705E),
                                  child: Center(
                                    child: Text(
                                      'Yes!',
                                      style: GoogleFonts.laila(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                      textHeightBehavior: TextHeightBehavior(
                                          applyHeightToFirstAscent: false),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 150.0,
          left: 50.0,
          right: 50.0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0x66fd705e),
                ),
              ),
              Container(
                width: 125.0,
                height: 125.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0x99fd705e),
                ),
              ),
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0xfffd705e),
                ),
              ),
              Container(
                width: 50.0,
                height: 50.0,
                child: SvgPicture.string(
                  logo,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

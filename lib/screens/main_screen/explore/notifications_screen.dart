import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatelessWidget {
  static const String routeName = '/notifications_screen';

  List<String> _dogImg = [
    'assets/images/dog_img2.png',
    'assets/images/dog_image3.png',
    'assets/images/dog_image4.png',
    'assets/images/dog_img.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Notifications',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF070821),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        backgroundColor: Color(0xFFE4E2E1),
        elevation: 0.0,
        brightness: Brightness.light,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFE4E2E1),
                    Color(0xFFC8BBAE),
                    Color(0xFFAE9880),
                    Color(0xFF847B74),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 5, top: 5),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          _dogImg[index],
                        ),
                      ),
                      title: Text(
                        "Rebecca julee Send love request to you",
                        style: GoogleFonts.roboto(),
                      ),
                      subtitle: Text('Meet Up..!!.Pick up'),
                      isThreeLine: true,
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: _dogImg.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

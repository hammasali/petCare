import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/screens/main_screen/search/pet_shop/product_detail_screen.dart';

class FindBestProduct extends StatefulWidget {
  static const String routeName = '/find_best_screen';

  @override
  _FindBestProductState createState() => _FindBestProductState();
}

class _FindBestProductState extends State<FindBestProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFFDECEB5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 20),
            color: Color(0xFFDECEB5),
            child: Column(
              children: [
                _buildHeader(),
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Find the best product\nfor your pet',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                _buildNavBar(),
                SizedBox(
                  height: 20.0,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed(ProductDetailScreen.routeName),
                        child: buildProductCard(
                            MediaQuery.of(context).size.height * 0.39,
                            Image.asset("assets/images/fp1.png"),
                            "lams Proactive",
                            "225.80 L.E"),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      buildProductCard(
                          MediaQuery.of(context).size.height * 0.34,
                          Image.asset("assets/images/fp2.png"),
                          "lams Proactive",
                          "225.80 L.E"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Other products',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildOtherProduct(Image.asset("assets/images/fp3.png"),
                          "lams Indoor", "Adult dog food", "116.80 L.E"),
                      SizedBox(
                        width: 20.0,
                      ),
                      buildOtherProduct(Image.asset("assets/images/fp4.png"),
                          "9 Lives Today", "Adult dog food", "221.80 L.E"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      // height: 65,
      // child: BottomNavBar(),
      // ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: Image.asset("assets/images/menu.png"),
        ),
      ],
    );
  }

  Widget _buildNavBar() {
    return Row(
      children: [
        Column(
          children: [
            TextButton(
                onPressed: () {},
                style: ButtonStyle(),
                child: Text(
                  "Cat",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                )),
            Container(
              height: 3,
              width: 22,
              color: Color(0xFFFDDFD3),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Dog",
            style: TextStyle(
              color: Color(0xFF667C8A),
              fontSize: 18.0,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Rabbit",
            style: TextStyle(color: Color(0xFF667C8A), fontSize: 18.0),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Turtle",
            style: TextStyle(color: Color(0xFF667C8A), fontSize: 18.0),
          ),
        ),
      ],
    );
  }

  Widget buildProductCard(
      double totalHeight, Image logoImage, String mainTxt, String secTxt) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 16, top: 16, bottom: 16),
        width: MediaQuery.of(context).size.width * 0.55,
        height: totalHeight,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logoImage,
            SizedBox(
              height: 4.0,
            ),
            Text(
              mainTxt,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              secTxt,
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOtherProduct(
      Image image, String mainText, String secText, String thirdTxt) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: ListTile(
        tileColor: Colors.white,
        leading: image,
        title: Text(
          mainText,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        subtitle: RichText(
          text: TextSpan(
              text: secText,
              style: TextStyle(color: Colors.grey, fontSize: 10.0),
              children: <TextSpan>[
                TextSpan(
                    text: "\n\n" + thirdTxt,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ]),
        ),
      ),
    );
  }
}

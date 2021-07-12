import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_care/screens/main_screen/search/pet_shop/payment.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product_detail_screen';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _productAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDECEB5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 20),
            color: Color(0xFFDECEB5),
            child: Column(
              children: [
                _buildHeader(),
                SizedBox(height: 30),
                _buildTitle(),
                SizedBox(height: 30),
                _buildProductImages(),
                SizedBox(height: 30),
                _buildProductCounter(),
                SizedBox(height: 30),
                _buildProductPriceWeight(),
                SizedBox(height: 10),
                Text(
                  'It is the complete description of the product you are looking for',
                  style: TextStyle(color: Colors.black54),
                ),
                SizedBox(height: 30),
                _buildCartButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(FontAwesomeIcons.arrowLeft),
        ),
        GestureDetector(
          onTap: () {},
          child: Icon(FontAwesomeIcons.heart),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Green Tea',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text('Clumping Cat Litter'),
      ],
    );
  }

  Widget _buildProductCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (_productAmount > 0) {
              setState(() {
                _productAmount--;
              });
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            child: Text(
              '-',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 20),
        Text(
          '$_productAmount',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 20),
        GestureDetector(
          onTap: () {
            setState(() {
              _productAmount++;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            child: Text(
              '+',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildProductPriceWeight() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '777.40 L.E',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          '450gm',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildCartButton() {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(PaymentScreen.routeName),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.shoppingBag,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 20),
            Text(
              'Add to Cart',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImages() {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          width: screenWidth - 60,
          height: screenWidth - 60,
          decoration: BoxDecoration(
            color: Color(0xFFFFFF0FD),
            borderRadius: BorderRadius.circular(screenWidth),
          ),
          child: Center(
            child: Container(
              width: screenWidth - 100,
              height: screenWidth - 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth),
              ),
            ),
          ),
        ),
        Positioned(
          child: Image.asset('assets/images/products/p3.png'),
          top: screenWidth - 230,
          // left: -20,
        ),
        Positioned(
          child: Image.asset('assets/images/products/p4.png'),
          top: screenWidth - 230,
          right: 0,
        ),
        Positioned(
          child: Image.asset('assets/images/products/p1.png'),
          bottom: 0,
          left: screenWidth - 240,
        ),
        Positioned(
          child: Image.asset(
            'assets/images/products/p2.png',
            width: 140,
          ),
          top: screenWidth - 350,
          left: screenWidth - 280,
        ),
      ],
    );
  }
}

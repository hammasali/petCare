import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_care/screens/main_screen/search/pet_shop/pay.dart';

class PaymentScreen extends StatefulWidget {
  static const String routeName = '/payment_screen';

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int _radioValue = 0;

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
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCreditCard(
                          MediaQuery.of(context).size.height * 0.22,
                          Color(0xFF0E55CD),
                          Colors.white,
                          Colors.white),
                      SizedBox(
                        width: 10.0,
                      ),
                      _buildCreditCard(
                          MediaQuery.of(context).size.height * 0.20,
                          Colors.white,
                          Colors.black,
                          Colors.black),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                _buildMethodSelect(Image.asset("assets/images/mt1.png"),
                    "Paypal", "Moustafa Adel",0),
                SizedBox(
                  height: 20.0,
                ),
                _buildMethodSelect(Image.asset("assets/images/mt2.png"),
                    "Stripe", "Moustafa Adel",1),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
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
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            FontAwesomeIcons.arrowLeft,
            size: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text("Payment",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
              )),
        ),
      ],
    );
  }

  Widget _buildCreditCard(
    double totalHeight,
    Color color,
    Color logoColor,
    Color fontColor,
  ) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 16, top: 16, bottom: 16),
        width: MediaQuery.of(context).size.width * 0.7,
        height: totalHeight,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/cc1.png", color: logoColor),
                Image.asset("assets/images/cc2.png"),
              ],
            ),
            Row(
              children: [
                Text(
                  "**** **** **** 8102",
                  style: TextStyle(color: fontColor, fontSize: 18.0),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Moustafa Adel",
                  style: TextStyle(color: fontColor, fontSize: 18.0),
                ),
                Text(
                  "06/23",
                  style: TextStyle(color: fontColor, fontSize: 18.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartButton() {
    return GestureDetector(
      onTap: ()=> Navigator.of(context).pushNamed(MySample.routeName),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Proceed to checkout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  FontAwesomeIcons.longArrowAltRight,
                  color: Colors.white,
                  size: 20.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodSelect(Image image, String mainText, String secText,int value) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: ListTile(
            tileColor: Colors.white,
            leading: image,
            title: Text(
              mainText,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(secText),
            trailing: Radio(
              value: value,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
            ),
          ),
        ),
      ],
    );
  }

 void  _handleRadioValueChange(dynamic value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  _checkOut() {
    print('Call ho rha hai');
    return SafeArea(
      child: Column(
        children: <Widget>[
          CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: isCvvFocused,
            obscureCardNumber: true,
            obscureCardCvv: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CreditCardForm(
                    formKey: formKey,
                    obscureCvv: true,
                    obscureNumber: true,
                    cardNumber: cardNumber,
                    cvvCode: cvvCode,
                    cardHolderName: cardHolderName,
                    expiryDate: expiryDate,
                    themeColor: Colors.blue,
                    cardNumberDecoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                    ),
                    expiryDateDecoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Expired Date',
                      hintText: 'XX/XX',
                    ),
                    cvvCodeDecoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CVV',
                      hintText: 'XXX',
                    ),
                    cardHolderDecoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Card Holder',
                    ),
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      primary: const Color(0xff1b447b),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      child: const Text(
                        'Validate',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'halter',
                          fontSize: 14,
                          package: 'flutter_credit_card',
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print('valid!');
                      } else {
                        print('invalid!');
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );}

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}

import 'package:flutter/material.dart';

class DogsFeetScreen extends StatefulWidget {
  static const String routeName = '/dogs_feet';
  @override
  _DogsFeetScreenState createState() => _DogsFeetScreenState();
}

class _DogsFeetScreenState extends State<DogsFeetScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutQuart,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5EEE8),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: FadeTransition(
            opacity: _animation,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 100),
                    child: Image.asset('assets/images/6.png'),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Image.asset('assets/images/5.png'),
                  ),
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 100),
                    child: Image.asset('assets/images/4.png'),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Image.asset('assets/images/3.png'),
                  ),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.only(left: 70),
                    child: Image.asset('assets/images/2.png'),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(right: 70),
                    child: Image.asset('assets/images/1.png'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

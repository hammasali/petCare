import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/core/constants.dart';
import 'package:pet_care/core/global_variables.dart';
import 'package:pet_care/core/shared_prefrences.dart';
import 'package:pet_care/screens/main_screen/bottomNavTab.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentBooked extends StatefulWidget {
  static const routeName = '/appointment_booked';

  @override
  _AppointmentBookedState createState() => _AppointmentBookedState();
}

class _AppointmentBookedState extends State<AppointmentBooked> {
  late SharedPreferences prefs;
  String? _email;

  @override
  void initState() {
    _sharedPref();
    super.initState();
  }

  Event buildEvent({Recurrence? recurrence}) {
    return Event(
      title: 'Pet Care',
      description: 'Appointment with ${AppointmentArguments.name} ',
      location: 'Flutter app',
      startDate: AppointmentArguments.date,
      endDate: DateTime.now().add(Duration(hours: 5)),
      allDay: false,
      iosParams: IOSParams(
        reminder: Duration(minutes: 50),
      ),
      androidParams: AndroidParams(
        emailInvites: [
          _email!,
        ], // on Android, you can add invite emails to your event.
      ),
      recurrence: recurrence,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
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
            ),
            Center(
              child: SingleChildScrollView(
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/Group 1010.png"),
                    SizedBox(height: 70),
                    Center(
                      child: Text(
                        "Your appointment\n has been booked",
                        style: TextStyle(
                            color: Color(0xFF002250),
                            fontSize: 34,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Text(
                        "${AppointmentArguments.name} will be waiting for\n you and your pet",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF002250),
                          fontSize: 21,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 70.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: kDefaultPadding / 2,
                            horizontal: kDefaultPadding),
                        decoration: BoxDecoration(
                          color: Color(0xFF4279DD),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset('assets/images/Path 1189.png'),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Text(
                                  "${DateFormat.MMMMd().format(AppointmentArguments.date)} at "
                                      "${AppointmentArguments.time}",
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 19),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print('ADD 2 CALENDER TRIGGRED');
                        Add2Calendar.addEvent2Cal(
                          buildEvent(),
                        );
                      },
                      child: Text(
                        "+ Add appointment to calendar",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF002250), fontSize: 14.0),
                      ),
                    ),
                    SizedBox(height: 60),
                    GestureDetector(
                      onTap: () => Navigator.pushAndRemoveUntil<dynamic>(
                        context,
                        MaterialPageRoute(builder: (_) => BottomNavBar(false)),
                        (route) => false,
                      ),
                      //if you want to disable back feature set to false

                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 60.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: kDefaultPadding / 1.1,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF4279DD),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Go to my appointments",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _sharedPref() async {
    prefs = await SharedPreferences.getInstance();

    _email = prefs.getString(SharedPref.EMAIL)!;
  }
}

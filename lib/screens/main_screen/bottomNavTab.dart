import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/business_logic/appointment/appointment_bloc.dart';
import 'package:pet_care/business_logic/profile_bloc/profile_bloc.dart';
import 'package:pet_care/screens/main_screen/appointments/appointments_tab.dart';
import 'package:pet_care/screens/main_screen/profile/edit_profile_screen.dart';
import 'package:pet_care/screens/main_screen/search/home.dart';
import 'package:pet_care/screens/main_screen/explore/notifications_screen.dart';

class BottomNavBar extends StatefulWidget {
  final bool isNewer;
  static const String routeName = "/bottom_nav";


  BottomNavBar(this.isNewer);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final ProfileBloc _profileBloc = ProfileBloc();
  final AppointmentBloc _appointmentBloc = AppointmentBloc();


  late final List<Widget> _screens;

  @override
  void initState() {
    _screens = [
      HomeScreen(
        isNewer: widget.isNewer,
      ),
      BlocProvider.value(
        value: _appointmentBloc,
        child: AppointmentTab(),
      ),
      NotificationsScreen(),
      BlocProvider.value(
        value: _profileBloc,
        child: EditProfileScreen(),
      ),
    ];
    super.initState();
  }

  @override
  void dispose() {
    _profileBloc.close();
    _appointmentBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.blue,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedFontSize: 11.0,
          unselectedItemColor: Colors.grey,
          unselectedFontSize: 10.0,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            new BottomNavigationBarItem(
                icon: new Icon(Icons.search_rounded),
                title: Text(
                  'search',
                  style: new TextStyle(fontWeight: FontWeight.w500),
                )),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.access_time_sharp),
                title: Text(
                  'Appointments',
                  // style: new TextStyle(
                  //   fontSize: 12,
                  // ),
                )),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.explore_outlined),
                title: Text(
                  'Notifications',
                )),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.account_circle_outlined),
                title: Text(
                  'Profile',
                )),
          ]),
    );
  }
}

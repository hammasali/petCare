import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/business_logic/appointment/appointment_bloc.dart';
import 'package:pet_care/core/Dummy/dummy_data.dart';
import 'package:pet_care/core/constants.dart';
import 'package:pet_care/core/global_variables.dart';
import 'package:pet_care/service/model/appointment.dart';
import 'package:pet_care/service/repo/firebase_repo.dart';

class AppointmentTab extends StatefulWidget {
  AppointmentTab({Key? key}) : super(key: key);

  @override
  _AppointmentTabState createState() => _AppointmentTabState();
}

class _AppointmentTabState extends State<AppointmentTab> {
  final Query _getAppointments = FirebaseRepo.instance.getAppointment();
  DateTime? date = DateTime.now();
  int _selectedDateIndex = 0;
  DateTime? _todaysDate = DateTime.now();
  List<DateTime?> _allDates = [];
  DateTime? _selectedDateTime;

  @override
  void initState() {
    for (int i = 0; i < 30; i++) {
      _allDates.add(_todaysDate?.add(Duration(days: i)));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Appointments',
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
        ),
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
              StreamBuilder<QuerySnapshot>(
                  stream: _getAppointments.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return Center(child: const Text('Something went wrong'));
                    if (!snapshot.hasData)
                      return Center(child: const Text('Alas! No data found'));
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                          child: CircularProgressIndicator.adaptive(
                        strokeWidth: 1.0,
                      ));
                    else {
                      // return ListView.builder(
                      //     shrinkWrap: true,
                      //     itemCount: snapshot.data!.docs.length,
                      //     itemBuilder: (context, index) {
                      //       Appointment _appointment = Appointment.fromMap(
                      //           snapshot.data.docs[index].data());
                      //       return ListTile();
                      //     });

                      return new ListView(
                        padding: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding),
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          AppointmentModel _appointment =
                              AppointmentModel.fromMap(
                                  document.data() as Map<String, dynamic>);

                          return InkWell(
                            onTap: () => _selectDate(_appointment),
                            child: new ListTile(
                              title: new Text(_appointment.name),
                              subtitle: new Text(_appointment.data),
                              trailing: Text(_appointment.time),
                              leading: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image:
                                        AssetImage(_appointment.profilePhoto),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  })
            ],
          ),
        ));
  }

  void _selectDate(AppointmentModel appointment) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xFF666054),
          child: Container(
            padding: EdgeInsets.only(top: 20, bottom: 20, left: 40, right: 40),
            decoration: BoxDecoration(
              color: Color(0xFFDECEB5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset("assets/images/Cross.png"),
                    ),
                    Expanded(
                      child: Text(
                        'Select a date',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF070821),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Expanded(
                  child: Stack(alignment: Alignment.center, children: [
                    // Container(
                    //   color: Colors.white,
                    //   width: double.infinity,
                    //   height: MediaQuery.of(context).size.height * 0.03,
                    // ),
                    ListWheelScrollView(
                      itemExtent: 35,
                      useMagnifier: true,
                      magnification: 1.1,
                      diameterRatio: 1.2,
                      squeeze: 1.2,
                      clipBehavior: Clip.hardEdge,
                      physics: FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        _selectedDateIndex = index;
                      },
                      children: List.generate(
                        _allDates.length,
                        (index) => Text(
                          DateFormat.yMMMMd().format(_allDates[index]!),
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _selectedDateTime = _allDates[_selectedDateIndex];
                          Navigator.of(context).pop();
                          _showConfirmation(appointment);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'Select date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showConfirmation(AppointmentModel appointment) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: Color(0xFF666054),
            child: Container(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 40),
              decoration: BoxDecoration(
                color: Color(0xFFDECEB5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset("assets/images/Cross.png"),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Booking Confirmation',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF070821),
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _profileContainer(appointment),
                  SizedBox(height: 30),
                  Text(
                    'Date',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  Text(DateFormat.yMMMMd().format(_selectedDateTime!)),
                  Divider(color: Colors.white),
                  SizedBox(height: 30),
                  Container(
                      height: 30,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: dummyTime.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return TimeSelector(
                              time: dummyTime[index],
                            );
                          })),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '20',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 22,
                                ),
                              ),
                              TextSpan(
                                text: '/first visit',
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //=============================BLOC====================

                        BlocConsumer<AppointmentBloc, AppointmentState>(
                            bloc: BlocProvider.of<AppointmentBloc>(context),
                            builder: (context, state) {
                              if (state is AppointmentLoading)
                                return Padding(
                                  padding:
                                      const EdgeInsets.all(kDefaultPadding),
                                  child: CircularProgressIndicator.adaptive(
                                    strokeWidth: 1.1,
                                  ),
                                );

                              return Container();
                            },
                            listener: (context, state) {
                              if (state is AppointmentSuccess)
                                Navigator.of(context).pop();
                              else if (state is AppointmentUnSuccess)
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text(state.message.toString())));
                            }),

                        GestureDetector(
                          onTap: () {
                            AppointmentArguments.profilePhoto =
                                appointment.profilePhoto;
                            if (_selectedDateTime == null)
                              BlocProvider.of<AppointmentBloc>(context).add(
                                  UpdateAppointmentEvent(
                                      time: AppointmentArguments.time,
                                      uid: appointment.uid));
                            else
                              BlocProvider.of<AppointmentBloc>(context).add(
                                  UpdateAppointmentEvent(
                                      uid: appointment.uid,
                                      date: DateFormat.yMMMMd()
                                          .format(_selectedDateTime!),
                                      time: AppointmentArguments.time));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 36,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              'Update',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
        );
      },
    );
  }

  Widget _profileContainer(AppointmentModel appointment) {
    return new ListTile(
      title: new Text(appointment.name),
      subtitle: new Text(appointment.data),
      trailing: Text(appointment.time),
      leading: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(appointment.profilePhoto),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class TimeSelector extends StatefulWidget {
  String time;

  TimeSelector({this.time = "9:00"});

  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  bool _time = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _time = !_time;
          AppointmentArguments.time = widget.time;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _time ? Colors.blue : Colors.white,
        ),
        child: Text(widget.time),
      ),
    );
  }
}

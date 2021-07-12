import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/business_logic/appointment/appointment_bloc.dart';
import 'package:pet_care/core/Dummy/dummy_data.dart';
import 'package:pet_care/core/Dummy/dummy_model.dart';
import 'package:pet_care/core/constants.dart';
import 'package:pet_care/core/global_variables.dart';
import 'package:pet_care/core/routes.dart';
import 'package:pet_care/screens/components/profile_container.dart';
import 'package:pet_care/screens/components/search_box.dart';
import 'package:pet_care/screens/main_screen/search/pet_clinic/appointmentBooked.dart';

class SearchClinicScreen extends StatefulWidget {
  static const routeName = '/search_clinic';

  @override
  _SearchClinicScreenState createState() => _SearchClinicScreenState();
}

class _SearchClinicScreenState extends State<SearchClinicScreen>
    with SingleTickerProviderStateMixin {
  DateTime? date = DateTime.now();
  int _selectedDateIndex = 0;
  DateTime? _todaysDate = DateTime.now();
  List<DateTime?> _allDates = [];
  AppRoutes _appRoutes = AppRoutes();
  TextEditingController _editingController = TextEditingController();

  late TabController _tabController;
  final ValueNotifier<DateTime?> _selectedDateTime =
      ValueNotifier<DateTime?>(DateTime.now());

  @override
  void initState() {
    for (int i = 0; i < 30; i++) {
      _allDates.add(_todaysDate?.add(Duration(days: i)));
    }

    _tabController = TabController(length: 2, vsync: this);
    Future.delayed(const Duration(milliseconds: 300), () {
      _selectDate();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _editingController.dispose();
    _appRoutes.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDECEB5),
      body: SafeArea(
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 30),
          color: Color(0xFFDECEB5),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),

              //==========================TAB BAR ====================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back)),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        // give the indicator a decoration (color and border radius)
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),
                          color: Colors.blue,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          // first tab [you can add an icon using the icon property]
                          Tab(
                            text: 'Specialist',
                          ),

                          // second tab [you can add an icon using the icon property]
                          Tab(
                            text: 'Clinics',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.08,
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              // tab bar view here
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ///==================SPECIALIST TAB=========================
                    // first tab bar view widget
                    Column(
                      children: [
                        Container(
                          child: SearchBox(_editingController),
                        ),
                        SizedBox(height: 10),
                        _searchFilterRow(),

                        //SearchFilterRow(_allDates[_selectedDateIndex]),
                        Expanded(
                            child:
                                // ListView(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: kDefaultPadding),
                                //   children: List.generate(
                                //     10,
                                //     (index) {
                                //       return GestureDetector(
                                //         onTap: () {
                                //           _showConfirmation();
                                //         },
                                //      child: ProfileContainer(),
                                //       );
                                //     },
                                //   ),
                                // ),
                                ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kDefaultPadding),
                                    itemCount: dummyData.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      DummyModel _dummy = dummyData[index];

                                      if (_editingController.text.isEmpty)
                                        return InkWell(
                                            onTap: () =>
                                                _showConfirmation(_dummy),
                                            child: ProfileContainer(_dummy));
                                      else if (_dummy.name
                                              .toLowerCase()
                                              .contains(
                                                  _editingController.text) ||
                                          _dummy.name.toUpperCase().contains(
                                              _editingController.text))
                                        return InkWell(
                                            onTap: () =>
                                                _showConfirmation(_dummy),
                                            child: ProfileContainer(_dummy));
                                      else
                                        return Container();
                                      //return DummyProfileContainer(_dummy);
                                    })),
                      ],
                    ),
                    // second tab bar view widget
                    ///==================CLINICS TAB=========================
                    Column(
                      children: [
                        Container(
                          child: SearchBox(_editingController),
                        ),
                        SizedBox(height: 10),
                        _searchFilterRow(),

                        //SearchFilterRow(_allDates[_selectedDateIndex]),
                        Expanded(
                            child:
                                // ListView(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: kDefaultPadding),
                                //   children: List.generate(
                                //     10,
                                //     (index) {
                                //       return GestureDetector(
                                //         onTap: () {
                                //           _showConfirmation();
                                //         },
                                //         child: ClinicContainer(),
                                //       );
                                //     },
                                //   ),
                                // ),
                                ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kDefaultPadding),
                                    itemCount: dummyData2.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      DummyModel _dummy = dummyData2[index];
                                      if (_editingController.text.isEmpty)
                                        return InkWell(
                                            onTap: () =>
                                                _showConfirmation(_dummy),
                                            child: ProfileContainer(_dummy));
                                      else if (_dummy.name
                                              .toLowerCase()
                                              .contains(
                                                  _editingController.text) ||
                                          _dummy.name.toUpperCase().contains(
                                              _editingController.text))
                                        return InkWell(
                                            onTap: () =>
                                                _showConfirmation(_dummy),
                                            child: ProfileContainer(_dummy));
                                      else
                                        return Container();

                                      //return DummyProfileContainer(_dummy);
                                    })),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectDate() async {
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
                          // print('DATE INDEX: $_selectedDateIndex');
                          // print(
                          //      'DATE : ${DateFormat.yMMMMd().format(_allDates[_selectedDateIndex]!)}');
                          _selectedDateTime.value =
                              _allDates[_selectedDateIndex];
                          // SearchFilterRow(_allDates[_selectedDateIndex]);
                          Navigator.pop(context);
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
                              'Show ${dummyData.length} results',
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

  void _showConfirmation(DummyModel dummy) {
    AppointmentArguments.name = dummy.name;
    AppointmentArguments.date = _allDates[_selectedDateIndex]!;

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
                  ProfileContainer(dummy),
                  SizedBox(height: 30),
                  Text(
                    'Date',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  Text(DateFormat.yMMMMd()
                      .format(_allDates[_selectedDateIndex]!)),
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
                                Navigator.pushNamedAndRemoveUntil<dynamic>(
                                  context, AppointmentBooked.routeName,
                                  (route) =>
                                      false, //if you want to disable back feature set to false
                                );
                              else if (state is AppointmentUnSuccess)
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text(state.message.toString())));
                            }),

                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<AppointmentBloc>(context)
                                .add(AddAppointmentEvent(
                              name: dummy.name,
                              profilePic: dummy.profilePhoto,
                              time: AppointmentArguments.time,
                              uid: dummy.uid,
                              date: DateFormat.yMMMMd()
                                  .format(AppointmentArguments.date),
                            ));
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
                              'Book',
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

  Widget _searchFilterRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 14,
                  ),
                  SizedBox(width: 10),
                  ValueListenableBuilder<DateTime?>(
                      valueListenable: _selectedDateTime,
                      builder: (BuildContext context, DateTime? value,
                          Widget? child) {
                        return Text(
                          ' ${DateFormat.MMMMd().format(value!)}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Text(
                'Dentist',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.filter,
                    color: Colors.black,
                    size: 14,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Filter',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// Widget DummyProfileContainer(DummyModel dummy) {
//   return Container(
//     margin: EdgeInsets.only(top: 24),
//     width: double.infinity,
//     child: Column(
//       children: [
//         Row(
//           children: [
//             Container(
//               width: 70,
//               height: 70,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 image: DecorationImage(
//                   image: AssetImage(dummy.profilePhoto),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(width: 14),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   dummy.name,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     color: Colors.black,
//                   ),
//                 ),
//                 Text(
//                   dummy.specialist,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     RatingBar.builder(
//                       initialRating: 4,
//                       minRating: 1,
//                       itemSize: 14,
//                       direction: Axis.horizontal,
//                       allowHalfRating: true,
//                       itemCount: 5,
//                       itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
//                       itemBuilder: (context, _) =>
//                           Icon(
//                             Icons.star,
//                             color: Colors.amber,
//                           ),
//                       onRatingUpdate: (rating) {
//                         print(rating);
//                       },
//                     ),
//                     Text(
//                       '${dummy.rating} Reviews',
//                       style: TextStyle(fontSize: 12),
//                     )
//                   ],
//                 ),
//               ],
//             )
//           ],
//         ),
//         SizedBox(height: 10),
//         Row(
//           children: [
//             Text(
//               "${dummy.experience} years of experience",
//               style: TextStyle(
//                 fontSize: 12,
//               ),
//             ),
//             SizedBox(width: 20),
//             Icon(
//               FontAwesomeIcons.mapMarker,
//               size: 15,
//               color: Colors.blue[700],
//             ),
//             Text(dummy.distance),
//             SizedBox(width: 10),
//             Icon(
//               FontAwesomeIcons.moneyBill,
//               size: 15,
//               color: Colors.blue[700],
//             ),
//             SizedBox(width: 4),
//             Text('\$${dummy.pay}'),
//           ],
//         )
//       ],
//     ),
//   );
// }
}

// ignore: must_be_immutable
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

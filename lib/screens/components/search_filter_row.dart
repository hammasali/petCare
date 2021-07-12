import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/core/constants.dart';

class SearchFilterRow extends StatefulWidget {
  final dynamic selectedDateIndex;

  SearchFilterRow(this.selectedDateIndex);

  @override
  _SearchFilterRowState createState() => _SearchFilterRowState();
}

class _SearchFilterRowState extends State<SearchFilterRow> {
  late ValueNotifier<DateTime?> _selectedDateIndex;

  @override
  void initState() {
    _selectedDateIndex = ValueNotifier<DateTime?>(widget.selectedDateIndex);
    print('Ho rhs Call $_selectedDateIndex');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      valueListenable: _selectedDateIndex,
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
}

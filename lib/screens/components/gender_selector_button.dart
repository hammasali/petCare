import 'package:flutter/material.dart';

class GenderSelectorButton extends StatefulWidget {
  final IconData icon;
  final String gender;


  GenderSelectorButton(
      {
      this.icon = Icons.male,
      this.gender = "Male",});

  @override
  _GenderSelectorButtonState createState() => _GenderSelectorButtonState();
}

class _GenderSelectorButtonState extends State<GenderSelectorButton> {
  // late bool _isMale;
  // late bool _isFemale;
  late bool _isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.13, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.transparent, //widget.isSelected ? Color(0xFF84AAF0) :
      borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            color: Colors.white,
          ),
          Text(
            '${widget.gender}',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class MaleGender extends StatefulWidget {
  final bool isSelected;

  const MaleGender({Key? key, required this.isSelected}) : super(key: key);

  @override
  _MaleGenderState createState() => _MaleGenderState();
}

class _MaleGenderState extends State<MaleGender> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.13, vertical: 6),
      decoration: BoxDecoration(
        color: widget.isSelected ? Color(0xFF84AAF0) : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.male,
            color: widget.isSelected ? Colors.white : Colors.black,
          ),
          Text(
            'Male',
            style: TextStyle(
                color: widget.isSelected ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}

class FemaleGender extends StatefulWidget {
  const FemaleGender({Key? key}) : super(key: key);

  @override
  _FemaleGenderState createState() => _FemaleGenderState();
}

class _FemaleGenderState extends State<FemaleGender> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

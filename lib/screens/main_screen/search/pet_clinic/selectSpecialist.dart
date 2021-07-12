import 'package:flutter/material.dart';
import 'package:pet_care/screens/main_screen/search/pet_clinic/search_clinic_screen.dart';

class SelectSpecialist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Image.asset("assets/images/Cross.png"),
                  ),
                ),
                Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 7,
                  child: Text(
                    "Select a speciality",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF070821),
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.030,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 26.0),
                child: Text(
                  "POPULAR SPECIALITIES",
                  style: TextStyle(
                    color: Color(0xFF002250),
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            subText("Cat Specialist", () {
              Navigator.of(context).pushNamed(SearchClinicScreen.routeName);
            }),
            SizedBox(
              height: 7.0,
            ),
            subText("Dog Specialist", () {
              Navigator.of(context).pushNamed(SearchClinicScreen.routeName);
            }),
            SizedBox(
              height: 7.0,
            ),
            subText("Ornithologist", () {
              Navigator.of(context).pushNamed(SearchClinicScreen.routeName);
            }),
            SizedBox(
              height: 7.0,
            ),
            subText("Dentist", () {
              Navigator.of(context).pushNamed(SearchClinicScreen.routeName);
            }),
            SizedBox(
              height: 7.0,
            ),
            subText("Surgeon", () {
              Navigator.of(context).pushNamed(SearchClinicScreen.routeName);
            }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 26.0),
                child: Text(
                  "ALL SPECIALITIES",
                  style: TextStyle(
                    color: Color(0xFF002250),
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            subText("Veterinarian", () {
              Navigator.of(context).pushNamed(SearchClinicScreen.routeName);
            }),
            SizedBox(
              height: 7.0,
            ),
            subText("Therapist", () {
              Navigator.of(context).pushNamed(SearchClinicScreen.routeName);
            }),
            SizedBox(
              height: 7.0,
            ),
            subText("Infections disease", () {
              Navigator.of(context).pushNamed(SearchClinicScreen.routeName);
            }),
            SizedBox(
              height: 7.0,
            ),
            subText("Cardiologist", () {
              Navigator.of(context).pushNamed(SearchClinicScreen.routeName);
            }),
            SizedBox(
              height: 7.0,
            ),
            subText("Neurologist", () {
              Navigator.of(context).pushNamed(SearchClinicScreen.routeName);
            }),
            SizedBox(
              height: 7.0,
            ),
            subText("Oncologist", () {
              Navigator.of(context).pushNamed(SearchClinicScreen.routeName);
            }),
            SizedBox(
              height: 7.0,
            ),
            subText("Orthopedist", () {
              Navigator.of(context).pushNamed(SearchClinicScreen.routeName);
            }),
            SizedBox(
              height: 7.0,
            ),
            subText("Radiologist", () {
              Navigator.of(context).pushNamed(SearchClinicScreen.routeName);
            }),
            SizedBox(
              height: 7.0,
            ),
            subText("Dentist", () {
              Navigator.of(context).pushNamed(SearchClinicScreen.routeName);
            }),
            SizedBox(
              height: 7.0,
            ),
            subText("Surgeon", () {
              Navigator.of(context).pushNamed(SearchClinicScreen.routeName);
            }),
            SizedBox(
              height: 7.0,
            ),
            subText("Endocrinologist", () {
              Navigator.of(context).pushNamed(SearchClinicScreen.routeName);
            }),
            SizedBox(
              height: 7.0,
            ),
            subText("Groomer", () {
              Navigator.of(context).pushNamed(SearchClinicScreen.routeName);
            }),
          ],
        ),
      ),
    );
  }

  Widget subText(String title, Function onPressed) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 26.0),
          child: Text(
            title,
            style: TextStyle(
              color: Color(0xFF070821),
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}

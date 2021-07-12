import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/core/constants.dart';
import 'package:pet_care/core/shared_prefrences.dart';
import 'package:pet_care/service/model/pet_details_model.dart';
import 'package:pet_care/service/repo/firebase_repo.dart';

class MyPet extends StatefulWidget {
  static const String routeName = '/my_pet';

  const MyPet({Key? key}) : super(key: key);

  @override
  _MyPetState createState() => _MyPetState();
}

class _MyPetState extends State<MyPet> {
  String? imageFromPreferences;
  final _getPetDetails = FirebaseRepo.instance.getPetDetails();

  @override
  void initState() {
    super.initState();
    _getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Pet',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF070821),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF070821),
          ),
        ),
        backgroundColor: Color(0xFFE4E2E1),
        elevation: 0.0,
        brightness: Brightness.light,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: FutureBuilder<DocumentSnapshot>(
                      future: _getPetDetails.get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError)
                          return Center(
                              child: const Text('Something went wrong'));
                        if (!snapshot.hasData)
                          return Center(
                              child: const Text('Alas! No data found'));
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Center(
                              child: CircularProgressIndicator.adaptive(
                            strokeWidth: 1.0,
                          ));

                        if (snapshot.connectionState == ConnectionState.done) {

                          if (snapshot.data!.data() == null)
                            return Center(
                                child: const Text('Alas! No data found'));


                          PetDetailsModel? petData = PetDetailsModel.fromMap(
                              snapshot.data!.data() as Map<String, dynamic>);
                          return _thePetData(petData);
                        }

                        return Center(child: const Text('Alas! No data found'));
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _thePetData(PetDetailsModel petData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _petProfile(petData),
        SizedBox(
          height: MediaQuery.of(context).size.height / 24,
        ),
        Text(
          'Details.',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 25,
              color: const Color(0xff181818),
              height: 0.5507246520854993,
            ),
          ),
          textHeightBehavior:
              TextHeightBehavior(applyHeightToFirstAscent: false),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        txtData('Gender', petData.gender),
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        txtData('Neutered', petData.neutered),
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        txtData('Vaccinated', petData.vaccinated),
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        txtData('Friendly With Dogs', petData.friendlyWithDogs),
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        txtData('Friendly With Cats', petData.friendlyWithCats),
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        txtData(
            'Friendly With Kids < 10yr', petData.friendlyWithKidsLessThan10),
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        txtData(
            'Friendly With Kids > 10yr', petData.friendlyWithKidsGreaterThan10),
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        txtData('MicroChipped', petData.friendlyWithKidsGreaterThan10),
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        txtData('Purebred', petData.purebred),
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
      ],
    );
  }

  Widget _petProfile(PetDetailsModel petData) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 150.0,
            width: 150.0,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(130.0),
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: imageFromPreferences == null
                        ? CircleAvatar(
                            backgroundColor: Color(0xFFE4E2E1),
                            backgroundImage:
                                AssetImage('assets/images/dog_placeholder.png'),
                            radius: 60,
                          )
                        : Semantics(
                            child: SharedPref.imageFromBase64String(
                                imageFromPreferences),
                            label: 'image_picker_example_picked_image'))),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  petData.petName.toString(),
                  style: GoogleFonts.laila(
                    textStyle: TextStyle(
                      fontSize: 32,
                      color: const Color(0xff181818),
                      height: 0.5507246520854993,
                    ),
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  petData.species.toString(),
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "${petData.breed}, ${petData.size}cm",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  petData.dob.toString(),
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 5.0,
          )
        ],
      );

  Widget txtData(String title, var petInfo) => Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title  : ',
              style: GoogleFonts.aleo(
                textStyle: TextStyle(
                  fontSize: 18,
                  color: const Color(0xff181818),
                  height: 0.5507246520854993,
                ),
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.left,
            ),
            Text(
              petInfo.toString(),
              style: GoogleFonts.aleo(
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  height: 0.5507246520854993,
                ),
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      );

  void _getImage() async {
    imageFromPreferences = await SharedPref.getPetImageFromPreferences();
  }
}

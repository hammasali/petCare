import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/screens/main_screen/search/pet_Date/about_pet.dart';
import 'package:pet_care/core/constants.dart';
import 'package:pet_care/core/routes.dart';
import 'package:pet_care/core/svg.dart';
import 'package:pet_care/service/model/pet_details_model.dart';
import 'package:pet_care/service/repo/firebase_repo.dart';

class MyLoveScreen extends StatefulWidget {
  static const routeName = '/my_love_screen';

  @override
  _MyLoveScreenState createState() => _MyLoveScreenState();
}

class _MyLoveScreenState extends State<MyLoveScreen> {
  final _getRecommendedPets = FirebaseRepo.instance.getRecommendedDogs();
  String? petUrl;


  Widget _imageWidget(String id) => FutureBuilder<void>(
        future: _getDownloadUrl(id),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            case ConnectionState.done:
              return petUrl != null
                  ? Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(petUrl.toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container();
            //return Container(
            //   height: 200.0,
            //   width: 200.0,
            //   decoration: BoxDecoration(
            //     color: Colors.teal,
            //     borderRadius: BorderRadius.circular(100.0),
            //   ),
            //   child: ClipRRect(
            //       borderRadius: BorderRadius.circular(100.0),
            //       child: FittedBox(
            //           fit: BoxFit.cover,
            //           child: petUrl != null
            //               ? Image.network(petUrl.toString())
            //               : Container())),
            // );
            default:
              return Text(
                'Pick image error: ${snapshot.error}}',
                textAlign: TextAlign.center,
              );
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "My Love",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: _getRecommendedPets.get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return Center(child: const Text('Something went wrong'));
            if (!snapshot.hasData)
              return Center(child: const Text('Alas! No data found'));
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                  child: CircularProgressIndicator.adaptive(
                strokeWidth: 1.0,
              ));

            if (snapshot.connectionState == ConnectionState.done) {
              return _thePetData(snapshot.data!.docs);
            }
            return Center(child: const Text('Alas! No data found'));
          }),
    );
  }

  Widget _thePetData(List<QueryDocumentSnapshot> petData) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFe6d19e),
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: petData.length,
          itemBuilder: (BuildContext context, int index) {
            PetDetailsModel? data = PetDetailsModel.fromMap(
                petData[index].data() as Map<String, dynamic>);

            return GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(AboutDog.routeName,
                  arguments: AboutPetArgs(
                      name: data.petName,
                      size: data.size,
                      breed: data.breed,
                      profilePhoto: petUrl,
                      uid: data.uid,
                      heroTag: 'img$index')),
              //onTap: () => _showDialog2(data),
              child: Container(
                width: double.infinity,
                height: 300,
                margin: EdgeInsets.only(
                  bottom: 16,
                ),
                child: Stack(
                  children: [
                    //TODO: IMAGE HERE ............ ============== ..........
                    Hero(
                        tag: 'img$index',
                        child: _imageWidget(data.uid.toString())),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Colors.black26,
                              Colors.black54,
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data.petName} - ${data.size}cm',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  data.breed.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.favorite, color: Colors.red),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.message,
                                  color: Colors.blue[200],
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.layers,
                                  color: Colors.blue[300],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  _getDownloadUrl(String id) async {
    petUrl = await FirebaseRepo.instance.downloadURL(id);
  }
}

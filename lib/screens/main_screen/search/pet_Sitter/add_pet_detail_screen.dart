import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/business_logic/petdetails_bloc/pet_details_bloc.dart';
import 'package:pet_care/core/constants.dart';
import 'package:pet_care/core/routes.dart';
import 'package:pet_care/core/shared_prefrences.dart';
import 'package:pet_care/service/model/pet_details_model.dart';
import 'package:pet_care/service/repo/firebase_repo.dart';

class AddPetDetailScreen extends StatefulWidget {
  static const routeName = '/add_pet_detail';

  @override
  _AddPetDetailScreenState createState() => _AddPetDetailScreenState();
}

class _AddPetDetailScreenState extends State<AddPetDetailScreen> {
  PickedFile? _imageFile;
  dynamic _pickImageError;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  DateTime _dateTime = DateTime.now();
  var formate = DateFormat("MMM dd, yyyy");
  TextEditingController _controller = TextEditingController();
  AppRoutes _appRoutes = AppRoutes();

  String? _petName, _species, _breed, _size, _gender, _dob, _petNurseryName;
  List<bool> isSelected = List.generate(2, (_) => false);

  bool _neutered = true,
      _vaccinated = true,
      _friendlyWithDogs = true,
      _friendlyWithCats = true,
      _friendlyWithKidsLessThan10 = true,
      _friendlyWithKidsGreaterThan10 = true,
      _microChipped = true,
      _purebred = true;
  bool? _isMale = true, _isFemale = false;

  @override
  void initState() {
    isSelected[0] = true;
    _controller.text = formate.format(_dateTime);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _appRoutes.dispose();
  }

  Widget get _imageUpload => FutureBuilder<void>(
        future: retrieveLostData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return CircleAvatar(
                radius: 80.0,
              );
            case ConnectionState.waiting:
              return const Text(
                'Not You have not yet picked an image.',
                textAlign: TextAlign.center,
              );
            case ConnectionState.done:
              return Container(
                height: 100,
                width: 100.0,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  border: Border.all(color: Colors.black45, width: 2.0),
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child:
                        FittedBox(fit: BoxFit.cover, child: _previewImage())),
              );
            default:
              return Container();
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDECEB5),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Add Pet Detail',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFFDECEB5),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16),
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 32),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () => showSheet(context),
                      child: Container(
                        child: Stack(children: [
                          _imageUpload,
                          // FittedBox(fit: BoxFit.cover, child: _previewImage()),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Image.asset(
                              'assets/images/addButton.png',
                              height: 30.0,
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  //=========================GENERAL INFORMATION==================
                  Text(
                    'General\nInformation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  TextFormField(
                    onSaved: (value) => _petName = value!,
                    validator: (value) =>
                        (value!.trim().isEmpty) ? 'Please provide name' : null,
                    decoration: InputDecoration(labelText: 'Pet\'s name'),
                  ),
                  TextFormField(
                    onSaved: (value) => _species = value!,
                    validator: (value) => (value!.trim().isEmpty)
                        ? 'Please provide species'
                        : null,
                    decoration:
                        InputDecoration(labelText: 'Species of your pet'),
                  ),
                  TextFormField(
                    onSaved: (value) => _breed = value!,
                    validator: (value) =>
                        (value!.trim().isEmpty) ? 'Please provide breed' : null,
                    decoration: InputDecoration(labelText: 'Breed'),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _size = value!,
                    decoration: InputDecoration(labelText: 'Size (optional)'),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      "Gender",
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                  ),

                  ///====================TOGGLE BUTTON========================
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ToggleButtons(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.male,
                                  ),
                                  Text(
                                    'Male',
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding / 1.2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.female,
                                  ),
                                  Text(
                                    'Female',
                                  ),
                                ],
                              ),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(30),
                          borderColor: Colors.white,
                          selectedBorderColor: Colors.white,
                          isSelected: isSelected,
                          fillColor: Color(0xFF84AAF0),
                          selectedColor: Colors.white,
                          onPressed: (int index) {
                            setState(() {
                              for (int buttonIndex = 0;
                                  buttonIndex < isSelected.length;
                                  buttonIndex++) {
                                if (buttonIndex == index) {
                                  isSelected[buttonIndex] = true;
                                } else {
                                  isSelected[buttonIndex] = false;
                                }
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 10.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       // GenderSelectorButton(
                  //       //   gender: 'male',
                  //       //   icon: Icons.male,
                  //       //   isMale: true,
                  //       //   isFemale: false,
                  //       // ),
                  //       // GenderSelectorButton(
                  //       //   gender: 'female',
                  //       //   icon: Icons.female,
                  //       //   isMale: false,
                  //       //   isFemale: true,
                  //       // ),
                  //       GestureDetector(
                  //           onTap: () {
                  //             setState(() {
                  //               _isMale = true;
                  //               _isFemale = false;
                  //             });
                  //             _gender = 'male';
                  //           },
                  //           child: maleButton(_isMale!)),
                  //       GestureDetector(
                  //           onTap: () {
                  //             setState(() {
                  //               _isMale = false;
                  //               _isFemale = true;
                  //             });
                  //             _gender = 'female';
                  //           },
                  //           child: femaleButton(_isFemale!)),
                  //     ],
                  //   ),
                  // ),
                  TextFormField(
                    controller: _controller,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    onSaved: (value) => _dob = value!,
                    decoration: InputDecoration(labelText: 'DOB'),
                  ),
                  SizedBox(height: 20),

                  //=====================ADDITIONAL INFORMATION===================
                  Text(
                    'Additional Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Neutered'),
                      Switch(
                        value: _neutered,
                        onChanged: (value) {
                          setState(() {
                            _neutered = !_neutered;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Vaccinated'),
                      Switch(
                        value: _vaccinated,
                        onChanged: (value) {
                          setState(() {
                            _vaccinated = !_vaccinated;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Friendly with dogs'),
                      Switch(
                        value: _friendlyWithDogs,
                        onChanged: (value) {
                          setState(() {
                            _friendlyWithDogs = !_friendlyWithDogs;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Friendly with cats'),
                      Switch(
                        value: _friendlyWithCats,
                        onChanged: (value) {
                          setState(() {
                            _friendlyWithCats = !_friendlyWithCats;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Friendly with kids < 10 years'),
                      Switch(
                        value: _friendlyWithKidsLessThan10,
                        onChanged: (value) {
                          setState(() {
                            _friendlyWithKidsLessThan10 =
                                !_friendlyWithKidsLessThan10;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Friendly with kids > 10 years'),
                      Switch(
                        value: _friendlyWithKidsGreaterThan10,
                        onChanged: (value) {
                          setState(() {
                            _friendlyWithKidsGreaterThan10 =
                                !_friendlyWithKidsGreaterThan10;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('MicroChipped'),
                      Switch(
                        value: _microChipped,
                        onChanged: (value) {
                          setState(() {
                            _microChipped = !_microChipped;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Purebred'),
                      Switch(
                        value: _purebred,
                        onChanged: (value) {
                          setState(() {
                            _purebred = !_purebred;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onSaved: (value) => _petNurseryName = value!,
                    decoration: InputDecoration(
                        labelText: 'Pet\'s nursery name (optional)'),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Reminders',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Add vaccines, haircuts, pills, estrus, etc. and\nyou will receive notification for the next event.',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _addEvent(
                            context, "Add Event", "assets/images/addButton.png",
                            () {
                          print("Tapped");
                        }),
                        SizedBox(
                          width: 20.0,
                        ),
                        _addedEvent(context, "Measles vaccine", "30.08.2021",
                            "assets/images/injectionImg.png", () {
                          print("Tapped");
                        }),
                        SizedBox(
                          width: 20.0,
                        ),
                        _addedEvent(context, "Rabies vaccine", "30.09.2021",
                            "assets/images/injectionImg.png", () {
                          print("Tapped");
                        }),
                        SizedBox(
                          width: 20.0,
                        ),
                        _addedEvent(context, "Other vaccine", "30.10.2021",
                            "assets/images/injectionImg.png", () {
                          print("Tapped");
                        }),
                        SizedBox(
                          width: 20.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  //=======================  BLOC ======================

                  BlocConsumer<PetDetailsBloc, PetDetailsState>(
                      bloc: BlocProvider.of<PetDetailsBloc>(context),
                      builder: (context, state) {
                        if (state is PetDetailsLoading)
                          return Padding(
                            padding: const EdgeInsets.all(kDefaultPadding),
                            child: Center(
                              child: CircularProgressIndicator.adaptive(
                                strokeWidth: 1.1,
                              ),
                            ),
                          );

                        return Container();
                      },
                      listener: (context, state) {
                        if (state is PetDetailsSuccessful)
                          Navigator.of(context).pop();
                        else if (state is PetDetailsUnSuccessful)
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.message.toString())));
                      }),

                  GestureDetector(
                    onTap: () {
                      // ignore: unnecessary_null_comparison
                      if (_imageFile == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please Upload Profile Picture of Pet')));
                      } else {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          isSelected[0] == true
                              ? _gender = 'male'
                              : _gender = 'female';
                          _uploadData(context);
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 0.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: kDefaultPadding / 1.1,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF6F91D1),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Next",
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
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _addEvent(
      BuildContext context, String text, String imgPath, Function onPressed) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 140,
        width: MediaQuery.of(context).size.width * 0.32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(18.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imgPath),
            SizedBox(
              height: 6.0,
            ),
            Center(
                child: Text(
              text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          ],
        ),
      ),
    );
  }

  Widget _addedEvent(BuildContext context, String text, String date,
      String imgPath, Function onPressed) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 140,
        width: MediaQuery.of(context).size.width * 0.32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(18.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imgPath),
            SizedBox(
              height: 6.0,
            ),
            Center(
                child: Text(
              text,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
            Center(
                child: Text(
              date,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));

    if (date != null) {
      setState(() {
        _dateTime = date;
      });
      _controller.text = formate.format(_dateTime);
    }
  }

  Widget maleButton(bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.13, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF84AAF0) : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.male,
            color: isSelected ? Colors.white : Colors.black,
          ),
          Text(
            'Male',
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }

  Widget femaleButton(bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.13, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF84AAF0) : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.female,
            color: isSelected ? Colors.white : Colors.black,
          ),
          Text(
            'Female',
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }

  void _onImageButtonPressed(ImageSource source,
      {required BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget _previewImage() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }

    if (_imageFile != null) {
      File file = File(_imageFile!.path);
      SharedPref.saveToPreferences(
          SharedPref.PETIMAGE, SharedPref.base64String(file.readAsBytesSync()));

      return Semantics(
          child: Image.file(File(_imageFile!.path)),
          label: 'image_picker_example_picked_image');
    } else if (_pickImageError != null) {
      return CircleAvatar(
        backgroundColor: Color(0xFFDECEB5),
        backgroundImage: AssetImage('assets/images/dog_placeholder.png'),
        radius: 60,
      );
    } else {
      return CircleAvatar(
        backgroundColor: Color(0xFFDECEB5),
        backgroundImage: AssetImage('assets/images/dog_placeholder.png'),
        radius: 60,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  void showSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        elevation: 1.1,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: Color(0xFFDECEB5),
        builder: (context) => Container(
              height: 140.0,
              color: kDefaultBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      _onImageButtonPressed(ImageSource.gallery,
                          context: context);
                      Navigator.of(context).pop();
                    },
                    heroTag: 'image0',
                    tooltip: 'Pick Image from gallery',
                    child: const Icon(Icons.photo_library),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      _onImageButtonPressed(ImageSource.camera,
                          context: context);
                      Navigator.of(context).pop();
                    },
                    heroTag: 'image1',
                    tooltip: 'Take a Photo',
                    child: const Icon(Icons.camera_alt),
                  ),
                ],
              ),
            ));
  }

  void _uploadData(BuildContext context) {
    PetDetailsModel _petDetailsModel = PetDetailsModel(
        file: _imageFile,
        petName: _petName,
        breed: _breed,
        species: _species,
        size: _size,
        gender: _gender,
        dob: _controller.text,
        neutered: _neutered,
        vaccinated: _vaccinated,
        friendlyWithDogs: _friendlyWithDogs,
        friendlyWithCats: _friendlyWithCats,
        friendlyWithKidsLessThan10: _friendlyWithKidsLessThan10,
        friendlyWithKidsGreaterThan10: _friendlyWithKidsGreaterThan10,
        microChipped: _microChipped,
        purebred: _purebred,
        petNurseryName: _petNurseryName,
        uid: FirebaseRepo.instance.getCurrentUser()!.uid);

    BlocProvider.of<PetDetailsBloc>(context)
        .add(AddPetDetailsEvent(_petDetailsModel));

    print('$_imageFile\n'
        '$_petName\n '
        '$_species\n '
        '$_breed\n '
        '$_size\n '
        '$_gender\n '
        '${_controller.text}\n '
        '$_neutered\n '
        '$_vaccinated\n '
        '$_friendlyWithDogs\n '
        '$_friendlyWithCats \n '
        '$_friendlyWithKidsLessThan10 \n '
        '$_friendlyWithKidsGreaterThan10\n  '
        '$_microChipped\n '
        '$_purebred\n '
        '$_petNurseryName');
  }

// Widget _dateOfBirth() {
//   if (Platform.isIOS)
//     return Container(
//       height: 200,
//       child: CupertinoDatePicker(
//         mode: CupertinoDatePickerMode.date,
//         initialDateTime: DateTime(1969, 1, 1),
//         onDateTimeChanged: (DateTime newDateTime) {
//           // Do something
//         },
//       ),
//     );
//
//   return Container();
// }
}

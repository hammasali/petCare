import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care/business_logic/profile_bloc/profile_bloc.dart';
import 'package:pet_care/core/constants.dart';
import 'package:pet_care/core/shared_prefrences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit_profile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  PickedFile? _imageFile;
  dynamic _pickImageError;
  String? _retrieveDataError;
  String? imageFromPreferences;
  late SharedPreferences prefs;

  final ImagePicker _picker = ImagePicker();
  List<bool> isSelected = List.generate(2, (_) => false);
  late String _name, _gender, _email, _phoneNo, _description;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    isSelected[0] = true;
    _sharedPref();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
                textAlign: TextAlign.center
              );
            case ConnectionState.done:
              return Container(
                height: 100,
                width: 100.0,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(130.0),
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
            print("Tapped");
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Your Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFFDECEB5),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16),
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.blue,
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  TextFormField(
                    controller: _nameController,
                    onSaved: (value) => _name = value!,
                    validator: (value) =>
                        (value!.trim().isEmpty) ? 'Invalid name' : null,
                    decoration: InputDecoration(
                      labelText: 'Full name',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
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
                  TextFormField(
                    controller: _emailController,
                    onSaved: (value) {
                      _email = value!;
                    },
                    validator: (value) => (value!.trim().isEmpty ||
                            !EmailValidator.validate(value))
                        ? 'Invalid email'
                        : null,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextFormField(
                    controller: _phoneController,
                    onSaved: (value) {
                      _phoneNo = value!;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('About me'),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: _descriptionController,
                    onSaved: (value) {
                      _description = value!;
                    },
                    maxLines: 4,
                    decoration: InputDecoration(
                      fillColor: Colors.white30,
                      filled: true,
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(height: 20),

                  //====================BLOC===============================
                  BlocConsumer<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                    if (state is ProfileLoading)
                      return Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Center(
                          child: CircularProgressIndicator.adaptive(
                            strokeWidth: 1.1,
                          ),
                        ),
                      );

                    return Container();
                  }, listener: (context, state) {
                    if (state is ProfileSuccessfulState)
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Updated')));
                    else if (state is ProfileUnSuccessfulState)
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message.toString())));
                  }),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          isSelected[0] == true
                              ? _gender = 'male'
                              : _gender = 'female';

                          BlocProvider.of<ProfileBloc>(context).add(
                              UpdateProfileEvent(
                                  name: _name,
                                  email: _email,
                                  phone: _phoneNo,
                                  description: _description,
                                  gender: _gender,
                                  file: _imageFile));
                          print(
                              'GENDER DAKHO $_name,$_gender, $_email, $_phoneNo,$_description,  $isSelected');
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.26,
                            vertical: 14),
                        decoration: BoxDecoration(
                          color: Color(0xFF84AAF0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          // 'Get Started',
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _previewImage() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }

    if (_imageFile != null) {
      File file = File(_imageFile!.path);
      SharedPref.saveToPreferences(
          SharedPref.IMAGE, SharedPref.base64String(file.readAsBytesSync()));
      imageFromPreferences = SharedPref.base64String(file.readAsBytesSync());

      return Semantics(
          child: SharedPref.imageFromBase64String(imageFromPreferences),
          label: 'image_picker_example_picked_image');
    } else if (imageFromPreferences != '') {

      return Semantics(
          child: SharedPref.imageFromBase64String(imageFromPreferences),
          label: 'image_picker_example_picked_image');
    } else {
      if (_pickImageError != null) {
        return CircleAvatar(
          backgroundColor: Color(0xFFDECEB5),
          backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
          radius: 60,
        );
      } else {
        return CircleAvatar(
          backgroundColor: Color(0xFFDECEB5),
          backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
          radius: 60,
        );
      }
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

  void _sharedPref() async {
    prefs = await SharedPreferences.getInstance();

    _nameController.text = prefs.getString(SharedPref.USERNAME)!;

    _emailController.text = prefs.getString(SharedPref.EMAIL)!;

    _phoneController.text = prefs.getString(SharedPref.PHONE)!;
    _descriptionController.text = prefs.getString(SharedPref.DESCRIPTION)!;

    imageFromPreferences = await SharedPref.getImageFromPreferences();
    print('Image DATA $imageFromPreferences');

    //prefs.getString('userGender');
  }
}

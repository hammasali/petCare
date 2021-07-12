import 'package:image_picker/image_picker.dart';

class UserInfoModel {
  //USE FILE TO SET THE PATH IN DB AND PROFILEPHOTO TO DISPLAY FROM DB


  PickedFile? file;
  var name, email, createdAt, phoneNo, description, gender, profilePhoto;


  UserInfoModel(
      {this.name,
        this.email,
        this.createdAt,
        this.description,
        this.phoneNo,
        this.gender,
        this.profilePhoto});


  UserInfoModel.file(
      {this.name,
      this.email,
      this.createdAt,
      this.description,
      this.phoneNo,
      this.gender,
      this.profilePhoto,
      this.file});

  // Map toMap(UserInfoModel user) {
  //   var data = Map();
  //   data['name'] = user.name;
  //   data['email'] = user.email;
  //   data['profilePhoto'] = user.file!.path;
  //   data['description'] = user.description;
  //   data['phoneNo'] = user.phoneNo;
  //   data['createdAt'] = user.createdAt;
  //   data['gender'] = user.gender;
  //
  //   return data;
  // }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'email': this.email,
      'name': this.name,
      'description': this.description,
      'phoneNo': this.phoneNo,
      'gender': this.gender,
      'createdAt': this.createdAt,
    } as Map<String, dynamic>;
  }

  Map<String, dynamic> toMapFile() {
    // ignore: unnecessary_cast
    return {
      'profilePhoto': this.file!.path,
      'email': this.email,
      'name': this.name,
      'description': this.description,
      'phoneNo': this.phoneNo,
      'gender': this.gender,
      'createdAt': this.createdAt,
    } as Map<String, dynamic>;
  }

  factory UserInfoModel.fromMap(Map<String, dynamic> data) {
    return UserInfoModel(
        name: data['name'],
        email: data['email'],
        profilePhoto: data['profilePhoto'],
        phoneNo: data['phoneNo'],
        description: data['description'],
        createdAt: data['createdAt'],
        gender: data['gender']);
  }
}

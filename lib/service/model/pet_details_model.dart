import 'package:image_picker/image_picker.dart';

class PetDetailsModel {
  PickedFile? file;
  String? petName,
      species,
      breed,
      size,
      gender,
      dob,
      petNurseryName,
      profilePhoto,
      uid;
  bool? neutered,
      vaccinated,
      friendlyWithDogs,
      friendlyWithCats,
      friendlyWithKidsLessThan10,
      friendlyWithKidsGreaterThan10,
      microChipped,
      purebred;

  PetDetailsModel(
      {this.file,
      this.petName,
      this.species,
      this.breed,
      this.size,
      this.gender,
      this.dob,
      this.petNurseryName,
      this.neutered,
      this.vaccinated,
      this.friendlyWithDogs,
      this.friendlyWithCats,
      this.friendlyWithKidsLessThan10,
      this.friendlyWithKidsGreaterThan10,
      this.microChipped,
      this.purebred,
      this.profilePhoto,
      this.uid});

  factory PetDetailsModel.fromMap(Map<String, dynamic> map) {
    return new PetDetailsModel(
      profilePhoto: map['file'] as String?,
      petName: map['petName'] as String?,
      species: map['species'] as String?,
      breed: map['breed'] as String?,
      size: map['size'] as String?,
      gender: map['gender'] as String?,
      dob: map['dob'] as String?,
      uid: map['uid'] as String?,
      petNurseryName: map['petNurseryName'] as String?,
      neutered: map['neutered'] as bool?,
      vaccinated: map['vaccinated'] as bool?,
      friendlyWithDogs: map['friendlyWithDogs'] as bool?,
      friendlyWithCats: map['friendlyWithCats'] as bool?,
      friendlyWithKidsLessThan10: map['friendlyWithKidsLessThan10'] as bool?,
      friendlyWithKidsGreaterThan10:
          map['friendlyWithKidsGreaterThan10'] as bool?,
      microChipped: map['microChipped'] as bool?,
      purebred: map['purebred'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'file': this.file!.path,
      'petName': this.petName,
      'species': this.species,
      'breed': this.breed,
      'size': this.size,
      'gender': this.gender,
      'dob': this.dob,
      'uid': this.uid,
      'petNurseryName': this.petNurseryName,
      'neutered': this.neutered,
      'vaccinated': this.vaccinated,
      'friendlyWithDogs': this.friendlyWithDogs,
      'friendlyWithCats': this.friendlyWithCats,
      'friendlyWithKidsLessThan10': this.friendlyWithKidsLessThan10,
      'friendlyWithKidsGreaterThan10': this.friendlyWithKidsGreaterThan10,
      'microChipped': this.microChipped,
      'purebred': this.purebred,
    } as Map<String, dynamic>;
  }
}

class AppointmentModel {
   String name, profilePhoto, data, time, uid;

  AppointmentModel(
      {required this.name,
      required this.profilePhoto,
      required this.data,
      required this.time,
      required this.uid});


  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return new AppointmentModel(
      name: map['name'] as String,
      profilePhoto: map['profilePhoto'] as String,
      data: map['data'] as String,
      time: map['time'] as String,
      uid: map['uid'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this.name,
      'profilePhoto': this.profilePhoto,
      'data': this.data,
      'time': this.time,
      'uid': this.uid
    } as Map<String, dynamic>;
  }
}

class AppointmentUpdateModel {
  String? data, time, uid;

  AppointmentUpdateModel({this.data, this.time,this.uid});

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'data': this.data,
      'time': this.time,
      'uid' : this.uid,
    } as Map<String, dynamic>;
  }
}

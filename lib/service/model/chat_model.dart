class ChatModel {
  String? senderId, receiverId, message, name, photo, time;
  var timestamp;

  ChatModel(
      {this.senderId,
      this.receiverId,
      this.message,
      this.timestamp,
      this.name,
      this.photo,
      this.time});

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return new ChatModel(
      senderId: map['senderId'] as String?,
      receiverId: map['receiverId'] as String?,
      message: map['message'] as String?,
      timestamp: map['timestamp'],
      name: map['name'] as String?,
      photo: map['photo'] as String?,
      time: map['time'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'senderId': this.senderId,
      'receiverId': this.receiverId,
      'message': this.message,
      'timestamp': this.timestamp,
      'name': this.name,
      'photo': this.photo,
      'time': this.time,
    } as Map<String, dynamic>;
  }
}

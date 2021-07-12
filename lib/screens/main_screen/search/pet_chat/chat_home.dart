import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/core/constants.dart';
import 'package:pet_care/core/routes.dart';
import 'package:pet_care/service/model/chat_model.dart';
import 'package:pet_care/service/repo/firebase_repo.dart';

import 'messages_screen .dart';

class ChatHome extends StatefulWidget {
  static const String routeName = '/chat_home';

  const ChatHome({Key? key}) : super(key: key);

  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  late Query _fetchUserChatRoom;

  @override
  void initState() {
    _fetchUserChatRoom = FirebaseRepo.instance.fetchUserChatRoom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Chats',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: GestureDetector(
              child: Icon(
                Icons.book,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xffdeceb5),
      body: StreamBuilder<QuerySnapshot>(
          stream: _fetchUserChatRoom.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return _tiles(snapshot.data!.docs);
            } else if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } else {
              return Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Center(
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 1.1,
                  ),
                ),
              );
            }
          }),
    );
  }

  Widget _tiles(List<QueryDocumentSnapshot<Object?>> docs) {
    return ListView.builder(
        itemCount: docs.length,
        itemBuilder: (context, index) {
          ChatModel data =
              ChatModel.fromMap(docs[index].data() as Map<String, dynamic>);

          return InkWell(
            onTap: () => Navigator.of(context).pushNamed(
                MessagesScreen.routeName,
                arguments: ChatArgs(name: data.name, uid: data.receiverId)),
            child: Dismissible(
              key: UniqueKey(),
              background: Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                color: const Color(0xffff6666),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Delete',
                      style: GoogleFonts.mavenPro(
                        textStyle: TextStyle(
                          fontFamily: 'Avenir-Book',
                          fontSize: 15,
                          color: const Color(0xffffffff),
                          height: 1.2258060824486516,
                        ),
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    )),
              ),
              child: ListTile(
                title: Text(
                  data.name.toString(),
                  style: GoogleFonts.mavenPro(
                    textStyle: TextStyle(
                      fontFamily: 'Avenir-Light',
                      fontSize: 20,
                      color: const Color(0xff000000),
                      height: 1.2258060824486516,
                    ),
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.left,
                ),
                subtitle: Text(
                  data.message.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.mavenPro(
                    textStyle: TextStyle(
                      fontFamily: 'Avenir-Book',
                      fontSize: 15,
                      color: const Color(0xff5b78af),
                      height: 1.2258060824486516,
                    ),
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.left,
                ),
                visualDensity: VisualDensity.adaptivePlatformDensity,
                trailing: Text(
                  data.time.toString(),
                  style: GoogleFonts.mavenPro(
                    textStyle: TextStyle(
                      fontFamily: 'Avenir-Book',
                      fontSize: 12.039249420166016,
                      color: const Color(0xff8ea1b4),
                      height: 1.2000000223877072,
                    ),
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          );
        });
  }
}

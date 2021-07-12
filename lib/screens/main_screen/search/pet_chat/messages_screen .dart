import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pet_care/core/routes.dart';
import 'package:pet_care/service/model/chat_model.dart';
import 'package:pet_care/service/repo/firebase_repo.dart';

class MessagesScreen extends StatefulWidget {
  static const String routeName = '/messages_screen';
  final ChatArgs args;

  MessagesScreen(this.args);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  TextEditingController? _controller;
  ScrollController? _listController;
  Query? _fetchChat;
  var _currentUser;
  bool? _isWriting;

  @override
  void initState() {
    _fetchChat = FirebaseRepo.instance.fetchUserChat(widget.args.uid);
    _currentUser = FirebaseRepo.instance.getCurrentUser()!.uid;
    _controller = TextEditingController();
    _listController = ScrollController();
    _isWriting = false;

    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _listController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.args.name.toString(),
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
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
      body: SafeArea(
        child: Container(
          color: Color(0xFFe6d19e),
          padding: EdgeInsets.only(
            // top: 40,
            // bottom: 20,
            left: 10,
            right: 10,
            bottom: 10,
          ),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _fetchChat!.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(child: chats(snapshot.data!.docs));
                  } else if (snapshot.hasError) {
                    return Icon(Icons.error_outline);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              // Expanded(
              //   child: ScrollConfiguration(
              //     behavior: ListScrollBehavior(),
              //     child: ListView.builder(
              //       itemBuilder: (context, index) {
              //         if (index % 2 == 0) {
              //           return _createMessageReceived(context);
              //         } else {
              //           return _createMessageSend(context);
              //         }
              //       },
              //       itemCount: 8,
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: _controller,
                  autofocus: false,
                  onChanged: (val) {
                    (val.length > 0 && val.trim() != '')
                        ? setState(() {
                            _isWriting = true;
                          })
                        : setState(() {
                            _isWriting = false;
                          });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter message',
                    // border: OutlineInputBorder(),
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: _isWriting == true
                        ? IconButton(
                            onPressed: () {
                              FirebaseRepo.instance.addMessageToDB(
                                  message: _controller!.text,
                                  receiverId: widget.args.uid,
                                  name: widget.args.name);
                              _controller!.text = '';
                              setState(() {
                                _isWriting = false;
                              });
                            },
                            icon: Icon(
                              Icons.send,
                              color: Colors.blue,
                            ),
                          )
                        : Icon(Icons.send),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createMessageSend(BuildContext context, String msg, String time) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                color: Color(0xff5E7DB6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Wrap(
                children: [
                  Text(
                    msg,
                    style: TextStyle(color: Colors.white),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      time,
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createMessageReceived(BuildContext context, String msg, String time) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Wrap(
                children: [
                  Text(msg),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      time,
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget chats(List<QueryDocumentSnapshot> docs) {
    ///This is to get the bottom of list when new message arrives. It will call
    ///every time whenever the setState calls / UI change
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      _listController!.animateTo(_listController!.position.maxScrollExtent,
          duration: Duration(microseconds: 250), curve: Curves.easeInOut);
    });

    return ListView.builder(
        controller: _listController,
        itemCount: docs.length,
        itemBuilder: (BuildContext context, int index) {
          var data =
              ChatModel.fromMap(docs[index].data() as Map<String, dynamic>);

          return data.senderId == _currentUser
              ? _createMessageSend(
                  context, data.message.toString(), data.time.toString())
              : _createMessageReceived(
                  context, data.message.toString(), data.time.toString());
          // return Row(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         color: data.senderId == _currentUser
          //             ? Colors.blueGrey
          //             : Colors.deepOrangeAccent,
          //         padding: const EdgeInsets.all(8.0),
          //         margin: const EdgeInsets.symmetric(
          //             horizontal: 20.0, vertical: 10.0),
          //         alignment: data.senderId == _currentUser
          //             ? Alignment.centerRight
          //             : Alignment.centerLeft,
          //         child: Row(
          //           children: [
          //             Expanded(child: Text(data.message.toString())),
          //             Align(
          //                 alignment: Alignment.bottomRight,
          //                 child: Text(data.time.toString()))
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // );
        });
  }
}

class ListScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

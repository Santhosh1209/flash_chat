import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import'package:cloud_firestore/cloud_firestore.dart';

// Notes : Async means that some function is asynchronous and you might need to wait a bit to get its result. Await literally means - wait here until this function is finished and you will get its return value. Future is a type that 'comes from the future' and returns value from your asynchronous function.

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final auth = FirebaseAuth.instance; // used to use the authorization section of Firebase
  final store = FirebaseFirestore.instance; // used to use cloud firestore
  late User loggedinUser; // FirebaseUser = User
  late String userMessage = ''; // message that is sent by the user will be stored using this variable
  @override
  void initState() { // used to call currentUser() function
    // used whenever we insert a stateful widget to the widget tree
    super.initState(); // default implementation of initState();
    CurrentUser();
  }
  void CurrentUser() async// checks to see if there is a current user who has signed in
  {
    try {
      final user = await auth.currentUser; // will be NULL if no one has logged in
      if (user != null) {
        loggedinUser = user;
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  void getMessages()async// used to push data into the database and also get them
  {
    await for (var snapshot in store.collection('messages').snapshots()) // for - in loop is used to get all values of snapshots in the variable 'snapshot'
      { // aka data is obtained in the form of streams - this should be converted into widgets
        for (var message in snapshot.docs) // this for - in loop is used to get each message from the snapshot
          {
            print(message.data());
          }
      }
  }
 // A stream is a sequence of asynchronous events (something like say, a list). Instead of getting the next event when you ask for it, the stream tells you that there is an event when it is ready.
  // It's used because fetching dat from the database causes delay
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null, // widget that's used to display something before the title of the appbar
        actions: <Widget>[ // added at the end of the appbar
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                auth.signOut();
                Navigator.pop(context);
                getMessages();  // returns a stream
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: store.collection('messages').orderBy('timestamp', descending: true).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                      );
                    }

                    final messages = snapshot.data?.docs;
                    final List<Widget> messageWidgets = [];
                    for (var message in messages!) {
                      var data = message.data() as Map;
                      final messageText = data['text'];
                      final messageSender = data['sender'];

                      final isMe = messageSender == loggedinUser!.email;

                      final messageBubble = Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Text(
                              isMe ? 'You' : messageSender,
                              style: TextStyle(color: Colors.black54),
                            ),
                            Material(
                              elevation: 5.0,
                              borderRadius: isMe
                                  ? BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              )
                                  : BorderRadius.only(
                                topRight: Radius.circular(15.0),
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              ),
                              color: isMe ? Colors.lightBlueAccent : Colors.lightGreen,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  messageText,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );

                      messageWidgets.add(messageBubble);
                    }

                    return ListView(
                      reverse: true,
                      children: messageWidgets,
                    );
                  },
                ),
              ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          userMessage = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                        style: TextStyle(color: Colors.black),
                        controller: TextEditingController(text: userMessage), // Set the initial value of the TextField
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (userMessage.trim().isEmpty) return; // Don't send empty messages
                        store.collection('messages').add({
                          'text': userMessage,
                          'sender': loggedinUser.email,
                          'timestamp': FieldValue.serverTimestamp(),
                        });

                        // Clear the TextField after sending the message
                        setState(() {
                          userMessage = "";
                        });
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
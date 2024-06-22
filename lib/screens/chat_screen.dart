import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  ChatScreen({required this.receiver});
  final String receiver;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User loggedinUser;
  late String messageText;

  @override
  void initState() {
    super.initState();
    messagesStream();

    getCurrentUser();
  }

  void getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      loggedinUser = user;
    }
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('Чат с ${widget.receiver}'),
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data?.docs.reversed;
                  List<MessagePiece> messageWidgets = [];
                  for (var message in messages!) {
                    final messageText = message.data()['text'];
                    final messageSender = message.data()['sender'];
                    final messageReceiver = message.data()['receiver'];
                    final timestamp = message.data()['timestamp'];
                    final currentUset = loggedinUser.email;
                    if (messageReceiver == widget.receiver &&
                        currentUset == messageSender) {
                      messageWidgets.add(MessagePiece(
                        messageText: messageText,
                        isCurrentUser: currentUset == messageSender,
                        timestamp: timestamp,
                      ));
                    }
                    if (messageReceiver == currentUset &&
                        widget.receiver == messageSender) {
                      messageWidgets.add(MessagePiece(
                        messageText: messageText,
                        isCurrentUser: currentUset == messageSender,
                        timestamp: timestamp,
                      ));
                    }
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 12.0),
                      children: messageWidgets,
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.redAccent, width: 2.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Введите Ваше сообщение',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedinUser.email,
                        'receiver': widget.receiver,
                        'timestamp': Timestamp.now()
                      });
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagePiece extends StatelessWidget {
  const MessagePiece({
    super.key,
    required this.messageText,
    required this.isCurrentUser,
    required this.timestamp,
  });
  final bool isCurrentUser;

  final String messageText;
  final Timestamp timestamp;

  String formatTimestamp() {
    DateTime dateTime = timestamp.toDate();
    int hours = dateTime.hour;
    int minutes = dateTime.minute;

    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');

    return '$formattedHours:$formattedMinutes';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Material(
            borderRadius: isCurrentUser
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0))
                : BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: isCurrentUser ? Colors.green : Colors.grey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text(
                messageText,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Text(formatTimestamp())
        ],
      ),
    );
  }
}

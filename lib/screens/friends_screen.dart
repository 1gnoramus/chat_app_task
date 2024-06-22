import 'package:chat_app_task/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendsScreen extends StatefulWidget {
  static String id = 'friend_screen';

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  List<FriendInfo> friendsList = [];

  @override
  void initState() {
    super.initState();

    getUsers();
  }

  void getUsers() async {
    WidgetsFlutterBinding.ensureInitialized();

    final users = await _firestore.collection('users').get();
    setState(() {
      friendsList = users.docs
          .where((user) => user.data()['email'] != _auth.currentUser?.email)
          .map((user) => FriendInfo(user: user))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const Text('Чаты'),
      ),
      body: friendsList != []
          ? Column(
              children: friendsList,
            )
          : CircularProgressIndicator(
              color: Colors.red,
            ),
    );
  }
}

class FriendInfo extends StatelessWidget {
  const FriendInfo({
    super.key,
    required this.user,
  });
  String getFirstLetterUpperCase(String str) {
    if (str.isEmpty) return '';
    return str[0].toUpperCase();
  }

  final QueryDocumentSnapshot<Map<String, dynamic>> user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreen(receiver: user.data()['email'])),
        );
      },
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                color: Colors.red),
            height: 60.0,
            width: 60.0,
            child: Center(
                child: Text(
              getFirstLetterUpperCase(user.data()['email']),
              style: const TextStyle(color: Colors.white, fontSize: 24.0),
            )),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            user.data()['email'],
            style: const TextStyle(color: Colors.black, fontSize: 24.0),
          ),
        ],
      ),
    );
  }
}

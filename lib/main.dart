import 'package:chat_app_task/firebase_options.dart';
import 'package:chat_app_task/screens/chat_screen.dart';
import 'package:chat_app_task/screens/friends_screen.dart';
import 'package:chat_app_task/screens/login_screen.dart';
import 'package:chat_app_task/screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
          textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black38))),
      initialRoute: RegistrationScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(
              receiver: '',
            ),
        FriendsScreen.id: (context) => FriendsScreen()
      },
    );
  }
}

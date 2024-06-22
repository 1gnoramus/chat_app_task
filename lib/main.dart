import 'package:chat_app_task/screens/chat_screen.dart';
import 'package:chat_app_task/screens/login_screen.dart';
import 'package:chat_app_task/screens/registration_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black38))),
      initialRoute: RegistrationScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen()
      },
    );
  }
}

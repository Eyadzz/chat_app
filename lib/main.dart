import 'package:chat_app/Chat.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Chat.routeName,
      routes: {
        Chat.routeName: (context)=> Chat(title: 'Chat',),
        Home.routeName: (context)=> Home()
      },
    );
  }
}
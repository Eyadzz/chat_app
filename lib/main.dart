import 'package:chat_app/home/JoinRoomScreen.dart';
import 'package:flutter/material.dart';

import 'home/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JoinRoomScreen(),
    );
  }
}
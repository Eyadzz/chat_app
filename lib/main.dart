import 'package:chat_app_sat/home/AddRoom.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        AddRoom.routeName :(context) => AddRoom() ,
      },
      initialRoute: AddRoom.routeName,
    );
  }
}
import 'package:chat_app/home/AddRoom.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'Chat.dart';
import 'Home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Home.routeName,
      routes: {
        //Chat.routeName: (context)=> Chat(title: 'Chat',),
        Home.routeName: (context)=> Home(),
        AddRoom.routeName :(context) => AddRoom()
      },
    );
  }
}
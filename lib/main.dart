import 'package:chat_app/home/AddRoom.dart';
import 'package:chat_app/home/HomeScreen.dart';
import 'package:chat_app/home/JoinRoomScreen.dart';
import 'package:chat_app/roomDetails/RoomDetailsScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/tabs/register/RegistrationScreen.dart';
import 'package:chat_app/utility/UserProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/home/AddRoom.dart';
import 'Home.dart';
import 'tabs/LogInScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=>UserProvider(),
      builder: (context,widget){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            JoinRoomScreen.routeName:(buildContext)=>JoinRoomScreen(),
            AddRoom.routeName:(buildContext)=>AddRoom(),
            RegistrationScreen.routeName:(buildContext)=>RegistrationScreen(),
            Home.routeName:(buildContext)=>Home(),
            Login.routeName:(context)=>Login(),
            HomeScreen.routeName:(buildContext)=>HomeScreen(),
            RoomDetailsScreen.routeName:(buildContext)=>RoomDetailsScreen()
          },
          initialRoute: RegistrationScreen.routeName,
        );
      },
    );
  }
}
import 'package:chat_app/tabs/home/AddRoom.dart';
import 'package:chat_app/tabs/home/HomeScreen.dart';
import 'package:chat_app/tabs/home/JoinRoomScreen.dart';
import 'package:chat_app/tabs/chat/RoomDetailsScreen.dart';
import 'package:chat_app/tabs/chat/Chat.dart';
import 'package:chat_app/tabs/login/LogInScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/tabs/register/RegistrationScreen.dart';
import 'package:chat_app/utility/AppProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tabs/chat/Chat.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=>AppProvider(),
      builder: (context,widget){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            JoinRoomScreen.routeName:(buildContext)=>JoinRoomScreen(),
            AddRoom.routeName:(buildContext)=>AddRoom(),
            RegistrationScreen.routeName:(buildContext)=>RegistrationScreen(),
            Login.routeName:(context)=>Login(),
            HomeScreen.routeName:(buildContext)=>HomeScreen(),
            RoomDetailsScreen.routeName:(buildContext)=>RoomDetailsScreen(),
            Chat.routeName:(buildContext)=>Chat(),
          },
          initialRoute: Login.routeName,
        );
      },
    );
  }
}
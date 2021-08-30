import 'package:chat_app/tabs/register/RegistrationScreen.dart';
import 'package:chat_app/utility/UserProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Home.dart';

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
            RegistrationScreen.routeName:(buildContext)=>RegistrationScreen(),
            Home.routeName:(buildContext)=>Home(),
          },
          initialRoute: RegistrationScreen.routeName,
        );
      },
    );
  }
}
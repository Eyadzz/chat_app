import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{

  User?
  AppProvider(){
    final firebaseUser= FirebaseAuth.instance.currentUser;
    if(firebaseUser!=null){

    }
  }
}
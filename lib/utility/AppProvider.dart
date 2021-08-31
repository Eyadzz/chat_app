import 'package:chat_app/utility/User.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{

  User? currentUser;

  void updateUser(User? user){
    currentUser=user;
    notifyListeners();
  }

  User? getUser(){
    return currentUser;
  }

}
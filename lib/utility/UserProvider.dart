import 'package:chat_app/utility/User.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{

  User? currentUser;

  void updateUser(User? user){
    currentUser=user;
    notifyListeners();
  }

}
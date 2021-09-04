import 'package:chat_app/utility/User.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{

  User? currentUser;
  String toSearch="";

  void updateUser(User? user){
    currentUser=user;
    notifyListeners();
  }

  User? getUser(){
    return currentUser;
  }

  void setSearch(String toSearch) {
    this.toSearch=toSearch;
  }

  String getToSearch()
  {
    return toSearch;
  }

  void Logout()
  {
    currentUser=null;
  }

}
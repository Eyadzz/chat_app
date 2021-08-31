import 'package:flutter/material.dart';

showErrorMessage(String msg, context){
  showDialog(
      context: context,
      builder: (buildContext){
        return AlertDialog(
          content: Text(msg),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Ok")
            )
          ],
        );
      });
}

showSuccessMessage(String msg, context, toNavigate){
  showDialog(
      context: context,
      builder: (buildContext){
        return AlertDialog(
          content: Text(msg),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => toNavigate));
                },
                child: Text("Ok")
            )
          ],
        );
      });
}
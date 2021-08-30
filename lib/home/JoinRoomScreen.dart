import 'package:chat_app/model/Room.dart';
import 'package:chat_app/roomDetails/RoomDetailsScreen.dart';
import 'package:flutter/material.dart';

class JoinRoomScreen extends StatefulWidget {
  static const routeName = 'JoinRoom';

  @override
  _JoinRoomScreenState createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RoomDetailsArgs;
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.white
        ),
        child: Image.asset(
          'assets/images/bg.png',
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
      Scaffold(
        appBar: AppBar(
          title: Text(args.room!.name),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
            padding: EdgeInsets.only(top: 40,bottom: 12,left: 12,right:12),
            margin: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black12, offset: Offset(4, 8),blurRadius: 8)
                ],
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Hello, Welcome to our chat room',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Color.fromRGBO(48, 48, 48, 1.0)),
                  ),
                  Text('Join ${args.room!.name}!',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(48, 48, 48, 1.0))),
                  SizedBox(height: 20,),
                  Container(
                      child: Column(
                    children: [
                      Image.asset(
                        'assets/images/${args.room!.category}.png',
                        width: 200,
                        height: 196.45,
                      ),
                      SizedBox(height: 30,),
                      Text(args.room!.description,style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                          color: Color.fromRGBO(127, 127, 127, 1.0))),
                      SizedBox(height: 30,),
                      ElevatedButton(
                          style:ElevatedButton.styleFrom(
                            fixedSize: Size(146.7,45.4),
                            primary: Colors.blue
                          ),
                          onPressed: () => joinroom(context, args),
                          child: Text('Join'))
                    ],
                  )),
                ],
              ),
            )),
      ),
    ]);
  }


  void joinroom(BuildContext context, RoomDetailsArgs RoomArgs) {
    ///room joined by account and navigate to the room chat screen
    Navigator.of(context).pushNamed(RoomDetailsScreen.routeName,
        arguments: RoomArgs);
  }
}

import 'package:chat_app/components/DefaultAppBar.dart';
import 'package:chat_app/tabs/chat/RoomDetailsScreen.dart';
import 'package:chat_app/utility/AppProvider.dart';
import 'package:chat_app/utility/DatabaseHelper.dart';
import 'package:chat_app/utility/Room.dart';
import 'package:chat_app/utility/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../chat/Chat.dart';

class JoinRoomScreen extends StatefulWidget {
  static const routeName = 'JoinRoom';

  @override
  _JoinRoomScreenState createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  late AppProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as RoomDetailsArgs;
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
        backgroundColor: Colors.transparent,
        appBar: DefaultAppBar(args.room.name, Container()),
        body: Container(
            padding: EdgeInsets.only(top: 40, bottom: 12, left: 12, right: 12),
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black12,
                      offset: Offset(4, 8),
                      blurRadius: 8)
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
                  Text('Join ${args.room.name}!',
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
                            'assets/images/${args.room.category}.png',
                            width: 200,
                            height: 196.45,
                          ),
                          SizedBox(height: 30,),
                          Text(args.room.description, style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: Color.fromRGBO(127, 127, 127, 1.0))),
                          SizedBox(height: 30,),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(146.7, 45.4),
                                primary: Colors.blue,
                              ),
                              onPressed: () =>
                                  joinRoom(args.room, provider.currentUser!,
                                      context, args),
                              child: Text('Join', style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins',
                                  fontSize: 16),))
                        ],
                      )),
                ],
              ),
            )),
      ),
    ]);
  }

//joinRoom(room,provider.currentUser!,context);
  void joinRoom(Room room, User user, BuildContext context,
      RoomDetailsArgs RoomArgs) {
    final CollectionReference<Room> roomRef = getUserCollectionWithConverter(
        user.id);
    final roomDoc = roomRef.doc(room.id);
    final userDoc = getRoomCollectionWithConverter(room.id).doc(user.id);
    userDoc.set(user);

    roomDoc.set(room).then((value) {
      provider.setSearch('');
      Navigator.pushNamed(
        context,
        Chat.routeName,
        arguments: RoomArgs,
      );
    });
  }
}

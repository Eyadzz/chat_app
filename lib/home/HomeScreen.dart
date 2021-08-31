import 'package:chat_app/components/CustomAppBar.dart';
import 'package:chat_app/utility/DatabaseHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/model/Room.dart';
import 'AddRoom.dart';
import 'RoomGridItem.dart';
class HomeScreen extends StatelessWidget {
  static const String routeName = 'home';

  late CollectionReference<Room> roomCollectionRef;

  HomeScreen() {
    roomCollectionRef = getRoomsCollectionWithConverter();
  }

  @override
  Widget build(BuildContext context) {
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
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddRoom.routeName);
            },
            child: Icon(Icons.add)),
        appBar: CustomAppBar("Chat App"),
        body: Container(
            margin: EdgeInsets.only(top: 64, bottom: 12, right: 12, left: 12),
            child: FutureBuilder<QuerySnapshot<Room>>(
              future: roomCollectionRef.get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Room>> snapshot) {
                if (snapshot.hasError) {
                  return Text('something went wrong!');
                } else if (snapshot.connectionState == ConnectionState.done) {
                  final List<Room> roomsList = snapshot.data?.docs
                          .map((singleDoc) => singleDoc.data())
                          .toList() ??
                      [];
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4),
                      itemBuilder: (buildContext, index) {
                        return RoomGridItem(roomsList[index]);
                      },
                      itemCount: roomsList.length);
                }
                return Center(child: CircularProgressIndicator());
              },
            )),
      )
    ]);
  }
}

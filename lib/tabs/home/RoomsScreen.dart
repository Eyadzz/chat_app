
import 'package:chat_app/utility/AppProvider.dart';
import 'package:chat_app/utility/DatabaseHelper.dart';
import 'package:chat_app/utility/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'RoomGridItem.dart';


class RoomsScreen extends StatefulWidget {
  late CollectionReference<Room> roomCollectionRef;
  RoomsScreen() {
    roomCollectionRef = getRoomsCollectionWithConverter();
  }
  static const String routeName = 'MyRooms';
  @override
  _RoomsScreenState createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen>{
  late AppProvider provider;
  bool loading =false;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    getRoomRef();
    return Container(
      child:loading?FutureBuilder<QuerySnapshot<Room>>(
        future: widget.roomCollectionRef.get(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Room>> snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong!');
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Room> roomsList = snapshot.data?.docs
                .map((singleDoc) => singleDoc.data())
                .toList() ??
                [];
            if(roomsList.length==0) {
              return Center(
                child: Text(
                  'No rooms to display',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Poppins",
                  ),
                ),
              );
            } else {
              if(provider.getToSearch()=='')
                {
                  return displayRooms(roomsList);
                }
              else{
                List<Room> foundRooms=searchRoom(provider.getToSearch(), roomsList);
                return displayRooms(foundRooms);
              }
            }
          } else if (snapshot.hasData && snapshot.data == null) {
            return Center(
              child: Text(
                'RoomsNo',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );

  }
void  getRoomRef() {
    String id = provider.currentUser?.id ?? "";
    if (id != "") {
      widget.roomCollectionRef = getUserCollectionWithConverter(provider.currentUser!.id);
      loading = true;
      return;
    } else {
      Future.delayed(
        Duration(milliseconds: 100),
            () {
          setState(() {
            getRoomRef();
          });
        },
      );
    }
    return;
  }
}

List<Room> searchRoom(String text, List<Room> roomsList){

  List<Room> foundRooms=[];
  for(int i=0; i< roomsList.length; i++){
    if(roomsList[i].name.contains(text))
      foundRooms.add(roomsList[i]);
  }
  return foundRooms;
}

Widget displayRooms(List<Room> rooms)
{
  return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4),
      itemBuilder: (buildContext, index) {
        return RoomGridItem(rooms[index],false);
      },
      itemCount: rooms.length);
}
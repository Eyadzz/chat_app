
import 'package:chat_app/utility/AppProvider.dart';
import 'package:chat_app/utility/DatabaseHelper.dart';
import 'package:chat_app/utility/Room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'RoomGridItem.dart';


class BrowseScreen extends StatefulWidget {
  late CollectionReference<Room> roomCollectionRef;
  RoomsScreen() {
    roomCollectionRef = getRoomsCollectionWithConverter();
  }
  static const String routeName = 'Browse';
  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen>{
  late AppProvider provider;

  @override
  Widget build(BuildContext context) {
    widget.roomCollectionRef = getRoomsCollectionWithConverter();
    provider = Provider.of<AppProvider>(context);
    return Container(
      child:FutureBuilder<QuerySnapshot<Room>>(
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
              if(roomsList.length==0){
                return Center(
                  child: Text(
                    'Nothing found',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              if(provider.getToSearch()=='')
                {
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4),
                      itemBuilder: (buildContext, index) {
                        return RoomGridItem(roomsList[index],false);
                      },
                      itemCount: roomsList.length);
                }
              else
                {
                  List<Room> foundRooms=searchRoom(provider.getToSearch(), roomsList);
                  return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4),
                      itemBuilder: (buildContext, index) {
                        return RoomGridItem(foundRooms[index],false);
                      },
                      itemCount: foundRooms.length);
                }
                }
        return Center(
        child: CircularProgressIndicator(),
        );
          }

      )
    );

  }

}

List<Room> searchRoom(String text, List<Room> roomsList){

  List<Room> foundRooms=[];
  for(int i=0; i< roomsList.length; i++){
    if(roomsList[i].name==text)
      foundRooms.add(roomsList[i]);
  }
  return foundRooms;
}
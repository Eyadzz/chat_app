import 'package:chat_app/home/JoinRoomScreen.dart';
import 'package:chat_app/model/Room.dart';
import 'package:chat_app/roomDetails/RoomDetailsScreen.dart';
import 'package:flutter/material.dart';

class RoomGridItem extends StatelessWidget {
 Room? room;
 RoomGridItem(this.room);
  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: (){
          Navigator.of(context).pushNamed(JoinRoomScreen.routeName,arguments: RoomDetailsArgs(room));
      },
          child: Container(
          padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(top: 10,right: 5,left: 5),
            decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(4,8)
                )
              ]
            ),
            child: Center(
              child: Column(
                children: [
                  Image(image: AssetImage('assets/images/${room!.category}.png'),
                    width: 100,
                    height: 100,)
                  ,SizedBox(height: 10)
                  ,Text(room!.name,style: TextStyle(fontFamily: 'Poppins',fontWeight:FontWeight.bold,fontSize: 14,))
                ],
              ),
            ),
          ),

      );
  }
}

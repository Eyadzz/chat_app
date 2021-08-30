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
        padding: EdgeInsets.all(12),
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
              Image(image: AssetImage('assets/images/${room!.category}.png'),height: 120,fit:BoxFit.fitHeight,)
              ,Text(room!.name,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 24))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:chat_app/model/Room.dart';
import 'package:flutter/material.dart';

class RoomDetailsScreen extends StatelessWidget {

  static const routeName='RoomDetails';
  late Room room;

  @override
  Widget build(BuildContext context) {
    final args=ModalRoute.of(context)?.settings.arguments as RoomDetailsArgs;
    room=args.room!;
    return Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Image(image: AssetImage('assets/images/Group_9672.png'),fit:BoxFit.fill,
            width: double.infinity,height: double.infinity,),
          Scaffold(
            floatingActionButton: FloatingActionButton(
                onPressed: () {  },
                child: Icon(Icons.add)
            ),
            appBar: AppBar(title: Text(room.name)),
            body: Container(
                margin: EdgeInsets.symmetric(vertical:48,horizontal: 24 ),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black12,offset: Offset(4,4))],
                borderRadius:BorderRadius.all(Radius.circular(12)),
    color: Colors.white

                )
    child:Column(
    children: [
      Expanded(child: Container()),
          Row(
            children: [
              TextField(
                decoration: ,
              )
            ],
          )
    ],
              ),

            ),
          )
        ]
    );
  }
}

class RoomDetailsArgs{
  Room? room;
  RoomDetailsArgs(this.room);
}

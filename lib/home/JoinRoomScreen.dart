import 'package:chat_app/model/Room.dart';
import 'package:chat_app/roomDetails/RoomDetailsScreen.dart';
import 'package:flutter/material.dart';

class JoinRoomScreen extends StatefulWidget {
  static const routeName='JoinRoom';


  @override
  _JoinRoomScreenState createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
   late Room room;

   void initState(){
     super.initState();
       this.room.name='The Movies Zone!';
       this.room.description="Lorem ipsum dolor sit amet, consectetur elit,"
           " sed do eiusmod tempor incididunt ut labore et  dolore magna aliqua."
           " Ut enim ad minim veniam,  quis nostrud exercitation ullamco "
           "laboris nisi ut  aliquip ex ea commodo consequat. Duis aute irure ";
       this.room.category='movies';
       this.room.id='1';
       setState(() {

       });
   }

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(vertical:48,horizontal: 24 ),
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black12,offset: Offset(4,4))],
                  borderRadius:BorderRadius.all(Radius.circular(12)),
                  color: Colors.white
              ),
              child:Center(
                child: Column(
                  children: [
                    Text('Hello, Welcome to our chat room'),
                    Text('Join ${room.name}!'),
                    Image.asset('assets/images/${room.category}.png'),
                    Text(room.description),
                    ElevatedButton(onPressed: ()=>joinroom(), child: Text('Join'))
                    ],
                    ),
              )
            ),
            ),
        ]
    );
  }

  void joinroom(){
    ///room joined by account and navigate to the room chat screen
    Navigator.of(context).pushNamed(RoomDetailsScreen.routeName,arguments: RoomDetailsArgs(room));
  }
}

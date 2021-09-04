import 'package:chat_app/tabs/chat/MessageHandler.dart';
import 'package:chat_app/tabs/home/BrowseScreen.dart';
import 'package:chat_app/tabs/home/HomeScreen.dart';
import 'package:chat_app/tabs/home/RoomsScreen.dart';
import 'package:chat_app/utility/DatabaseHelper.dart';
import 'package:chat_app/tabs/chat/RoomDetailsScreen.dart';
import 'package:chat_app/utility/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/DefaultAppBar.dart';
import '../../utility/AppProvider.dart';
import '../../utility/Message.dart';
import '../../utility/Room.dart';


class Chat extends StatefulWidget {
  Chat({Key? key, this.title}) : super(key: key);
  static const routeName = "chat";
  var title;
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String textMessage = '';
  late Room room;
  late CollectionReference<Message> messageRef;
  late AppProvider provider;
  late TextEditingController textMessageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textMessageController = TextEditingController(text: textMessage);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as RoomDetailsArgs;
    room = args.room;
    messageRef = getMessageWithConverter(room.id);
    provider = Provider.of<AppProvider>(context);
    var popUpMenu = PopupMenuButton(
      onSelected: (value)=>Navigator.pushReplacementNamed(context, HomeScreen.routeName),
      itemBuilder:(context) => [
        PopupMenuItem(
          child: Text("Leave Room" , style: TextStyle(fontSize: 14, fontFamily: "Poppins_Bold")),
          value: 1,
        )
      ],
    );
    final Stream<QuerySnapshot<Message>> messageStream = messageRef.orderBy('time').snapshots();
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Image.asset('assets/images/background.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: DefaultAppBar(room.name, popUpMenu),
          body: Container(
            margin: EdgeInsets.symmetric(vertical: 40,horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Message>>(
                    stream: messageStream,
                    builder: (BuildContext buildContext, AsyncSnapshot<QuerySnapshot<Message>> snapshot){
                      if(snapshot.hasError){
                        return Center(child: Text(snapshot.error.toString()),);
                      }else if(snapshot.hasData){
                        return ListView.builder(itemBuilder: (buildContext, index){
                          return MessageHandler(message: snapshot.data!.docs[index].data());
                        },
                        itemCount: snapshot.data?.size??0,
                        );
                      }else{
                        return Center(child: CircularProgressIndicator(),);
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textMessageController,
                        decoration: InputDecoration(
                            hintText: 'Type a Message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        onChanged: (txt){
                          textMessage = txt;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      padding: EdgeInsets.all(5),
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                            padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                            enableFeedback: true,
                          ),
                          onPressed: (){sendMessage();},
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                            child: Row(
                              children: [
                                Text('Send', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                )
                                ),
                                SizedBox(width: 6,),
                                Image.asset('assets/images/submit.png'),
                              ],
                            ),
                          ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  sendMessage(){
    if(textMessage.isEmpty)return;
    else{
      final newMessageObj = messageRef.doc();
      User user = provider.getUser()!;
      final message = Message(id: newMessageObj.id, content: textMessage, time: DateTime.now().microsecondsSinceEpoch
          , senderName: user.username, senderId: user.id);
      newMessageObj.set(message).then((value) {
        setState(() {
          textMessage = '';
          textMessageController.clear();
        });
      });
    }
  }

}

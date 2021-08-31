import 'package:chat_app/components/MessageHandel.dart';
import 'package:chat_app/datebase/Utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AppConfigProvider.dart';
import 'model/Message.dart';
import 'model/Room.dart';


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
  late AppConfigProvider provider;
  late TextEditingController textMessageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textMessageController = TextEditingController(text: textMessage);
  }

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)?.settings.arguments as RoomDetailsArgs;
    //room = args.room!;
    messageRef = getMessageWithConverter('Nsi7EbaO2K2doFmFRIwA');
    provider = Provider.of<AppConfigProvider>(context);
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
          appBar: AppBar(
            title: Text('Chat'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
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
                          return MessageHandel(message: snapshot.data!.docs[index].data());
                        },
                        itemCount: snapshot.data?.size??0,
                        reverse: true,
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
                            hintText: 'Enter Message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 1,horizontal: 8),
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
                            padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                            enableFeedback: true,
                          ),
                          onPressed: sendMessage,
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
      final message = Message(id: newMessageObj.id, content: textMessage, time: DateTime.now().microsecondsSinceEpoch
          , senderName: "abdo", senderId: 'kefmdk');
      newMessageObj.set(message).then((value) {
        setState(() {
          textMessage = '';
          textMessageController.clear();
        });
      });
    }
  }

}
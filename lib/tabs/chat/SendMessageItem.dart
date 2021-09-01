import 'package:chat_app/utility/Message.dart';
import 'package:flutter/material.dart';
class SendMessageItem extends StatefulWidget {
  Message message;
  SendMessageItem({Key? key, required this.message}) : super(key: key);

  @override
  _SendMessageItemState createState() => _SendMessageItemState();
}

class _SendMessageItemState extends State<SendMessageItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(widget.message.getDateFormatted(), style: TextStyle(fontSize: 10, color: Colors.blueGrey),),
          SizedBox(width: 5,),
          Container(
            child: Text(widget.message.content, style: TextStyle(color: Colors.white),),
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

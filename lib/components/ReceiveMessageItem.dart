import 'package:chat_app/model/Message.dart';
import 'package:flutter/material.dart';
class ReceiveMessageItem extends StatefulWidget {
  Message message;
  ReceiveMessageItem({Key? key, required this.message}) : super(key: key);

  @override
  _ReceiveMessageItemState createState() => _ReceiveMessageItemState();
}

class _ReceiveMessageItemState extends State<ReceiveMessageItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(widget.message.senderName, style: TextStyle(fontSize: 14, color: Colors.grey),)
              ),
              Container(
                child: Text(widget.message.content, style: TextStyle(color: Colors.white),),
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
          SizedBox(width: 5,),
          Text(widget.message.getDateFormatted(), style: TextStyle(fontSize: 10, color: Colors.blueGrey),),
        ],
      ),
    );
  }
}

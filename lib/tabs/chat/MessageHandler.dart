import 'package:chat_app/tabs/chat/ReceiveMessageItem.dart';
import 'package:chat_app/tabs/chat/SendMessageItem.dart';
import 'package:chat_app/utility/Message.dart';
import 'package:chat_app/utility/AppProvider.dart';
import 'package:chat_app/utility/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class MessageHandler extends StatelessWidget {
  Message message;
  MessageHandler({Key ?key,required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    User user = provider.getUser()!;
    return message.senderId == user.id ? SendMessageItem(message: message): ReceiveMessageItem(message: message);
  }
}

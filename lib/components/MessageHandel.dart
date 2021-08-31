import 'package:chat_app/AppConfigProvider.dart';
import 'package:chat_app/components/ReceiveMessageItem.dart';
import 'package:chat_app/components/SendMessageItem.dart';
import 'package:chat_app/model/Message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class MessageHandel extends StatelessWidget {
  Message message;
  MessageHandel({Key ?key,required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppConfigProvider>(context);
    return //message?.senderId == provider.user?.id ? SendMessageItem(message: message): ReceiveMessageItem(message: message);
    SendMessageItem(message: message);
  }
}

import 'package:flutter/material.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {

  @override
  final Size preferredSize; // default is 56.0

  DefaultAppBar(this.appbarTitle, this.actions, {Key? key}) : preferredSize = Size.fromHeight(60.0),super(key: key);
  String appbarTitle;
  Widget actions;
  @override
  _DefaultAppBarState createState() => _DefaultAppBarState();
}

class _DefaultAppBarState extends State<DefaultAppBar>{
  var primaryColor = Color.fromRGBO(53,152,219,1);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.appbarTitle, style: TextStyle(fontSize: 20, fontFamily: "Poppins_Bold")),
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        widget.actions
      ],
    );
  }

  }
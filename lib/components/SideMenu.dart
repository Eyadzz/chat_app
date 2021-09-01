import 'package:chat_app/tabs/login/LogInScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);
  static const routeName = 'side menu';

  @override
  _SideMenuState createState() => _SideMenuState();
}



class _SideMenuState extends State<SideMenu> {
  var colorLightTheme = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.fromLTRB(90, 80, 20, 20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(53,152,219,1),
              ),
              child: Text("Chat App!",style: TextStyle(color: Colors.white,fontSize: 24,
                fontFamily: "Poppins_Bold",),),
            ),
            ListTile(
              leading: new Icon(Icons.power_settings_new_rounded, size: 30, color: Colors.black,),
              title: Text("Log out",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: "Poppins",
                  )),
              contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder:  (context) => Login()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
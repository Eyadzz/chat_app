
import 'package:chat_app/components/HomeAppBar.dart';
import 'package:chat_app/components/SideMenu.dart';
import 'package:chat_app/tabs/add_room/AddRoom.dart';
import 'package:chat_app/utility/AppProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'BrowseScreen.dart';
import 'RoomsScreen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AppProvider provider;

  int index = 0;

  late String title;

  List<Widget> homeView = [
    TabBarView(
      children: [
        BrowseScreen(),
        RoomsScreen(),
      ],
    ),
  ];
  var tapBar = const TabBar(
    tabs: [
      Tab(child: const Text(BrowseScreen.routeName),),
      Tab(child: const Text(RoomsScreen.routeName),),
    ],
  );
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    title = 'Chat APP';
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.fill,
              )),
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              drawer: SideMenu(),
              appBar: HomeAppBar("Chat App", tapBar: tapBar,),
              backgroundColor: Colors.transparent,
              floatingActionButton: index == 0 ? FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddRoom.routeName);
                },
                child: Icon(Icons.add),
              ) : null,
              body: homeView[index],
            ),
          ),
        ),
      ],
    );
  }

}
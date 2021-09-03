import 'package:chat_app/components/HomeAppBar.dart';
import 'package:chat_app/components/SideMenu.dart';
import 'package:chat_app/utility/DatabaseHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/utility/Room.dart';
import '../add_room/AddRoom.dart';
import 'RoomGridItem.dart';
class HomeScreen extends StatefulWidget {

  static const String routeName = 'home';
  late CollectionReference<Room> roomCollectionRef;

  HomeScreen() {
    roomCollectionRef = getRoomsCollectionWithConverter();
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late TabController _tabController;
  SideMenu customized = SideMenu();

  @override
  void initState() {
    _tabController = new TabController(length: 1, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.white
        ),
        child: Image.asset(
          'assets/images/bg.png',
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
      Scaffold(
        key: scaffoldKey,
        drawer: customized,
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddRoom.routeName);
            },
            child: Icon(Icons.add)),
        appBar: HomeAppBar("Chat App"),
        body: Column(

          children: [
            TabBar(
              indicatorColor: Colors.white,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              tabs: [
                Tab(
                  child: Text("Rooms",style: TextStyle(fontSize: 16, fontFamily: "Poppins_Bold")),
                ),
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 30, bottom: 12, right: 12, left: 12),
                  child: FutureBuilder<QuerySnapshot<Room>>(
                    future: widget.roomCollectionRef.get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Room>> snapshot) {
                      if (snapshot.hasError) {
                        return Text('something went wrong!');
                      } else if (snapshot.connectionState == ConnectionState.done) {
                        final List<Room> roomsList = snapshot.data?.docs
                                .map((singleDoc) => singleDoc.data())
                                .toList() ??
                            [];
                        return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4),
                            itemBuilder: (buildContext, index) {
                              return RoomGridItem(roomsList[index]);
                            },
                            itemCount: roomsList.length);
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  )),
            ),
          ],
        ),
      )
    ]);
  }
}

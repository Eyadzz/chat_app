import 'package:chat_app/utility/AppProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {

  @override
  final Size preferredSize; // default is 56.0

  HomeAppBar(this.s, {Key? key, this.title, this.tapBar}) : preferredSize = Size.fromHeight(110.0),super(key: key);
  var title;
  String s;
  var tapBar;
  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar>{
  bool isSearching = false;
  var primaryColor = Color.fromRGBO(53,152,219,1);
  late AppProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      title: isSearching?  null : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.s, style: TextStyle(fontSize: 20, fontFamily: "Poppins_Bold")),
        ],
      ),
      centerTitle: isSearching? false : true,
      leading: isSearching? Container() : Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu_rounded, size: 35),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: <Widget>[
        InkWell(
          child: isSearching ? Container(
            width: 380,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,8.0,20,8),
              child: TextField(
                onSubmitted: (toSearch){
                  setState(() {
                    provider.setSearch(toSearch);
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration:  InputDecoration(

                  prefixIcon: IconButton(icon: Icon(Icons.close, color: primaryColor), onPressed: (){setState(() {
                    isSearching=false;
                  });},),
                  suffixIcon: new Icon(Icons.search, color: primaryColor, size: 30,),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Search Room Name",
                  hintStyle:  TextStyle(color: primaryColor,fontWeight: FontWeight.w100,height: 1.04),
                  contentPadding: const EdgeInsets.only(
                      left: 14.0, bottom: 14.0, top: 14.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius:  BorderRadius.circular(25.7),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:  BorderSide(color: Colors.white),
                    borderRadius:  BorderRadius.circular(25.7),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    height: 2,
                  ),
                ),
              ),
            ),
          ) : Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.search_rounded, size: 35,),
          ),
          onTap: () {
            setState(() {
              isSearching = true;
            });
          },
        ),
      ],
      bottom: widget.tapBar,
    );
  }
}
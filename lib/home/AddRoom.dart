import 'package:chat_app/AppProvider.dart';
import 'package:chat_app/database/DatabaseHelper.dart';
import 'package:chat_app/model/Room.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddRoom extends StatefulWidget {
  static const String routeName = 'addRoom';

  @override
  _AddRoomState createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  final _addRoomFormKey = GlobalKey<FormState>();

  String roomName = '';
  String roomDescription = '';

  List <String> roomCategories= ['movies','sports','music'];

  String selectedRoomCategory = 'sports ';

  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: MyThemeData.white,
            ),
            child: Image.asset(
              'assets/images/SignIn1.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(title: Text('Chat App'),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Center(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: MyThemeData.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                        blurRadius: 4,
                        offset: Offset(4, 8), // Shadow position
                      ),
                    ]
                ),
                margin: EdgeInsets.symmetric(vertical: 32,horizontal: 12),
                child: ListView(
                  //    crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Create New Room',style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    ),
                      textAlign: TextAlign.center,
                    ),
                    Image(image: AssetImage('assets/images/group-1824146_1280.png')),
                    Form(
                      key: _addRoomFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (text){
                              roomName = text;
                            },
                            keyboardType: TextInputType.name,

                            decoration: InputDecoration(
                                labelText: 'Enter Room Name',
                                floatingLabelBehavior: FloatingLabelBehavior.auto
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty ) {
                                return 'Please enter Room Name';
                              }
                              if (value.length<3) {
                                return 'Room name must exceed 3 characters';
                              }
                              return null;
                            },
                          ),


                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: DropdownButton(
                              value: selectedRoomCategory,
                              items: roomCategories.map((name) {
                                return   DropdownMenuItem(
                                    value: name,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(name),
                                          )
                                        ],
                                      ),
                                    )
                                );
                              }).toList(),
                              onChanged: (newSelected){
                                setState(() {
                                  selectedRoomCategory = newSelected as String;
                                });
                              },
                              hint:Text("Select item"),
                              style:TextStyle(color:Colors.grey, fontSize: 16),
                              icon: Icon(Icons.arrow_drop_down_outlined),
                              isExpanded: true,
                            ),
                          ),


                          TextFormField(
                            onChanged: (text){
                              roomDescription = text;
                            },
                            decoration: InputDecoration(
                              labelText: 'Enter Room Description',
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (String? value) {
                              if (value == null || value.isEmpty ) {
                                return 'Please enter room Description';
                              }
                              if (value.length<10) {
                                return 'Room name must exceed 10 characters';
                              }
                              return null;
                            },
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,50,10,10),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              )),
                          padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                          minimumSize: MaterialStateProperty.all(Size(40,50)),
                        ),
                          onPressed: (){
                        if(_addRoomFormKey.currentState?.validate()==true){
                          addRoom();
                        }
                      },
                          child: isLoading?Center(child:CircularProgressIndicator() ,):
                          Text('Create')),
                    )

                  ],
                ),
              ),
            ),
          )
        ]);
  }
  void addRoom(){
    setState(() {
      isLoading=true;
    });
    final docRef = getRoomsCollectionWithConverter()
        .doc();
    Room room = Room(id: docRef.id ,
        name: roomName,
        description: roomDescription,
        category: selectedRoomCategory);
    docRef.set(room)
        .then((value) {
      setState(() {
        isLoading=false;
      });
      Fluttertoast.showToast(msg: 'Room Added Successfully',
          toastLength: Toast.LENGTH_LONG);
    });
  }
}
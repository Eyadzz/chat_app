import 'package:flutter/material.dart';
class Chat extends StatefulWidget {
  Chat({Key key, this.title}) : super(key: key);
  static const routeName = "chat";
  var title;
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Image.asset('assets/images/background.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Chat'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          body: Container(
            margin: EdgeInsets.symmetric(vertical: 40,horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(

                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Enter Message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 1,horizontal: 8),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      padding: EdgeInsets.all(5),
                      child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                            padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                            enableFeedback: true,
                          ),
                          onPressed: (){},
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                            child: Row(
                              children: [
                                Text('Send', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                )
                                ),
                                SizedBox(width: 6,),
                                Image.asset('assets/images/submit.png'),
                              ],
                            ),
                          ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

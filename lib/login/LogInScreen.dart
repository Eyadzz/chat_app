import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static const String routeName = 'login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginFormKey = GlobalKey<FormState>();

  String email = '';

  String password = '';

  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
         // child: Image(image: AssetImage('assets/images/Group_9672.png'),fit:BoxFit.fill,
           // width: double.infinity,height: double.infinity,),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            //title: Text('Login',style:TextStyle(color: Colors.black)), // 20 bold white
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: Text("Welcome Back!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,),),//24 bold poppins
                ),
                Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: TextFormField(
                            onChanged: (newValue) {
                              email = newValue;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email', //12 poppins regular
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: TextFormField(
                            onChanged: (newValue) {
                              password = newValue;
                            },
                            decoration: InputDecoration(
                              labelText: 'Password', //12 poppins regular
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0,0,0,20),
                  child: InkWell(
                    onTap: (){
                    },
                    child: Container(
                      child: Text("Forgot password?",style: TextStyle(fontSize: 12, fontFamily: "Poppins"),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0,0,0,20),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0,0,0,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  //14 Poppins Semibold
                ),
                InkWell(
                  onTap: (){
                  },
                  child: Container(
                    child: Text("Or Create My Account",style: TextStyle(fontSize: 14, fontFamily: "Poppins"),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void logInAccount() {
    if (_loginFormKey.currentState?.validate() == true) {
      authLogin();
    }
  }

  void authLogin() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      showErrorMessage("Logged in successfully");
    } on FirebaseAuthException catch (e) {
     showErrorMessage(e.message ?? "Email or Password is wrong please try again");
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('ok'))
            ],
          );
        });
  }
}

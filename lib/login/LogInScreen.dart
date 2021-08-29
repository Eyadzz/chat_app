import 'package:flutter/material.dart';


class Login extends StatelessWidget {
  static const String routeName = 'login';
  final _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Image.asset('assets/images/top_icon.png',
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Text('Login'),
          backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(key: _loginFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'User Name',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please enter username';
                          }
                          return null;
                        }
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please enter password';
                            }
                            return null;
                          }
                      ),
                    ],
                  ),
                ),
                ElevatedButton(onPressed: null, child:Text('Sign In')),
              ],
            ),
          ),
        ),
      ],
    );
  }


}

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
  bool isLoading = false;
  bool isPasswordHidden = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Image.asset(
            'assets/images/bg.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Login",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            padding: EdgeInsets.all(12),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                     Container(
                       child: Text(
                         "Welcome Back!",
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 24,
                           color:Color.fromRGBO(48,48,48,1),
                         ),
                       ),
                     ),
                    const SizedBox(height: 10,),
                    Form(
                        key: _loginFormKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 10,),
                            TextFormField(
                              onChanged: (value){
                                email=value;
                              },
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                labelText: "Email",
                                labelStyle: TextStyle(color: Color.fromRGBO(121, 121, 121, 1),fontSize: 12,fontWeight: FontWeight.w400,fontFamily: "Poppins",),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10,),
                            TextFormField(
                              obscureText: isPasswordHidden ? true : false,
                              onChanged: (value){
                                password=value;
                              },
                              decoration: InputDecoration(
                                suffixIcon:IconButton(
                                  icon: Icon(isPasswordHidden? Icons.visibility_off_outlined : Icons.visibility_outlined),
                                  onPressed: (){
                                    isPasswordHidden = !isPasswordHidden;
                                    setState(() {});
                                  },
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                labelText: "Password",
                                labelStyle: TextStyle(color: Color.fromRGBO(121, 121, 121, 1),fontSize: 12,fontWeight: FontWeight.w400,fontFamily: "Poppins",),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                            ),
                            Container(

                              padding: EdgeInsets.fromLTRB(0, 30, 240, 0),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  child: Text(
                                    "Forgot password?",
                                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400, fontFamily: "Poppins",color:Color.fromRGBO(48,48,48,1),),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40,),
                            isLoading? Center(
                                child: CircularProgressIndicator()
                            ) : ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(53,152,219,1)),
                                  shadowColor: MaterialStateProperty.all<Color>(Colors.black)),
                              onPressed: logInAccount,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 14, fontFamily: "Poppins",),)
                                    ),
                                    Icon(
                                      Icons.arrow_forward_outlined,
                                      color: Colors.white,
                                    ),

                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0,40,0,0),
                      child: InkWell(
                        onTap: (){},
                        child: Text("Or Create My Account", style: TextStyle(fontSize: 14,color: Color.fromRGBO(80,80,80,1),fontWeight: FontWeight.w300, fontFamily: "Poppins"),
                        )
                      ),
                    ),
                  ],
                ),
              ),
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
      showErrorMessage(
          e.message ?? "Email or Password is wrong please try again");
    } catch (e) {
    }
  }

  showErrorMessage(String msg) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok"))
            ],
          );
        });
  }

}

import 'package:chat_app/Home.dart';
import 'package:chat_app/utility/UserProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../utility/User.dart' as Users;

class RegistrationScreen extends StatefulWidget {
  static const String routeName = 'Register';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String username='';
  String password='';
  String email='';
  bool isLoading = false;
  bool isPasswordSecured = true;
  final database = FirebaseFirestore.instance;
  var labelTextStyle = TextStyle(fontSize: 12, fontFamily: "Poppins", height: -1.5);
  var buttonTextStyle = TextStyle(fontSize: 14, fontFamily: "Poppins", color: Colors.grey);
  late UserProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UserProvider>(context);
    return Stack(
      children: [
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Create Account",
              style: TextStyle(
                fontSize: 25,
                fontFamily: "Poppins_Bold",
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
                    const SizedBox(height: 100,),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              onChanged: (value){
                                username=value;
                              },
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                labelText: "Username",
                                labelStyle: labelTextStyle,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a username';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12,),
                            TextFormField(
                              onChanged: (value){
                                email=value;
                              },
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                labelText: "Email Address",
                                labelStyle: labelTextStyle,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12,),
                            TextFormField(
                              obscureText: isPasswordSecured ? true : false,
                              onChanged: (value){
                                password=value;
                              },
                              decoration: InputDecoration(
                                suffixIcon:IconButton(
                                    icon: Icon(isPasswordSecured? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                    onPressed: (){
                                      isPasswordSecured = !isPasswordSecured;
                                      setState(() {});
                                    },
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                labelText: "Password",
                                labelStyle: labelTextStyle,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 120,),
                            isLoading? Center(
                              child: CircularProgressIndicator()
                            ) : ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  shadowColor: MaterialStateProperty.all<Color>(Colors.black)),
                              onPressed: createAccount,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text("Create Account",style: buttonTextStyle,)
                                    ),
                                    Icon(
                                      Icons.arrow_forward_outlined,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void createAccount(){
    if(_formKey.currentState!.validate())
      {
        validateUser();
      }
  }

  validateUser()async{
    setState(() {
      isLoading=true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      final usersCollectionRef = database.collection(Users.User.COLLECTION_NAME).withConverter<Users.User>(
        fromFirestore: (snapshot, _) => Users.User.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

      final newUser = Users.User(id: userCredential.user!.uid,username: username,email: email,password: password);
      usersCollectionRef.add(newUser).then((value){
        provider.updateUser(newUser);
        Navigator.of(context).pushReplacementNamed(Home.routeName);
      });

      showErrorMessage("Account created successfully");

    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.message!);
    } catch (e) {
      //print(e);
    }
    setState(() {
      isLoading=false;
    });
  }

  showErrorMessage(String msg){
    showDialog(
        context: context,
        builder: (buildContext){
          return AlertDialog(
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Ok")
              )
            ],
          );
        });
  }

}

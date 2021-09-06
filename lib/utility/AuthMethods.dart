import 'package:chat_app/components/AlertMessages.dart';
import 'package:chat_app/tabs/home/HomeScreen.dart';
import 'package:chat_app/utility/AppProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_app/tabs/login/LogInScreen.dart';
import 'DatabaseHelper.dart';


class CheckLogin extends StatefulWidget {
  const CheckLogin({Key? key}) : super(key: key);
  static const routeName = 'checkLogin';
  @override
  _CheckLoginState createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    loginWithPreference(true, provider,context);
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/logo@3x.png',width: 100, height: 100,),
          )
        ],
      ),
    );
  }
}


void authLogin(email, password, isLoading, provider,context) async {
  SharedPreferences preference = await SharedPreferences.getInstance();
  try {
    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if(userCredential.user==null)
    {
      showErrorMessage("User does not exist",context);
      isLoading = false;
    }
    else{
      getUsersCollection().doc(userCredential.user!.uid).get().then((user) {
        provider.updateUser(user.data());
        preference.setBool('login', true);
        preference.setString('email', user.data()!.email);
        preference.setString('password', user.data()!.password);
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    }
  } on FirebaseAuthException catch (e) {
    isLoading = false;
    showErrorMessage(e.message ?? "Email or Password is wrong please try again",context);
  } catch (e) {
  }
}


void loginWithPreference(isLoading, provider, context) async{
  SharedPreferences preference = await SharedPreferences.getInstance();
  if(preference.getBool('login') == true){
    var email = preference.getString('email')!;
    var password = preference.getString('password')!;
    authLogin(email, password, isLoading, provider,context);
  }else{
    Navigator.pushReplacementNamed(context, Login.routeName);
  }
}
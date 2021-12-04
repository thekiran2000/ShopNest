import 'dart:convert';



//import 'package:agriease/pages/signup.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopnest/pages/register.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}

class _LoginState extends State<Login> {
  final _formkey=GlobalKey<FormState>();
  var Email,Password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [

              Colors.limeAccent[200],

              Colors.teal[300],

            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 50,),

//            Text("Improving",style: GoogleFonts.courgette(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green[900]),),
//            Text("Agriculture for lives",style: GoogleFonts.courgette(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.green[900]),),
            SizedBox(height: 45,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Sign In",style: GoogleFonts.zillaSlab(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.green[900]
                ),),
                InkWell(onTap:(){
                  Navigator.pushReplacement(context, SlideRightRoute(page: Signup()));
                },child: Container(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Sign Up",style: GoogleFonts.zillaSlab(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green[900]),),
                ))),
              ],
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35.0,35,35,15),
                    child: TextFormField(
                      decoration: InputDecoration(icon:Icon(Icons.mail,color: Colors.white60,),labelText: "Email",labelStyle: GoogleFonts.zillaSlab(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green[900])),
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.zillaSlab(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green[900]),
                      validator: (value){
                        if(value.isEmpty || !value.contains('@')){
                          return 'Invalid email format';
                        }
                        return null;
                      },
                      onSaved: (value){
                        Email=value;
                      },
                    ),
                  )
                  ,Padding(
                    padding: const EdgeInsets.fromLTRB(35.0,15,35,15),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(icon:Icon(Icons.lock,color: Colors.white60,),labelText: "Password",labelStyle: GoogleFonts.zillaSlab(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green[900])),
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.zillaSlab(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green[900]),
                      validator: (value){
                        if(value.isEmpty || value.length <= 5 ){
                          return 'Password must contain minimum 6 characters';
                        }
                        return null;
                      },
                      onSaved: (value){
                        Password=value;
                      },
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: 320,
                    child: RaisedButton(
                      onPressed: signin,
                      color:Colors.green[100],
                      child: Text("SIGN IN",
                        style: GoogleFonts.zillaSlab(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueGrey[900]),
                      ),
                    ),
                  ),
                ],
              ),
            ),



          ],
        ),
      ),

    );
  }

  Future<void> signin() async{
    final formState=_formkey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: Email, password: Password);
        Navigator.pushReplacementNamed(context, '/home');
        //TODO : Navigate to home
      }catch(e){
        print(e.message);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Center(child: Text("ERROR OCCURED!!!",style: GoogleFonts.zillaSlab(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.red[400]),)),
                content: Text(e.message,style: GoogleFonts.zillaSlab(fontSize: 20,fontWeight: FontWeight.bold),),
                actions: [
                  FlatButton(
                    child: Text("Ok",style: GoogleFonts.zillaSlab(fontSize: 22,fontWeight: FontWeight.bold),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    }
  }
}
